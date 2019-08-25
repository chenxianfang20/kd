//
//  KDInfoModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/20.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KDUserModel : NSObject

@property (nonatomic,strong) NSString *token;

@property (nonatomic,strong) NSString *userId;
//手机
@property (nonatomic,strong) NSString *mobile;
//昵称
@property (nonatomic,strong) NSString *user_nickname;
//用户积分
@property (nonatomic,strong) NSString *score;
//金币
@property (nonatomic,strong) NSString *coin;
//交易额
@property (nonatomic,strong) NSString *balance;
//用户名称
@property (nonatomic,strong) NSString *user_login;
//用户状态1表示正常
@property (nonatomic,strong) NSString *user_status;

//性别
@property (nonatomic,strong) NSString *sex;
//头像
@property (nonatomic,strong) NSString *avatar;

+(instancetype)ModelWithDict:(NSDictionary*)dict;

@end


