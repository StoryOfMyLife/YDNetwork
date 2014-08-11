//
//  YDDownloadRequesOperation.h
//  YDNetwork
//
//  Created by 刘廷勇 on 14-8-11.
//  Copyright (c) 2014年 网易有道. All rights reserved.
//

#import "AFDownloadRequestOperation.h"

@interface YDDownloadRequestOperation : AFDownloadRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest targetPath:(NSString *)targetPath shouldResume:(BOOL)shouldResume;

@end
