//
//  YDNetworkManager.m
//  YDNetwork
//
//  Created by liuty on 14-8-7.
//  Copyright (c) 2014年 Netease Youdao. All rights reserved.
//

#import "YDNetworkManager.h"

@implementation YDNetworkManager

#pragma mark -
#pragma mark initialization

+ (instancetype)sharedManager
{
    static YDNetworkManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[YDNetworkManager alloc] initWithBaseURL:nil];
    });
    return _manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    //use super defaults
    self = [super initWithBaseURL:url];
    if (self) {
        //some specific init...
        self.downloadQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Reachability

- (BOOL)isReachable
{
    return [self.reachabilityManager isReachable];
}

- (YDNetworkReachabilityStatus)networkReachabilityStatus
{
    YDNetworkReachabilityStatus status = YDNetworkReachabilityStatusUnknown;
    switch (self.reachabilityManager.networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            status = YDNetworkReachabilityStatusNotReachable;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            status = YDNetworkReachabilityStatus3G;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            status = YDNetworkReachabilityStatusWiFi;
            break;
        default:
            break;
    }
    return status;
}

#pragma mark -
#pragma mark HTTP Request Methods

- (YDNetworkRequestOperation *)getJSONFromURL:(NSString *)url
                                   parameters:(NSDictionary *)parameters
                                     priority:(NSOperationQueuePriority)priority
                                      success:(void (^)(id))success
                                      failure:(void (^)(NSError *))failure
{
    //set JSON Serialization
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    YDNetworkRequestOperation *operation = [self requestOperationWithRequest:request success:^(YDNetworkRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(YDNetworkRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    operation.queuePriority = priority;
    
    [self.operationQueue addOperation:operation];
    return operation;
}

- (YDNetworkRequestOperation *)getXMLFromURL:(NSString *)url
                                  parameters:(NSDictionary *)parameters
                                    priority:(NSOperationQueuePriority)priority
                                     success:(void (^)(NSXMLParser *))success
                                     failure:(void (^)(NSError *))failure
{
    //set XML Serialization
    self.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    YDNetworkRequestOperation *operation = [self requestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    operation.queuePriority = priority;
    
    [self.operationQueue addOperation:operation];
    return operation;
}

- (YDNetworkRequestOperation *)getImageFromURL:(NSString *)url
                                    parameters:(NSDictionary *)parameters
                                      priority:(NSOperationQueuePriority)priority
                                       success:(void (^)(UIImage *))success
                                       failure:(void (^)(NSError *))failure
{
    //set image Serialization
    self.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    YDNetworkRequestOperation *operation = [self requestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    operation.queuePriority = priority;
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

#pragma mark -
#pragma mark Internal Method
- (YDNetworkRequestOperation *)requestOperationWithRequest:(NSURLRequest *)request
                                                   success:(void (^)(YDNetworkRequestOperation *operation, id responseObject))success
                                                   failure:(void (^)(YDNetworkRequestOperation *operation, NSError *error))failure
{
    YDNetworkRequestOperation *operation = [[YDNetworkRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    __strong YDNetworkRequestOperation *wOperation = operation;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(wOperation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(wOperation, error);
    }];
    
    return operation;
}

#pragma mark -
#pragma mark Downloading Request Methods

- (YDDownloadRequestOperation *)downloadFromURL:(NSString *)url
                                     parameters:(NSDictionary *)parameters
                                     targetPath:(NSString *)path
                                       progress:(void (^)(long long, long long))progress
                                        success:(void (^)(id))success
                                        failure:(void (^)(NSError *))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    YDDownloadRequestOperation *operation = [[YDDownloadRequestOperation alloc] initWithRequest:request targetPath:path shouldResume:YES];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        progress(totalBytesReadForFile, totalBytesExpectedToReadForFile);
    }];
    
    [self.downloadQueue addOperation:operation];
    
    return operation;
}

#pragma mark -
#pragma mark Cancel

- (void)cancelAllRequest
{
    [self.operationQueue cancelAllOperations];
}

- (void)cancelAllDownload
{
    [self.downloadQueue cancelAllOperations];
}

@end
