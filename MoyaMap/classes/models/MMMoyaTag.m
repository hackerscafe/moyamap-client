//
//  MMMoyaTag.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaTag.h"
#import "MMRemoteConfig.h"

@implementation MMMoyaTag

+(NSString *)representUrl{
    return @"get_user_tags?user_type=all";
}
+(NSString *)resultKey{
    return @"objects";
}

+(void)fetchMyTag:(MMFetchCompletionBlock)completionBlock{
    NSString *url = [[MMRemoteConfig defaultConfig].baseurl stringByAppendingString:@"get_user_tags?user_type=me" ];
    [MMMoyaTag fetchURL:url async:completionBlock];
}
+(void)fetchFriendTag:(MMFetchCompletionBlock)completionBlock{
    NSString *url = [[MMRemoteConfig defaultConfig].baseurl stringByAppendingString:@"get_user_tags?user_type=friend" ];
    [MMMoyaTag fetchURL:url async:completionBlock];
}
@end
