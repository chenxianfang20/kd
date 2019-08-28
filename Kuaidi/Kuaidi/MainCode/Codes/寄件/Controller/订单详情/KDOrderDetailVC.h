//
//  KDOrderDetailVC.h
//  Kuaidi
//
//  Created by cxf on 2019/8/26.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootViewController.h"

#import "KDOrderListModel.h"

@interface KDOrderDetailVC : RootViewController

// 0 待联系  1 已接单 2 已取件 3 已签收  4 已取消
@property (nonatomic,assign) NSInteger  type;


@property (nonatomic,strong) KDOrderListModel *model;
@end


