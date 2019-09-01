//
//  KDReceivedView.h
//  Kuaidi
//
//  Created by cxf on 2019/8/28.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootCustomView.h"
#import "KDOrderListModel.h"
#import "KDWuliuListModel.h"
#import "KDOrderGoodsModel.h"
typedef void(^MyOrderAginBlock)(void);
typedef void(^MyIsShowInfoBlock)(NSInteger);
@interface KDReceivedView : RootCustomView
@property (nonatomic,strong) UIButton *showInfoBtn;
@property (nonatomic,strong) UIView *bottomBgView;
@property (nonatomic,strong) MyIsShowInfoBlock myIsShowInfoBlock;
@property (nonatomic,strong) KDOrderListModel *model;
@property (nonatomic,strong) MyOrderAginBlock myOrderAginBlock;

// 0 待联系  1 已接单 2 已取件 3 已签收  4 已取消
@property (nonatomic,assign) NSInteger  type;
@end


