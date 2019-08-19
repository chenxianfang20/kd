//
//  HCTSessionManager.h
//  Kuaidi
//
//  Created by iOS_01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface KDSessionManager : AFURLSessionManager

+ (instancetype)shareManager;


+(AFHTTPSessionManager *)sharedHttpSessionManager ;

@end
