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
@property (nonatomic, strong) NSNumber* remoteId;


+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock;
+(void)fetchAsyncWithParams:(NSDictionary *)params async:(MMFetchCompletionBlock)completionBlock;

/*
 // should override on subclass
 */
+(NSString *)representUrl;
+(NSString *)resultKey;
-(void)parseObject:(id)object ForKey:(NSString *)key;

/*
 // internal methods
 */
+(void)fetchURL:(NSString *)strurl async:(MMFetchCompletionBlock)completionBlock;


@end
