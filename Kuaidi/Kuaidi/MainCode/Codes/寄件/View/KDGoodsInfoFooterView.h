//
//  KDGoodsInfoFooterView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDGoodsInfoFooterViewDelegate <NSObject>

@optional
- (void)clickConfirmButton;

@end

@interface KDGoodsInfoFooterView : UIView

@property(nonatomic, assign)id<KDGoodsInfoFooterViewDelegate> delegate;

+(KDGoodsInfoFooterView *)goodsInfoFooterView;

@end

NS_ASSUME_NONNULL_END
