//
//  YDNetworkRequestOperation.m
//  YDNetwork
//
//  Created by liuty on 14-8-11.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "YDNetworkRequestOperation.h"

@implementation YDNetworkRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
{
    self = [super initWithRequest:urlRequest];
    if (self) {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

@end
