//
//  KDGoodsTypeInfoSelectView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDGoodsTypeInfoSelectView : UIView

+(void)showSelectViewWithConfirmBlock:(void(^)(NSString *goodsType, NSInteger weight, UIImage *image))confirmBlock;

@end

NS_ASSUME_NONNULL_END
