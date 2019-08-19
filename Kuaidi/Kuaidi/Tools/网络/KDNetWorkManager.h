//
//  Kuaidi
//
//
//  Created by iOS_01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"



typedef void(^CompleteBlock)(NSDictionary *response); //成功的回调
typedef void(^FailBlock)(NSString *fail); //失败

typedef void (^success)(id obj);
typedef void (^failure)(id obj);
@interface KDNetWorkManager : NSObject


/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock;
/** Post 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(success)successBlock FailureBlock:(failure)failureBlock;
@end
