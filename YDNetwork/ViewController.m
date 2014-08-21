//
//  ViewController.m
//  YDNetwork
//
//  Created by _liuty_ on 14-8-6.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "ViewController.h"
#import "YDNetworkManager.h"
#import "IndexModel.h"

#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define MUSICFile [DocumentsDirectory stringByAppendingPathComponent:@"test.mov"]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) YDDownloadRequestOperation *operation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    BOOL isReachable = [[YDNetworkManager sharedManager] isReachable];
    NSString *url = @"http://dict.youdao.com/infoline?";
    NSDictionary *parameters = @{@"apiversion" : @"2",
                                 @"date" : @"2014-08-21",
                                 @"mode" : @"preview",
                                 @"client" : @"mobile",
                                 @"keyfrom" : @"mdict.5.1.1.iphonepro",
                                 @"imei" : @"246fb6ec59b9a3471cae2fb38b040033",
                                 };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    YDNetworkRequestOperation *operation = [[YDNetworkManager sharedManager] getJSONFromURL:url parameters:parameters priority:NSOperationQueuePriorityNormal success:^(id responseObject) {
        IndexModel *model = [[IndexModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"%@", model);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.debugDescription);
    }];
#pragma clang diagnostic pop
    
    [[YDNetworkManager sharedManager].reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3g");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"not reachable");
            default:
                break;
        }
    }];
    
}

#pragma mark -
#pragma mark test for download
- (IBAction)beginDownload:(id)sender{
    NSString *urlStr = @"http://media.animusic2.com.s3.amazonaws.com/Animusic-ResonantChamber480p.mov";
    
    self.operation = [[YDNetworkManager sharedManager] downloadFromURL:urlStr parameters:nil targetPath:MUSICFile progress:^(long long totalBytesRead, long long totalBytesExpectedToRead) {
        float percentDone = totalBytesRead/(float)totalBytesExpectedToRead;
        self.progress.progress = percentDone;
        self.label.text = [NSString stringWithFormat:@"%.2f%%", percentDone * 100];
        NSLog(@"------%f",percentDone * 100);
        NSLog(@"Operation%i: totalBytesReadForFile: %lld", 1, totalBytesRead);
        NSLog(@"Operation%i: totalBytesExpectedToReadForFile: %lld", 1, totalBytesExpectedToRead);
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (IBAction)beginPlay:(id)sender{
    if (self.operation.isPaused) {
        [self.operation resume];
    } else {
        [self.operation pause];
    }    
}
- (IBAction)cancel:(id)sender {
    [self.operation cancel];
    [[YDNetworkManager sharedManager] cancelAllDownload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
