//
//  MMActivityViewController.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h>

@interface MMActivityViewController : UIViewController<YMKMapViewDelegate>
@property(nonatomic,strong) NSArray *activities;
- (IBAction)pressBack:(id)sender;
@end
