//
//  KDExpressDetailModel.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDExpressDetailModel.h"

@implementation KDExpressDetailModel
+(instancetype)ModelWithDict:(NSDictionary*)dict{
    KDExpressDetailModel* model=[[self alloc]init];
    model.DetailModel_id=dict[@"id"];
    model.logistics_mobile=dict[@"logistics_mobile"];
    model.url=dict[@"url"];
    return model;
}
@end
