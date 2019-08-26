//
//  KDAddressAdminVC.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootViewController.h"



@class KDAddressAdminModel;

@interface KDAddressAdminVC : RootViewController

@property(nonatomic, copy)void(^selectAddressBlock)(KDAddressAdminModel *model);

@end


