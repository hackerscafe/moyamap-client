//
//  MMViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMViewController.h"
#import "MMCommon.h"


@interface MMViewController (){
    YMKMapView *_map;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMap];
    [self addMoya];
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

    [self.view addSubview:_map];
}
- (void)addMoya{
    UIButton *moya = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:@"moya"];
    CGRect rect = CGRectZero;
    [moya setImage:img forState:UIControlStateNormal];
    rect.size = img.size;
    moya.frame = rect;
    [_map addSubview:moya];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOverlayView:nil];
    [super viewDidUnload];
}
@end
