//
//  KDNetWorkManager.m
//  KuaiDi
//
//  Created by iOS_01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDNetWorkManager.h"
#import "KDSessionManager.h"
#import "AFNetworking.h"
#import "NetWork.h"
@implementation KDNetWorkManager

/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock
{
    
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"allUrl:%@ dic:\n%@",urlStr,dic);
    AFHTTPSessionManager *manager = [KDSessionManager sharedHttpSessionManager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 这里是处理事件的回调 */
        if (successBlock) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary* dict= [KDNetWorkManager dictionaryWithJsonString:string];
            NSLog(@"url:%@\n%@",url,dict);
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /** 这里是处理事件的回调 */
        if (failureBlock) {
            failureBlock(error);
        }
    }
    ];
}


/** Post 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic headDic:(NSDictionary*)headDic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock
{
    
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"allUrl:%@ dic:\n%@",urlStr,dic);
    
    AFHTTPSessionManager *manager = [KDSessionManager sharedHttpSessionManager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSArray* keys=[headDic allKeys];
    for (NSString * key in keys) {
        [manager.requestSerializer setValue:headDic[key] forHTTPHeaderField:key];
    }
    
    [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 这里是处理事件的回调 */
        if (successBlock) {
            
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary* dict= [KDNetWorkManager dictionaryWithJsonString:string];
            NSLog(@"url:%@\n%@",url,dict);
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /** 这里是处理事件的回调 */
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end

