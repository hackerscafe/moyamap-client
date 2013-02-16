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


+(void)fetchAsync:(MMFetchCompletionBlock)completionBlock;

/*
 // should override on subclass
 */
+(NSString *)representUrl;

@end
