//
//  MMMoyaViewController.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMMoyaTag;

@protocol MMMoyaViewControllerDelegate <NSObject>


@end

@interface MMMoyaViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) MMMoyaTag *moyatag;
- (IBAction)pressClose:(id)sender;

@end
