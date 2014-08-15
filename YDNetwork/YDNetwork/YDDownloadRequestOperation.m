//
//  YDDownloadRequesOperation.m
//  YDNetwork
//
//  Created by liuty on 14-8-11.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "YDDownloadRequestOperation.h"

@implementation YDDownloadRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest targetPath:(NSString *)targetPath shouldResume:(BOOL)shouldResume
{
    self = [super initWithRequest:urlRequest targetPath:targetPath shouldResume:shouldResume];
    if (self) {
        
    }
    return self;
}

- (void)cancel
{
    [super cancel];
    [self deleteTempFileWithError:nil];
}

@end
