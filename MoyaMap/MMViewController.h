//
//  MMViewController.h
//  MoyaMap
//

//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート
#import "MMMoyaImage.h"

@interface MMViewController : UIViewController<YMKMapViewDelegate,UITextFieldDelegate,MMMoyaImageDelegate>
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;


@end
