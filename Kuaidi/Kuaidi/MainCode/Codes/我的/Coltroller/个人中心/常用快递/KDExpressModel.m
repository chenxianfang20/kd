//
//  KDExpressModel.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDExpressModel.h"

@implementation KDExpressModel
+(instancetype)ModelWithDict:(NSDictionary*)dict{
    KDExpressModel* model=[[self alloc]init];
    model.logistics_icon=dict[@"logistics_icon"];
    model.logistics_mobile=dict[@"logistics_mobile"];
    model.logistics_name=dict[@"logistics_name"];
    model.logistics_id=dict[@"id"];
    model.status=dict[@"status"];
    return model;
}
@end
