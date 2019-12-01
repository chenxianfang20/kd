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


/** get 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic headDic:(NSDictionary*)headDic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock
{
    NSString*urlStr = @"";
    if ([url containsString:@"http"]) {
        urlStr = url;
    }else{
        urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    }
    NSLog(@"allUrl:%@ dic:\n%@ %@",urlStr, headDic,dic);
    
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
            NSLog(@"url:%@\n%@  %@",url, headDic,dict);
            if([dict[@"code"] integerValue ] ==10001){
                [KDUserModelTool deleteUserModel];
                [ZJCustomHud showWithText:dict[@"msg"] WithDurations:1];
            }else{
                successBlock(dict);
            } 
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /** 这里是处理事件的回调 */
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"fail:  %@",error);
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


/**
 *  图片上传
 *
 *  @param urlStr                上传文件url地址
 *  @param paramsDict          参数字典
 *  @param uploadProgressBlock 上传进度block回调
 *  @param successBlock        上传成功block回调
 *  @param failureBlock        上传失败block回调
 *  @param netFileParam         网络文件参数
 */
+(void)uploadFileWithUrlStr:(NSString *)url
                     params:(NSDictionary *)paramsDict
             uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
               successBlock:(void (^)(NSDictionary *dataDic))successBlock
               failureBlock:(void (^)(NSError *error))failureBlock
                uploadParam:(DKNetFileParam *)netFileParam{
    
    NSString*urlStr = @"";
    if ([url containsString:@"http"]) {
        urlStr = url;
    }else{
        urlStr = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"audio/*"]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:15];
    //访问网络显示系统的小菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:urlStr parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //    [formData appendPartWithFileData:amrData name:@"file" fileName:@"123.amr" mimeType:@"audio/mpeg"];
        
        [formData appendPartWithFileData:netFileParam.data name:netFileParam.name fileName:netFileParam.fileName mimeType:netFileParam.mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //访问完网络不显示系统的小菊花
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //访问完网络不显示系统的小菊花
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

