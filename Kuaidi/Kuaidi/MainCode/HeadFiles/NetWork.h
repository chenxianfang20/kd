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

//用户下单
#define kCreateOrder @"/api/logistics/kdniao/createOrder"

//上传图片
#define uploadOrderImageUrl @"/api/logistics/upload/one"

//订单列表
#define kOrderList @"/api/logistics/order/index"

//取消订单
#define kCancellOrder @"/api/logistics/kdniao/cancelyuyue"

//物流列表
#define kWuliuList @"/api/logistics/wuliu/index"

//物流轨迹
#define kWuliuGuiji @"/api/logistics/kdniao/getWuliu"

//顺丰物流
#define kSFWuliu @"/api/logistics/kdniao/zidong"

//商品列表
#define kGoodsList @"/api/logistics/goods/index"

//发送验证码
#define kSendCode @"/api/user/public/sendCode"

//注册
#define kRegister @"/api/user/public/register"


//找回密码发送验证码
#define kSendReCode @"/api/user/public/sendReCode"

//找回密码
#define kPasswordReset @"/api/user/public/passwordReset"



//登录
#define kLogin @"/api/user/public/login"

//微信登录验证码
#define kWXVerifyCode @"/api/user/public/bindCode" 

//微信2登录
#define kWXLoginWithPhone @"/api/user/public/saveUserInfo"

//微信1登录
#define kWXLoginNoPhone @"/api/user/public/check_weixin"

//退出登录
#define kLogout @"/api/user/public/logout"

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

//设置默认地址
#define kSetDefaultAddress @"/api/user/address/setDefautAddr"


//物流列表
#define kWuLiu @"/api/logistics/wuliu/index"
//常用物流列表
#define kShowwuliulist @"/api/user/favorites/showwuliulist"
//我的常用物流列表
#define kShowmywuliu @"/api/user/favorites/showmywuliu"

//删除物流
#define kDelmywuliu @"/api/user/favorites/delmywuliu"
//添加物流
#define kAddmywuliu @"/api/user/favorites/addmywuliu"
//物流详情
#define kDetailwuliu @"/api/logistics/wuliu/detail"

//积分
#define kScoreIndex @"/api/user/score/index"

//关于我们
#define kArticles @"/api/portal/articles/2"

//查询历史
#define kKdniaoGethistory @"/api//logistics/kdniao/gethistory"


//第三方登录
#define APP_ID @"wx822e0fdc66d89ea0"

#define AppSecret @"887d3c1b6285e2621498f54439650d92"

#define UNIVERSAL_LINK @"https://kuaidi.foldbook.net/"


#define WXAccessTokenUrl @"https://api.weixin.qq.com/sns/oauth2/access_token"

#define WXRefreshTokenUrl @"https://api.weixin.qq.com/sns/oauth2/refresh_token"

#define orderRecordUrl @"https://kuaidi.foldbook.net/portal/index/share"

#endif /* NetWork_h */
