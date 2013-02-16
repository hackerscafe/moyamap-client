//
//  MMMoyaImage.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMMoyaImage : UIView{
    CGPoint startLocation;
}
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UILabel *title;
-(id)initWithTitle:(NSString*)title;

@end
