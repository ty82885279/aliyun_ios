//
//  AppDelegate.m
//  aliyun_ios
//
//  Created by MrLee on 2021/2/22.
//

#import "AppDelegate.h"
#import <AliyunOSSiOS/OSSService.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    OSSClient * client;
    NSString *endpoint = @"https://oss-cn-shanghai.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSAuthCredentialProvider alloc] initWithAuthServerUrl:@"https://www.lee2code.com:8003/token" ];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    

    OSSPutObjectRequest * request = [OSSPutObjectRequest new];
    request.bucketName = @"ty82885279";
    request.objectKey = @"ty/dev/123.jpeg";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"jpeg"];;
    
    
    NSURL * fileURL = [NSURL fileURLWithPath:filePath];
    
    request.uploadingFileURL = fileURL;
//    // 设置回调参数
    request.callbackParam = @{
                              @"callbackUrl": @"https://www.lee2code.com:8003/callback",
                              @"callbackBody": @"filename=${object}&size=${size}"
                              };
//
    OSSTask * putTask = [client putObject:request];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
    [putTask waitUntilFinished];
    return YES;
}






@end
