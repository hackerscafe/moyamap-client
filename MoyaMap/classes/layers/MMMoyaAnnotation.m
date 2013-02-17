//
//  MMMoyaAnnotaion.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaAnnotation.h"

@implementation MMMoyaAnnotation
@synthesize annotationTitle,annotationSubtitle,coordinate;
//初期化処理
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle {
    if (self=[super init]) {
        coordinate.latitude = coord.latitude;
        coordinate.longitude = coord.longitude;
        annotationTitle = annTitle;
        annotationSubtitle = annSubtitle;
    }
    return self;
}

//タイトル
- (NSString *)title
{
    return annotationTitle;
}

//サブタイトル
- (NSString *)subtitle
{
    return annotationSubtitle;
}
@end
