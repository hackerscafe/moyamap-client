//
//  MMMoyaActivity.h
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMRemoteClass.h"

@interface MMMoyaActivity : MMRemoteClass
@property(nonatomic,strong) NSDictionary *geom;
@property(nonatomic,strong) NSDictionary *page;
@property(nonatomic,strong) NSString *location_name;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *user_name;
@property(nonatomic,strong) NSString *user_id;
@property(nonatomic,strong) NSString *picture_url;
@property(nonatomic,strong) NSDate *time;

@end
