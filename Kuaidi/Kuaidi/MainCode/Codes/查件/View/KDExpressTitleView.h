//
//  KDExpressTitleView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/20.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDExpressTitleView : UIView

@property(nonatomic, strong)UIImageView *iconImageV;

@property(nonatomic, strong)UILabel *expressTitleLabel;

@property(nonatomic, strong)UILabel *expressNoLabel;

+ (KDExpressTitleView *)expressTitleView;

@end

NS_ASSUME_NONNULL_END
