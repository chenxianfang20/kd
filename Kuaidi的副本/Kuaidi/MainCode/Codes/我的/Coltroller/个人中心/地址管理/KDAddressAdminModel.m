//
//  KDAddressAdminModel.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAddressAdminModel.h"

@implementation KDAddressAdminModel
+(instancetype)ModelWithDict:(NSDictionary*)dict{
    KDAddressAdminModel* model=[[self alloc]init];
    model.name=dict[@"name"];
    model.phone=dict[@"phone"];
    model.address=dict[@"address"];
    return model;
}

@end
