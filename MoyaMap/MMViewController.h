//
//  MMViewController.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート

@interface MMViewController : UIViewController<YMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end
