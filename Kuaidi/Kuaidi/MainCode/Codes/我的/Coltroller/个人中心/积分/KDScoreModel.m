//
//  KDScoreModel.m
//  Kuaidi
//
//  Created by cxf on 2019/9/1.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDScoreModel.h"

@implementation KDScoreModel
+(instancetype)ModelWithDict:(NSDictionary*)dict{
    KDScoreModel* model=[[self alloc]init];
    model.titleStr=dict[@"titleStr"];
    model.timeStr=dict[@"timeStr"];
    model.score=dict[@"score"];
    return model;
}
@end
