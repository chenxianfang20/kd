//
//  KDUserInfoView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    KDUserInfoTypeSend,
    KDUserInfoTypeReceive,
} KDUserInfoType;

@interface KDUserInfoView : UIView

@property(nonatomic, assign)KDUserInfoType userInfoType;

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *phoneLabel;

@property(nonatomic, strong)UILabel *addressLabel;

+(KDUserInfoView *)userInfoView;


- (void)hiddenAddress;

- (void)showAddress;

@end

NS_ASSUME_NONNULL_END
