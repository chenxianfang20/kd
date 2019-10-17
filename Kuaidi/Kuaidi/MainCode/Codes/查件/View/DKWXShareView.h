//
//  DKWXShareView.h
//  Kuaidi
//
//  Created by ljp on 2019/10/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKWXShareView : UIView

+(void)shareViewShowWithHandleBlock:(void(^)(NSInteger type))handleBlock;

@end

NS_ASSUME_NONNULL_END
