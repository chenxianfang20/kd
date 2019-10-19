//
//  WXApiManager.m
//  Kuaidi
//
//  Created by ljp on 2019/9/28.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "WXApiManager.h"
#import "RandomKey.h"

static NSString* const kWXNotInstallErrorTitle = @"您还没有安装微信，不能使用微信分享功能";

@interface WXApiManager()<WXApiDelegate>

@property(nonatomic, copy)NSString *authState;

@end

@implementation WXApiManager


#pragma mark - Life Cycle
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initInPrivate];
    });
    return instance;
}

- (instancetype)initInPrivate {
    self = [super init];
    if (self) {
        _delegate = nil;
    }
    return self;
}

- (instancetype)init {
    return nil;
}

- (instancetype)copy {
    return nil;
}

#pragma mark - Public Methods
- (void)sendAuthRequestWithController:(UIViewController*)viewController
                             delegate:(id<WXAuthDelegate>)delegate {
    
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    self.authState = req.state = [NSString randomKey];
    self.delegate = delegate;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
    
//    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    self.authState = req.state = [NSString randomKey];
//    self.delegate = delegate;
//    [WXApi sendAuthReq:req viewController:viewController delegate:self];
}

- (BOOL)sendLinkContent:(NSString *)urlString
                  Title:(NSString *)title
            Description:(NSString *)description
                AtScene:(enum WXScene)scene {
    
    if (![WXApi isWXAppInstalled]) {
        ADShowErrorAlert(kWXNotInstallErrorTitle);
        return NO;
    }
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    message.mediaObject = ext;
    message.thumbData = UIImagePNGRepresentation([UIImage imageNamed:@"wxLogoGreen"]);
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = NO;
    req.scene = scene;
    return [WXApi sendReq:req];
}

- (BOOL)sendFileData:(NSData *)fileData
       fileExtension:(NSString *)extension
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             AtScene:(enum WXScene)scene {
    if (![WXApi isWXAppInstalled]) {
        ADShowErrorAlert(kWXNotInstallErrorTitle);
        return NO;
    }
    
    WXFileObject *ext = [WXFileObject object];
    ext.fileExtension = extension;
    ext.fileData = fileData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = ext;
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = message;
    req.bText = NO;
    req.scene = scene;
    
    return [WXApi sendReq:req];
}

#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req {
    // just leave it here, WeChat will not call our app
}

-(void)onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp* authResp = (SendAuthResp*)resp;
        /* Prevent Cross Site Request Forgery */
        if (![authResp.state isEqualToString:self.authState]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
                [self.delegate wxAuthDenied];
            return;
        }
        
        switch (resp.errCode) {
            case WXSuccess:
                NSLog(@"RESP:code:%@,state:%@\n", authResp.code, authResp.state);
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthSucceed:)])
                    [self.delegate wxAuthSucceed:authResp.code];
                break;
            case WXErrCodeAuthDeny:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
                    [self.delegate wxAuthDenied];
                break;
            case WXErrCodeUserCancel:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthCancel)])
                    [self.delegate wxAuthCancel];
            default:
                break;
        }
    }
}


/**
 微信分享
 
 @param WXSceneType   = 0,   聊天界面
 = 1,   朋友圈
 */
- (void)WXShareWXScene:(int)WXSceneType code:(NSString *)code phoneNum:(NSString *)num
{
    
    if (WXSceneType == 0) {
        
        WXMiniProgramObject *object = [WXMiniProgramObject object];
        object.webpageUrl = orderRecordUrl;
        object.userName = @"gh_17b3cba01821";
        object.path = [NSString stringWithFormat:@"pages/result/result?code=%@&num=%@",code,num];
        object.hdImageData = UIImagePNGRepresentation([UIImage imageNamed:@"kuaidime"]);
        object.withShareTicket = YES;
        object.miniProgramType = WXMiniProgramTypeRelease;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"快递神奇";
        message.description = @"查快递 寄快递 就上快递么";
        message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
        //使用WXMiniProgramObject的hdImageData属性
        message.mediaObject = object;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;  //目前只支持会话
        [WXApi sendReq:req];
        
    }else if (WXSceneType == 1) {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"快递神奇";
        message.description = @"查快递 寄快递 就上快递么";
        [message setThumbImage:[UIImage imageNamed:@"kuaidime"]];
        
        WXWebpageObject *web = [WXWebpageObject object];
        web.webpageUrl = [NSString stringWithFormat:@"%@?code=%@&num=%@",orderRecordUrl,code,num];
        message.mediaObject = web;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneType;
        
        [WXApi sendReq:req];
    }
    
    
}


/**
 微信分享
 
 @param WXSceneType   = 0,   聊天界面
 = 1,   朋友圈
 */
- (void)WXShareWXScene:(int)WXSceneType image:(UIImage *)image
{
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imgObj = [WXImageObject object];
    imgObj.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = imgObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneType;
    
    [WXApi sendReq:req];
}
@end
