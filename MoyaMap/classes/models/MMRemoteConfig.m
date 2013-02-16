//
//  MMRemoteConfig.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMRemoteConfig.h"

@implementation MMRemoteConfig
static MMRemoteConfig *defaultConfig = nil;


+ (MMRemoteConfig *) defaultConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      MMRemoteConfig  *newConfig = [[MMRemoteConfig  alloc] init];
                      [newConfig useAsDefault];
                  });
    
	return defaultConfig;
}
- (void) useAsDefault
{
    defaultConfig = self;
}

@end
