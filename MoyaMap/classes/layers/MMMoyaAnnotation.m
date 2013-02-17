//
//  MMMoyaAnnotaion.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaAnnotation.h"

@implementation MMMoyaAnnotation
//初期化処理
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle {
    if (self=[super init]) {
        _coordinate.latitude = coord.latitude;
        _coordinate.longitude = coord.longitude;
        _annotationTitle = annTitle;
        _annotationSubtitle = annSubtitle;
    }
    return self;
}

//タイトル
- (NSString *)title
{
    return _annotationTitle;
}

//サブタイトル
- (NSString *)subtitle
{
    return _annotationSubtitle;
}
@end
