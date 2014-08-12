//
//  IndexModel.m
//  YDNetwork
//
//  Created by _liuty_ on 14-8-12.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "IndexModel.h"

@implementation TopModel
@end

@implementation DataModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"dataID"}];
}
@end

@implementation IndexModel

+ (JSONKeyMapper *)keyMapper
{
    NSString *date = [IndexModel getToday];
    return [[JSONKeyMapper alloc] initWithDictionary:@{date : @"data"}];
}

+ (NSString*)getToday {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateStyle:NSDateFormatterShortStyle];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    return [dateFormater stringFromDate:[NSDate date]];
}

@end
