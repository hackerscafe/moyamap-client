//
//  MMMoyaImage.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaImage.h"

#define IMAGE_MARGIN 18.0f

@implementation MMMoyaImage


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
    }
    return self;
}
- (id) initWithTitle:(NSString *)title{
    self = [self initWithFrame:CGRectZero];
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moya"]];
    self.frame = _image.frame;
    CGRect tframe = _image.frame;
    tframe.size.width = [self textWidth];
    
    // set title
    self.title = [[UILabel alloc] initWithFrame:tframe];
    UIFont *hirakakuFont = [UIFont fontWithName:@"HiraKakuProN-W6"size:14];
    [_title setFont:hirakakuFont];
    _title.text = title;
    _title.backgroundColor = [UIColor clearColor];
    [_title setTextAlignment:NSTextAlignmentCenter];
    _title.numberOfLines = 0;
    [self adjustTitle];
    [self randomPosition];
    [self addSubview:_image];
    [self addSubview:_title];
    return self;
}
- (float)textWidth{
    CGSize size = _image.frame.size;
    return size.width - (IMAGE_MARGIN * 2);
}
- (void)adjustTitle{
    [_title sizeToFit];
    float height = _image.frame.size.height;
    float theight = _title.frame.size.height;
    float y = (height - theight ) / 2;
    CGRect frame = _title.frame;
    frame.origin.y = y;
    frame.origin.x = IMAGE_MARGIN;
    frame.size.width = [self textWidth];
    _title.frame = frame;
}
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // Move relative to the original touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startLocation.x;
    frame.origin.y += pt.y - startLocation.y;
    [self setFrame:frame];
}

/*
 // set random position
 */
-(void)randomPosition{
    int x = arc4random()% (int)(SCREEN_BOUNDS.size.width - _image.frame.size.width);
    int y = arc4random()% (int)(SCREEN_BOUNDS.size.height - _image.frame.size.height);
    CGRect frame = self.frame;
    frame.origin.x = x;
    frame.origin.y = y;
    self.frame = frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
