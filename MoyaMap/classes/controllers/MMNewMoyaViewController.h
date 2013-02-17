//
//  MMNewMoyaViewController.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MMNewMoyaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textTag;
@property (strong, nonatomic) FBPlacePickerViewController *placePickerController;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (nonatomic) CLLocation *lastLocation;
- (IBAction)pressClose:(id)sender;
- (IBAction)pressPlace:(id)sender;
- (IBAction)pressMoya:(id)sender;

@end
