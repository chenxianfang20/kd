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
    model.mobile=dict[@"mobile"];
    model.province_name=dict[@"province_name"];
    model.city_name=dict[@"city_name"];
    model.district_name=dict[@"district_name"];
    model.address=dict[@"address"];
    model.addressID=dict[@"id"];
    model.isDefault=dict[@"default"];
    return model;
}
@end
