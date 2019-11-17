//
//  WXApiManager.h
//  Kuaidi
//
//  Created by ljp on 2019/9/28.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WXAuthDelegate <NSObject>

@optional
- (void)wxAuthSucceed:(NSString*)code;
- (void)wxAuthDenied;
- (void)wxAuthCancel;

@end

@interface WXApiManager : NSObject <WXApiDelegate>

@property (nonatomic, assign) id<WXAuthDelegate, NSObject> delegate;


/**
 *  严格单例，唯一获得实例的方法.
 *
 *  @return 实例对象.
 */
+ (instancetype)sharedManager;

/**
 *  发送微信验证请求.
 *
 *  @restrict 该方法支持未安装微信的用户.
 *
 *  @param viewController 发起验证的VC
 *  @param delegate       处理验证结果的代理
 */
- (void)sendAuthRequestWithController:(UIViewController*)viewController
                             delegate:(id<WXAuthDelegate>)delegate;

/**
 *  发送链接到微信.
 *
 *  @restrict 该方法要求用户一定要安装微信.
 *
 *  @param urlString 链接的Url
 *  @param title     链接的Title
 *  @param desc      链接的描述
 *  @param scene     发送的场景，分为朋友圈, 会话和收藏
 *
 *  @return 发送成功返回YES
 */
- (BOOL)sendLinkContent:(NSString *)urlString
                  Title:(NSString *)title
            Description:(NSString *)desc
                AtScene:(enum WXScene)scene;
/**
 *  发送文件到微信.
 *
 *  @restrict 该方法要求用户一定要安装微信.
 *
 *  @param fileData   文件的数据
 *  @param extension  文件扩展名
 *  @param title      文件的Title
 *  @param desc       文件的描述
 *  @param thumbImage 文件缩略图
 *  @param scene      发送的场景，分为朋友圈, 会话和收藏
 *
 *  @return 发送成功返回YES
 */
- (BOOL)sendFileData:(NSData *)fileData
       fileExtension:(NSString *)extension
               Title:(NSString *)title
         Description:(NSString *)desc
          ThumbImage:(UIImage *)thumbImage
             AtScene:(enum WXScene)scene;

/**
 微信分享
 
 @param WXSceneType   = 0,   聊天界面
 = 1,   朋友圈
 */
- (void)WXShareWXScene:(int)WXSceneType code:(NSString *)code phoneNum:(NSString *)num;

/**
 微信分享
 
 @param WXSceneType   = 0,   聊天界面  = 1,   朋友圈
 @param image 分享二维码图片
 */
- (void)WXShareWXScene:(int)WXSceneType image:(UIImage *)image;

- (BOOL)isInstallWX;

@end

NS_ASSUME_NONNULL_END
