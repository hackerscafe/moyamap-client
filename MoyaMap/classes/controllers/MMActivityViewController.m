//
//  MMActivityViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMActivityViewController.h"
#import "MMCommon.h"
#import "MMMoyaActivity.h"
#import "MMMoyaAnnotation.h"

@interface MMActivityViewController ()
{
    YMKMapView *_map;

}

@end

@implementation MMActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _map = [[YMKMapView alloc] initWithFrame:SCREEN_BOUNDS appid:YJ_APP_ID];
    _map.mapType = YMKMapTypeStandard;
    _map.delegate = self;
    //地図の位置と縮尺を設定
    MMMoyaActivity *activity = (MMMoyaActivity *)[_activities objectAtIndex:0];
    self.title = [NSString stringWithFormat:@"%@ のモヤ", self.tagname];
    _map.region = YMKCoordinateRegionMake(activity.location, YMKCoordinateSpanMake(0.02, 0.02));
    
    [self.view addSubview:_map];
}
- (void)viewDidAppear:(BOOL)animated{
    [self setPins];
}
- (void)setPins{
    for (MMMoyaActivity *activity in _activities){
        //MyAnnotationの初期化
        MMMoyaAnnotation* myAnnotation = [[MMMoyaAnnotation alloc] initWithLocationCoordinate:activity.location title:activity.location_name subtitle:activity.message];
        //AnnotationをYMKMapViewに追加
        [_map addAnnotation:myAnnotation];
    }
    
}
- (YMKAnnotationView*)mapView:(YMKMapView *)mapView viewForAnnotation:(MMMoyaAnnotation*)annotation{
    //追加されたAnnotationがMyAnnotationか確認
    if( [annotation isKindOfClass:[MMMoyaAnnotation class]] ){
        //YMKPinAnnotationViewを作成
        YMKPinAnnotationView *pin = [[YMKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"Pin"];
        //アイコンイメージの変更
        pin.image=[UIImage imageNamed:@"moyapin.png"];
        //吹き出しに表示するボタンを追加
        UIButton * rightAccessoryButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [rightAccessoryButton setFrame:CGRectMake(0, 0, 29, 29)];
        [rightAccessoryButton setBackgroundImage:[UIImage imageNamed:@"purple_arrow.png"] forState:UIControlStateNormal];
        [pin setRightCalloutAccessoryView:rightAccessoryButton];
        return pin;
    }
    return nil;
}
//吹き出しボタンイベント
- (void)mapView:(YMKMapView*)mapView annotationView:(YMKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //押されたのがどのピンか判定
    NSLog(@"hoge");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressBack:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
@end
