//
//  YMKMapLayer.h
//
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKTypes.h"
#import "YMKGeometry.h"

@protocol YMKMapLayer <NSObject>
@optional
-(BOOL)existsWithMapType:(YMKMapType)mapType withSpan:(YMKCoordinateSpan)span;
-(BOOL)existsWithMapType:(YMKMapType)mapType withSpan:(YMKCoordinateSpan)span withLevel:(int)level;
-(YMKCoordinateSpan)getMinSpanWithMapType:(YMKMapType)mapType;
-(YMKCoordinateSpan)getMaxSpanWithMapType:(YMKMapType)mapType;
- (void)stop;
@end