//
//  YDDownloadRequesOperation.h
//  YDNetwork
//
//  Created by liuty on 14-8-11.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "AFDownloadRequestOperation.h"

@interface YDDownloadRequestOperation : AFDownloadRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest targetPath:(NSString *)targetPath shouldResume:(BOOL)shouldResume;

@end
