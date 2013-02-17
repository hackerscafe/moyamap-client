//
//  MMMoyaImage.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMMoyaImageDelegate <NSObject>

-(void)moyaTouched:(id)moya;

@end

@class MMMoyaTag;

@interface MMMoyaImage : UIView{
}
@property(nonatomic,unsafe_unretained) id<MMMoyaImageDelegate> delegate;
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) MMMoyaTag *moyatag;
-(id)initWithMoya:(MMMoyaTag*)title;
-(id)initWithMoya:(MMMoyaTag*)title andDelegate:(id<MMMoyaImageDelegate>)delegate;
-(void)randomPosition;

@end
