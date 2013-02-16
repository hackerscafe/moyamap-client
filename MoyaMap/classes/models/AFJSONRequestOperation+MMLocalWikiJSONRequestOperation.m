//
//  MMLocalWikiJSONRequestOperation.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "AFJSONRequestOperation+MMLocalWikiJSONRequestOperation.h"

@implementation AFJSONRequestOperation(MMLocalWikiJSONRequestOperation)
+ (NSSet *)acceptableContentTypes {
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"application/vnd.api.v1+json", nil];
}

@end
