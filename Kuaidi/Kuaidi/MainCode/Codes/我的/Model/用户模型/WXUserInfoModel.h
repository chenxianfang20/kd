//
//  WXUserInfoModel.h
//  Kuaidi
//
//  Created by ljp on 2019/9/28.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXUserInfoModel : NSObject

@property(nonatomic, copy)NSString *access_token;

@property(nonatomic, strong)NSNumber *expires_in;

@property(nonatomic,  copy)NSString *refresh_token;

@property(nonatomic, copy)NSString *openid;

@property(nonatomic, copy)NSString *scope;

@property(nonatomic, copy)NSString *unionid;

@end

NS_ASSUME_NONNULL_END
