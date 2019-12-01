//
//  Kuaidi
//
//
//  Created by iOS_01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "DKNetFileParam.h"

typedef void(^CompleteBlock)(NSDictionary *response); //成功的回调
typedef void(^FailBlock)(NSString *fail); //失败

typedef void (^success)(id obj);
typedef void (^failure)(id obj);
@interface KDNetWorkManager : NSObject


/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url
                          Dic:(NSDictionary *)dic
                 SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock;

/** Post 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url
                         Dic:(NSDictionary *)dic
                     headDic:(NSDictionary*)headDic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock;

/**
 *  图片上传
 *
 *  @param urlStr              上传文件url地址
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
                uploadParam:(DKNetFileParam *)netFileParam;
@end
