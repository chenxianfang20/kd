//
//  DKScanView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DKScanViewDelegate <NSObject>

@optional
-(void)clickLookUpButton;
-(void)clickScanQrCodeButton;

@end

@interface DKScanView : UIView

@property(nonatomic, strong)UITextField *textField;

@property(nonatomic, assign)id<DKScanViewDelegate> delegate;

+(DKScanView *)scanView;

@end

NS_ASSUME_NONNULL_END
