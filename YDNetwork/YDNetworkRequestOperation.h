//
//  YDNetworkRequestOperation.h
//  YDNetwork
//
//  Created by liuty on 14-8-11.
//  Copyright (c) 2014年 Netease Youdao. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface YDNetworkRequestOperation : AFHTTPRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest;

@end
