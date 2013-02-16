//
//  MMRemoteConfig.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMRemoteConfig : NSObject
@property(nonatomic,strong) NSString *baseurl;

+ (MMRemoteConfig *) defaultConfig;
@end
