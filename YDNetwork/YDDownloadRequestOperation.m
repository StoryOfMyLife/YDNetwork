//
//  YDDownloadRequesOperation.m
//  YDNetwork
//
//  Created by 刘廷勇 on 14-8-11.
//  Copyright (c) 2014年 网易有道. All rights reserved.
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
