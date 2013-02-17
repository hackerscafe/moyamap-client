//
//  MMLoginViewController.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMLoginViewControllerDelegate <NSObject>

- (void)openSession;
- (void)cancelSession;

@end

@interface MMLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, unsafe_unretained) id<MMLoginViewControllerDelegate> delegate;
- (IBAction)pressLogin:(id)sender;
- (IBAction)pressClose:(id)sender;

@end
