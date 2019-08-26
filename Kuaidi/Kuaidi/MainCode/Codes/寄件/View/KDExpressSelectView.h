//
//  KDExpressSelectView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDExpressSelectView : UIView


+(void)showSelectViewWithWuliuArr:(NSArray *)wuliuArr select:(NSInteger)index ConfirmBlock:(void(^)(NSInteger index))confirmBlock;

@end

NS_ASSUME_NONNULL_END
