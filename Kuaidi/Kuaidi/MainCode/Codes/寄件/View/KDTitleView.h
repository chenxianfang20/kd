//
//  KDTitleView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/15.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KDTitleViewDelegate <NSObject>

@optional
-(void)lookExpressRecord;

@end

@interface KDTitleView : UIView

@property(nonatomic,assign)id<KDTitleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
