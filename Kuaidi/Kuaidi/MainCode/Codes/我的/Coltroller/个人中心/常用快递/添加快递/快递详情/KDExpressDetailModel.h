//
//  KDExpressDetailModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KDExpressDetailModel : NSObject
@property (nonatomic,strong) NSString  *DetailModel_id;
@property (nonatomic,strong) NSString  *logistics_mobile;
@property (nonatomic,strong) NSString  *url;

+(instancetype)ModelWithDict:(NSDictionary*)dict;

@end


