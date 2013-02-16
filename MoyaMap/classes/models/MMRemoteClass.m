//
//  MMRemoteClass.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//
#import <objc/runtime.h>

#import "MMRemoteClass.h"
#import "MMRemoteConfig.h"
#import "AFNetworking.h"
#import "MMPropertyUtil.h"
#import "AFJSONRequestOperation+MMLocalWikiJSONRequestOperation.h"

@implementation MMRemoteClass


+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock{

    NSString *strurl = [NSString stringWithFormat:@"%@%@", [MMRemoteConfig defaultConfig].baseurl, [[self class] performSelector:@selector(representUrl)]];
    LOG(@"call:%@", strurl);
    NSURL *url = [NSURL URLWithString:strurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"App.net Global Stream: %@", JSON);
        NSArray *ret = [[self class] parseJSONArray:[JSON valueForKeyPath:[[self class] performSelector:@selector(resultKey)]]];
        completionBlock(ret,nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"App.net Error: %@", [error localizedDescription]);
        completionBlock(nil,error);
    }];
    [operation start];
    
}
+(NSArray *)parseJSONArray:(NSArray *)array{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dict in array){
        id obj = [[[self class] alloc] init];
        [obj performSelector:@selector(setPropertiesUsingRemoteDictionary:) withObject:dict];
        [ret addObject:obj];
    }
    return [[NSArray alloc] initWithArray:ret];
}
#pragma mark -
#pragma mark internal method
- (void) setPropertiesUsingRemoteDictionary:(NSDictionary *)dict
{
    if (dict)
        _remoteAttributes = dict;
    NSDictionary *props = [MMPropertyUtil classPropsFor:[self class]];
    for (NSString *key in [props allKeys]){
        NSLog(@"key:%@", key);
        if ([dict objectForKey:key]){
            [self setValue:[dict objectForKey:key] forKey:key];
        }
    }
    
}

#pragma mark -
#pragma mark shouldoverride
+(NSString *)representUrl{
    return @"";
}
+(NSString *)resultKey{
    return @"";
}

@end
