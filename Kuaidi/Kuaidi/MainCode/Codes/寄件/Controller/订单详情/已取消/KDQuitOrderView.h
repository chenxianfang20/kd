//
//  KDQuitOrderView.h
//  Kuaidi
//
//  Created by cxf on 2019/8/28.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootCustomView.h"
#import "KDOrderListModel.h"
typedef void(^MyReOrderBlock)(void);
typedef void(^MyIsShowInfoBlock)(NSInteger);
@interface KDQuitOrderView : RootCustomView
@property (nonatomic,strong) UIButton *showInfoBtn;
@property (nonatomic,strong) UIView *bottomBgView;
@property (nonatomic,strong) MyIsShowInfoBlock myIsShowInfoBlock;
@property (nonatomic,strong) MyReOrderBlock myReOrderBlock;
@property (nonatomic,strong) KDOrderListModel *model;
@end


