//
//  YDNetworking.h
//  YDNetwork
//
//  Created by 刘廷勇 on 14-8-15.
//  Copyright (c) 2014年 网易有道. All rights reserved.
//

#ifndef YDNetwork_YDNetworking_h
#define YDNetwork_YDNetworking_h

typedef NS_ENUM(NSInteger, YDNetworkReachabilityStatus) {
    YDNetworkReachabilityStatusUnknown      = -1,
    YDNetworkReachabilityStatusNotReachable = 0,
    YDNetworkReachabilityStatus3G           = 1,
    YDNetworkReachabilityStatusWiFi         = 2,
};

#import "AFHTTPRequestOperationManager.h"
#import "YDNetworkRequestOperation.h"
#import "YDDownloadRequestOperation.h"
#import "YDNetworkManager.h"

#endif
