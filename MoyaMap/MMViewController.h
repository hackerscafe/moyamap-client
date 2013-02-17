//
//  MMViewController.h
//  MoyaMap
//

//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート
#import <FacebookSDK/FacebookSDK.h>
#import <CoreLocation/CoreLocation.h>
#import "MMMoyaImage.h"
#import "MMLoginViewController.h"

@interface MMViewController : UIViewController<YMKMapViewDelegate,UITextFieldDelegate,MMMoyaImageDelegate,MMLoginViewControllerDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

- (IBAction)toggleMenu:(id)sender;
- (IBAction)pressGPS:(id)sender;
- (IBAction)menuPressed:(id)sender;


@end
