//
//  YDNetworkManager.h
//  YDNetwork
//
//  Created by liuty on 14-8-7.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "YDNetworkRequestOperation.h"
#import "YDDownloadRequestOperation.h"

typedef NS_ENUM(NSInteger, YDNetworkReachabilityStatus) {
    YDNetworkReachabilityStatusUnknown      = -1,
    YDNetworkReachabilityStatusNotReachable = 0,
    YDNetworkReachabilityStatus3G           = 1,
    YDNetworkReachabilityStatusWiFi         = 2,
};

@interface YDNetworkManager : AFHTTPRequestOperationManager

//------------------------------------------------------------------------------
/**
 *  下载任务的队列
 */
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

//------------------------------------------------------------------------------
/**
 *  Singleton method
 *
 *  @return An shared YDNetworkManager instance
 */
+ (instancetype)sharedManager;

//------------------------------------------------------------------------------
/**
 *  测试网络连接状况
 *
 *  @return YES:有网络 NO:无网络
 */
- (BOOL)isReachable;

//------------------------------------------------------------------------------
/**
 *  网络状态监控
 *
 *  @return 返回明确的网络状态
 */
- (YDNetworkReachabilityStatus)networkReachabilityStatus;

//------------------------------------------------------------------------------
/**
 *  Creates and runs an `YDNetworkRequestOperation` with a `GET` request.
 *
 *  @param url        服务器数据请求的地址, 不能为空
 *  @param parameters 请求所带参数(optional) 可用于代替url中的参数
 *  @param priority   设定请求优先级
 *  @param success    请求成功的返回 responseObject是解析完成的NSDictionary
 *  @param failure    请求失败的返回
 *
 *  @return YDNetworkRequestOperation
 */
- (YDNetworkRequestOperation *)getJSONFromURL:(NSString *)url
                                   parameters:(NSDictionary *)parameters
                                     priority:(NSOperationQueuePriority)priority
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

//------------------------------------------------------------------------------
/**
 *  Creates and runs an `YDNetworkRequestOperation` with a `GET` request.
 *
 *  @param url        服务器数据请求的地址, 不能为空
 *  @param parameters 请求所带参数(optional) 可用于代替url中的参数
 *  @param priority   设定请求优先级
 *  @param success    请求成功的返回 parser是返回的NSXMLParser object
 *  @param failure    请求失败的返回
 *
 *  @return YDNetworkRequestOperation
 */
- (YDNetworkRequestOperation *)getXMLFromURL:(NSString *)url
                                  parameters:(NSDictionary *)parameters
                                    priority:(NSOperationQueuePriority)priority
                                     success:(void (^)(NSXMLParser *parser))success
                                     failure:(void (^)(NSError *error))failure;

//------------------------------------------------------------------------------
/**
 *  Creates and runs an `YDNetworkRequestOperation` with a `GET` request.
 *
 *  @param url        服务器数据请求的地址, 不能为空
 *  @param parameters 请求所带参数(optional) 可用于代替url中的参数
 *  @param priority   设定请求优先级
 *  @param success    请求成功的返回 image
 *  @param failure    请求失败的返回
 
 *  @return YDNetworkRequestOperation
 */
- (YDNetworkRequestOperation *)getImageFromURL:(NSString *)url
                                    parameters:(NSDictionary *)parameters
                                      priority:(NSOperationQueuePriority)priority
                                       success:(void (^)(UIImage *image))success
                                       failure:(void (^)(NSError *error))failure;

//------------------------------------------------------------------------------
/**
 *  Creates and runs an `YDDownloadRequestOperation` with a `GET` request.
 *
 *  @param url        服务器数据请求的地址, 不能为空
 *  @param parameters 请求所带参数(optional) 可用于代替url中的参数
 *  @param path       目标保存路径
 *  @param progress   下载进度的block
 *  @param success    下载成功的block
 *  @param failure    下载失败的block
 *
 *  @return YDDownloadRequestOperation
 */
- (YDDownloadRequestOperation *)downloadFromURL:(NSString *)url
                                     parameters:(NSDictionary *)parameters
                                     targetPath:(NSString *)path
                                       progress:(void (^)(long long totalBytesRead, long long totalBytesExpectedToRead))progress
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure;

//------------------------------------------------------------------------------
/**
 *  取消队列中的所有请求
 */
- (void)cancelAllRequest;

//------------------------------------------------------------------------------
/**
 *  取消所有下载 并删除缓存
 */
- (void)cancelAllDownload;

@end
