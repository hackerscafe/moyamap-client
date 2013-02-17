//
//  YMKMapView+RegionUtil.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "YMKMapView+RegionUtil.h"

@implementation YMKMapView(RegionUtil)

- (void)fitRegionToCurrentAnnotations{
    if (self.annotations.count == 0) return;
    id<YMKAnnotation> ano = [self.annotations objectAtIndex:0];
    
    CLLocationCoordinate2D upper = ano.coordinate;
    CLLocationCoordinate2D lower = ano.coordinate;
    

    for (id<YMKAnnotation> ano in self.annotations){
        if(ano.coordinate.latitude > upper.latitude) upper.latitude = ano.coordinate.latitude;
        if(ano.coordinate.latitude < lower.latitude) lower.latitude = ano.coordinate.latitude;
        if(ano.coordinate.longitude > upper.longitude) upper.longitude = ano.coordinate.longitude;
        if(ano.coordinate.longitude < lower.longitude) lower.longitude = ano.coordinate.longitude;
    }
    // FIND REGION
    YMKCoordinateSpan locationSpan;
    locationSpan.latitudeDelta = upper.latitude - lower.latitude;
    locationSpan.longitudeDelta = upper.longitude - lower.longitude;
    CLLocationCoordinate2D locationCenter;
    locationCenter.latitude = (upper.latitude + lower.latitude) / 2;
    locationCenter.longitude = (upper.longitude + lower.longitude) / 2;
    
    YMKCoordinateRegion region = YMKCoordinateRegionMake(locationCenter, locationSpan);
    [self setRegion:region];
}

@end