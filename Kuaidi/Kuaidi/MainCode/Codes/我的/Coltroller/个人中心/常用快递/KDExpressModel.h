//
//  KDExpressModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDExpressModel : NSObject
@property (nonatomic,strong) NSString *logistics_icon;
@property (nonatomic,strong) NSString *logistics_mobile;
@property (nonatomic,strong) NSString *logistics_name;
@property (nonatomic,strong) NSString *logistics_id;
@property (nonatomic,strong) NSString *status;


+(instancetype)ModelWithDict:(NSDictionary*)dict;

@end


