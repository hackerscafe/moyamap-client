//
//  MMViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMViewController.h"
#import "MMCommon.h"
#import "MMMoyaTag.h"

@interface MMViewController (){
    YMKMapView *_map;
    NSArray *_tags;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMap];
    [MMMoyaTag fetchAsync:^(NSArray *allRemote, NSError *error) {
        [self setMoyas:allRemote];
    }];
    self.menuView.center = CGPointMake(-(SCREEN_BOUNDS.size.width / 2), SCREEN_BOUNDS.size.height - self.menuView.frame.size.height);
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
        MMMoyaImage *moya = [[MMMoyaImage alloc] initWithTitle:tag.name andDelegate:self];
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
    [self performSegueWithIdentifier:@"showTagView" sender:self];
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

- (IBAction)pressGPS:(id)sender {
    NSLog(@"gps");
}
@end
