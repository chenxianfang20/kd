//
//  KDExpressModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KDExpressModel : NSObject
@property (nonatomic,strong) NSString *mailingName;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *headImgDddress;
+(instancetype)ModelWithDict:(NSDictionary*)dict;
@end


