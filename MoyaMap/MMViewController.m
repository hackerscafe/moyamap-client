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
    [self addMoya];
    [MMMoyaTag remoteAllAsync:^(NSArray *allRemote, NSError *error) {
        _tags = allRemote;
    }];
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
- (void)addMoya{
    
    MMMoyaImage *moya = [[MMMoyaImage alloc] initWithTitle:@"定員が可愛い" andDelegate:self];
    MMMoyaImage *moya2 = [[MMMoyaImage alloc] initWithTitle:@"ラーメン" andDelegate:self];
    MMMoyaImage *moya3 = [[MMMoyaImage alloc] initWithTitle:@"ハックデイ" andDelegate:self];
    [_map addSubview:moya];
    [_map addSubview:moya2];
    [_map addSubview:moya3];
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
    [super viewDidUnload];
}
@end
