//
//  MMMoyaTag.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//
#import "MMRemoteClass.h"


@interface MMMoyaTag : MMRemoteClass

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *resource_uri;
@property(nonatomic,retain) NSString *slug;

+(void)fetchMyTag:(MMFetchCompletionBlock)completionBlock;
+(void)fetchFriendTag:(MMFetchCompletionBlock)completionBlock;

@end
