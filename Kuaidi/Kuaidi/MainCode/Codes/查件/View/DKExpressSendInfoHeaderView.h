//
//  DKExpressSendInfoHeaderView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/19.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KDWuliuGuijiModel;

@protocol DKExpressSendInfoHeaderViewDelegate <NSObject>

@optional
- (void)clickShareButton;

@end

@interface DKExpressSendInfoHeaderView : UIView

@property(nonatomic, strong)KDWuliuGuijiModel *model;

@property(nonatomic, assign)id<DKExpressSendInfoHeaderViewDelegate> delegate;

+(DKExpressSendInfoHeaderView *)expressSendInfoHeaderView;

@end

NS_ASSUME_NONNULL_END
