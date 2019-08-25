//
//  KDAddExpressModel.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAddExpressModel.h"

@implementation KDAddExpressModel
+(instancetype)ModelWithDict:(NSDictionary*)dict{
    KDAddExpressModel* model=[[self alloc]init];
    model.name=dict[@"name"];
    model.model_ID=dict[@"id"];
    model.src=dict[@"src"];
    model.heart=dict[@"heart"];
    return model;
}
@end
