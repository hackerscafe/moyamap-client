//
//  MMViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

#import "MMViewController.h"
#import "MMCommon.h"
#import "MMMoyaTag.h"
#import "MMLoginViewController.h"
#import "MMMoyaViewController.h"
#import "AFNetworking.h"

#define MENU_MYMOYA 0
#define MENU_FRIENDMOYA 1
#define MENU_NEWMOYA 2

@interface MMViewController (){
    YMKMapView *_map;
    NSArray *_tags;
    BOOL isLoaded;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isLoaded = NO;
    [self setMap];
    self.menuView.center = CGPointMake(-(SCREEN_BOUNDS.size.width / 2), SCREEN_BOUNDS.size.height - self.menuView.frame.size.height);
}
- (void)viewDidAppear:(BOOL)animated{
    if (!isLoaded){
        isLoaded = YES;
        [MMMoyaTag fetchAsync:^(NSArray *allRemote, NSError *error) {
            [self setMoyas:allRemote];
        }];

    }
}
- (void)setMap{
    _map = [[YMKMapView alloc] initWithFrame:SCREEN_BOUNDS appid:YJ_APP_ID];
    _map.mapType = YMKMapTypeStandard;
    _map.delegate = self;
    //地図の位置と縮尺を設定
    CLLocationCoordinate2D center;
    center.latitude = 35.6657214;
    center.longitude = 139.7310058;
    _map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(0.02, 0.02));

    [self.view insertSubview:_map belowSubview:self.overlayView];
}
- (void)setMoyas:(NSArray *)moyas{
    for (MMMoyaTag *tag in moyas){
        NSLog(@"resource_uri:%@", tag.resource_uri);
        MMMoyaImage *moya = [[MMMoyaImage alloc] initWithMoya:tag andDelegate:self];
        [_map addSubview:moya];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark -
#pragma mark MMMoyaImageDelegate
-(void)moyaTouched:(id)moya{
    [self performSegueWithIdentifier:@"showTagView" sender:moya];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOverlayView:nil];
    [self setSearchText:nil];
    [self setSearchText:nil];
    [self setMenuView:nil];
    [super viewDidUnload];
}
- (IBAction)toggleMenu:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
    if (self.menuView.frame.origin.x < 0){
        self.menuView.center = CGPointMake(SCREEN_BOUNDS.size.width - (_menuView.frame.size.width / 2), SCREEN_BOUNDS.size.height - self.menuView.frame.size.height);
    }else{
        self.menuView.center = CGPointMake(-(SCREEN_BOUNDS.size.width / 2), SCREEN_BOUNDS.size.height - self.menuView.frame.size.height);
    }
    }];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showLoginView"]) {
        UINavigationController *controller = (UINavigationController *)[segue destinationViewController];
        MMLoginViewController *login = (MMLoginViewController*)controller.topViewController;
        login.delegate = self;
    }else if ([[segue identifier] isEqualToString:@"showTagView"]){
        MMMoyaViewController *moya = (MMMoyaViewController *)[segue destinationViewController];
        moya.moyatag = ((MMMoyaImage *)sender).moyatag;
    }
}

- (void)showLoginView{
    [self performSegueWithIdentifier:@"showLoginView" sender:self];
}

- (IBAction)pressGPS:(id)sender {
    NSLog(@"gps");
}

- (IBAction)menuPressed:(UISegmentedControl*)menu {
    // See if we have a valid token for the current state.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show menu
        if (menu.selectedSegmentIndex == MENU_MYMOYA){
        
        }else if(menu.selectedSegmentIndex == MENU_FRIENDMOYA){
            // for test
            [self logout];
        }
    } else {
        // No, display the login page.
       [self showLoginView];
    }
}
- (void)logout{
    [FBSession.activeSession closeAndClearTokenInformation];
}
- (void)sendAccessToken:(NSString *)token{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            token, @"token", nil
                            ];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:RAILS_APP_PATH]];
    
    [client postPath:@"/user_session" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Response: %@", text);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}
#pragma mark -
#pragma mark Facebook methods
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
       case FBSessionStateOpen: {
           UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            if ([[topViewController modalViewController]
                 isKindOfClass:[UINavigationController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
            NSString *token = session.accessToken;
           [self sendAccessToken:token];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed: {
           UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            if ([[topViewController modalViewController]
                 isKindOfClass:[UINavigationController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
            [FBSession.activeSession closeAndClearTokenInformation];
        }
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
