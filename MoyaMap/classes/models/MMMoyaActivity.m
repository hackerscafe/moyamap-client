//
//  MMMoyaActivity.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaActivity.h"

@implementation MMMoyaActivity

//http://moya-map.trick-with.net/api/map_with_page/?format=json&limit=0&page__page_tags__tags__slug=%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3

+(NSString *)representUrl{
    return @"map_with_page/";
}
+(NSString *)resultKey{
    return @"objects";
}

            
@end
