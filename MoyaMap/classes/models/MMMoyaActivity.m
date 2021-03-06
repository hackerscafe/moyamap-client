//
//  MMMoyaActivity.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMMoyaActivity.h"
#import "YamlParser.h"

@implementation MMMoyaActivity

//http://moya-map.trick-with.net/api/map_with_page/?format=json&limit=0&page__page_tags__tags__slug=%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3

+(NSString *)representUrl{
    return @"map_with_page/";
}
+(NSString *)resultKey{
    return @"objects";
}

-(void)parseObject:(id)object ForKey:(NSString *)key{
    if ([key isEqualToString:@"page"]){
        [super parseObject:object ForKey:key];
        NSDictionary *page = (NSDictionary *)object;
        NSString *content = [page objectForKey:@"content"];
        content = [[content stringByReplacingOccurrencesOfString:@"<pre>---" withString:@""] stringByReplacingOccurrencesOfString:@"</pre>" withString:@""];
        NSLog(@"content:%@", content);
        NSDictionary *yaml = (NSDictionary *)[YamlParser objectFromString:content];
        self.location_name = [yaml objectForKey:@":location_name"];
        self.message = [yaml objectForKey:@":message"];
        self.user_name = [yaml objectForKey:@":user_name"];
        self.user_id = [yaml objectForKey:@":user_id"];
        self.picture_url = [yaml objectForKey:@":picture_url"];
        self.time = [self parseTime:[yaml objectForKey:@":time"]];
    }else if ([key isEqualToString:@"geom"]){
        NSDictionary *geom = (NSDictionary *)object;
        NSArray *coord = [[[geom objectForKey:@"geometries"] objectAtIndex:0] objectForKey:@"coordinates"];
        self.location = CLLocationCoordinate2DMake((CLLocationDegrees)[[coord objectAtIndex:1] doubleValue],
                                                   (CLLocationDegrees)[[coord objectAtIndex:0] doubleValue]);
        
    }else if ([key isEqualToString:@"location_name"] ||
              [key isEqualToString:@"message"] ||
              [key isEqualToString:@"user_name"] ||
              [key isEqualToString:@"user_id"] ||
              [key isEqualToString:@"picture_url"] ||
              [key isEqualToString:@"time"] ||
              [key isEqualToString:@"geom"] ||
              [key isEqualToString:@"location"]
              ){
        return;
    }else{
        [super parseObject:object ForKey:key];
    }
}
-(NSDate *)parseTime:(NSString *)strtime{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //2010-12-01T21:35:43+0000
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    return [df dateFromString:strtime];
    //return [df dateFromString:[strtime stringByReplacingOccurrencesOfString:@"T" withString:@""]];
}

-(NSString *)strTime{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //2010-12-01T21:35:43+0000
    [df setDateFormat:@"MMM/dd, yyyy"];
    return [df stringFromDate:self.time];
}

@end
