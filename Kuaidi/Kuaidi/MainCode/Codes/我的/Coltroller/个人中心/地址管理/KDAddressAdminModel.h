//
//  KDAddressAdminModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KDAddressAdminModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *province_name;
@property (nonatomic,strong) NSString *city_name;
@property (nonatomic,strong) NSString *district_name;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *addressID;
@property (nonatomic,strong) NSString *isDefault;
+(instancetype)ModelWithDict:(NSDictionary*)dict;
@end


