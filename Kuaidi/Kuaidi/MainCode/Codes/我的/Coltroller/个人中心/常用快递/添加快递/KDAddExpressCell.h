//
//  KDAddExpressCell.h
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootCustomCell.h"

#import "KDAddExpressModel.h"
typedef void(^FavitBtnBlock)(void);
@interface KDAddExpressCell : RootCustomCell
@property (nonatomic,strong) KDAddExpressModel *model;
@property (nonatomic,copy) FavitBtnBlock  favitBtnBlock;
@end


