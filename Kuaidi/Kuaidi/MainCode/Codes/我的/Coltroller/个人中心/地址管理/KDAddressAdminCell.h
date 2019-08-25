//
//  KDAddressAdminCell.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootCustomCell.h"

#import "KDAddressAdminModel.h"
typedef void(^EditBtnBlock)(void);
typedef void(^DeleteBtnBlock) (void);
typedef void(^DefaultBtnBlock) (void);
@interface KDAddressAdminCell : RootCustomCell
@property (nonatomic,strong) KDAddressAdminModel *model;

@property (nonatomic,copy) EditBtnBlock  editBtnBlock;
@property (nonatomic,copy) DeleteBtnBlock  deleteBtnBlock;
@property (nonatomic,copy) DefaultBtnBlock  defaultBtnBlock;


@end


