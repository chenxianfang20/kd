//
//  WXLoginPhoneAlertView.h
//  Kuaidi
//
//  Created by ljp on 2019/10/8.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXLoginPhoneAlertView : UIView

+(void)wx_LoginPhoneAlertViewShowWithCompeleteBlock:(void(^)(NSString *phoneNum))Block;

@end

NS_ASSUME_NONNULL_END
