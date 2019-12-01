//
//  KDCheckHistoryView.h
//  Kuaidi
//
//  Created by cxf on 2019/11/24.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDCheckHisoryModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(KDCheckHisoryModel*);
@interface KDCheckHistoryView : UIView
@property (nonatomic,strong) KDCheckHisoryModel *model;

@property (nonatomic,strong) ClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
