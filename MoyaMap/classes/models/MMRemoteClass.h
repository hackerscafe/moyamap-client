//
//  MMRemoteClass.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/16/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MMFetchCompletionBlock)(NSArray *allRemote, NSError *error);


@interface MMRemoteClass : NSObject
@property (nonatomic, strong, readonly) NSDictionary *remoteAttributes;
@property (nonatomic) int remoteId;


+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock;
+(NSArray *)parseJSONArray:(NSArray *)array;

/*
 // should override on subclass
 */
+(NSString *)representUrl;
+(NSString *)resultKey;

@end
