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

/**
 // read data from specified URI
 */
+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock{

    NSString *strurl = [NSString stringWithFormat:@"%@%@", [MMRemoteConfig defaultConfig].baseurl, [[self class] performSelector:@selector(representUrl)]];
    LOG(@"call:%@", strurl);
    [[self class] performSelector:@selector(fetchURL:async:) withObject:strurl withObject:completionBlock];
}
/**
 // read data from specified URI with parameters
 */
+(void)fetchAsyncWithParams:(NSDictionary *)params async:(MMFetchCompletionBlock)completionBlock{
    NSString *path = [[self class] performSelector:@selector(representUrl)];
    for (NSString *key in [params allKeys]){
        if ([path rangeOfString:@"?"].location == NSNotFound){
            path = [path stringByAppendingFormat:@"?%@=%@", key, [params objectForKey:key]];
        }else{
            path = [path stringByAppendingFormat:@"&%@=%@", key, [params objectForKey:key]];
        }
    }
    
    NSString *strurl = [NSString stringWithFormat:@"%@%@", [MMRemoteConfig defaultConfig].baseurl, path];
    LOG(@"call:%@", strurl);
    [[self class] performSelector:@selector(fetchURL:async:) withObject:strurl withObject:completionBlock];
}
+(void)fetchURL:(NSString *)strurl async:(MMFetchCompletionBlock)completionBlock{
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
#pragma mark -
#pragma mark internal method
/**
 // parse JSONArray and create class instance
 */
+(NSArray *)parseJSONArray:(NSArray *)array{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dict in array){
        id obj = [[[self class] alloc] init];
        [obj performSelector:@selector(setPropertiesUsingRemoteDictionary:) withObject:dict];
        [ret addObject:obj];
    }
    return [[NSArray alloc] initWithArray:ret];
}
- (void) setPropertiesUsingRemoteDictionary:(NSDictionary *)dict
{
    if ([dict objectForKey:@"id"]){
        self.remoteId = [dict objectForKey:@"id"];
    }
    NSDictionary *props = [MMPropertyUtil classPropsFor:[self class]];
    for (NSString *key in [props allKeys]){
        NSLog(@"key:%@", key);
        if ([dict objectForKey:key]){
            [self setValue:[dict objectForKey:key] forKey:key];
        }
    }
    
}

#pragma mark -
#pragma mark below methods shoul be doverride in a subclass
+(NSString *)representUrl{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
+(NSString *)resultKey{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
