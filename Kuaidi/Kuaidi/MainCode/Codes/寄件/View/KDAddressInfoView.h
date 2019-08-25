//
//  KDAddressInfoView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KDAddressAdminModel;

@protocol KDAddressInfoViewDelegate <NSObject>

@optional
-(void)selectSendExpressAddress;
-(void)selectReceiveExpressAddress;

@end

@interface KDAddressInfoView : UIView

@property(nonatomic, assign)id<KDAddressInfoViewDelegate> delegate;

@property(nonatomic, strong)UIView *bottomView;

@property(nonatomic, strong)KDAddressAdminModel * sendAddressModel;

@property(nonatomic, strong)KDAddressAdminModel * receiveAddressModel;



+ (KDAddressInfoView *)addressInfoView;

@end

NS_ASSUME_NONNULL_END
