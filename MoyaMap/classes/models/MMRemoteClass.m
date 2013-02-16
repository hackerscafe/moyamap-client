//
//  MMRemoteClass.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMRemoteClass.h"
#import "MMRemoteConfig.h"
#import "AFNetworking.h"

@implementation MMRemoteClass


+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock{

    NSString *strurl = [NSString stringWithFormat:@"%@%@", [MMRemoteConfig defaultConfig].baseurl, [[self class] performSelector:@selector(representUrl)]];
    LOG(@"call:%@", strurl);
    NSURL *url = [NSURL URLWithString:strurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"App.net Global Stream: %@", JSON);
    } failure:nil];
    [operation start];
    
}

+(NSString *)representUrl{
    return @"";
}

@end
