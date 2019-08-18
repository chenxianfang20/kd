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
    model.mailingName=dict[@"mailingName"];
    model.phone=dict[@"phone"];
    model.headImgDddress=dict[@"headImgDddress"];
    return model;
}
@end
