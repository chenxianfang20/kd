//
//  NetWork.h
//  Kuaidi
//
//  Created by ios01 on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#ifndef NetWork_h
#define NetWork_h


#define kDeviceType  @"iphone"


#define kBaseUrl @"https://kuaidi.foldbook.net"

//发送验证码
#define kSendCode @"/api/user/public/sendCode"
//注册
#define kRegister @"/api/user/public/register"
//登录
#define kLogin @"/api/user/public/login"

//地址列表
#define kAddressList @"/api/user/address/index"
//新增地址
#define kAddAddress @"/api/user/address/add"
//删除地址
#define kDeleteAddress @"/api/user/address/delete"
//修改地址
#define kUpdateAddress @"/api/user/address/update"
//获取默认地址
#define kDefaultAddress @"/api/user/address/getDefault"


#define kWuLiu @"/api/logistics/wuliu/index"


//关于我们
#define kArticles @"/api/portal/articles/2"

#endif /* NetWork_h */
