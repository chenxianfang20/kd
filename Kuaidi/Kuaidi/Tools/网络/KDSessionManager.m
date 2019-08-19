//
//  HCTSessionManager.m
//  Kuaidi
//
//  Created by iOS_01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDSessionManager.h"

@implementation KDSessionManager


+ (instancetype)shareManager
{
    static KDSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KDSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return manager;
}


+(AFHTTPSessionManager *)sharedHttpSessionManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceTokenk;
    dispatch_once(&onceTokenk, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    });
    return manager;
}


@end
