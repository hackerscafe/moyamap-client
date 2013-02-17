//
//  MMMoyaImage.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaImage.h"
#import "MMMoyaTag.h"

#define IMAGE_MARGIN 18.0f

@interface MMMoyaImage(){
    UIImage *_image_on;
    UIImage *_image_off;
    CGPoint startLocation2;
    CGPoint startLocation;
}
@end

@implementation MMMoyaImage


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        _image_off = [UIImage imageNamed:@"moya"];
        _image_on = [UIImage imageNamed:@"moya_on"];
    }
    return self;
}
-(id)initWithMoya:(MMMoyaTag*)moyatag andDelegate:(id<MMMoyaImageDelegate>)delegate{
    self = [self initWithMoya:moyatag];
    self.delegate = delegate;
    return self;
}
- (id) initWithMoya:(MMMoyaTag *)moyatag{
    self = [self initWithFrame:CGRectZero];
    NSString *title = moyatag.name;
    self.moyatag = moyatag;
    self.image = [[UIImageView alloc] initWithImage:_image_off];
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
- (void)selectTag{
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(4, 4);
    } completion:^(BOOL finished){
        [_delegate moyaTouched:self];
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
#pragma mark -
#pragma mark touches
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    startLocation2 = [[touches anyObject] locationInView:self.superview];
    _image.image = _image_on;
    NSLog(@"start:%f,%f", startLocation2.x,startLocation2.y);
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
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _image.image = _image_off;
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    NSLog(@"dnd:%f,%f", pt.x,pt.y);
    if (pow(startLocation2.x - pt.x,2) < 25 && pow(startLocation2.y - pt.y, 2) < 25){
        [self selectTag];
    }
}
#pragma mark -

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
