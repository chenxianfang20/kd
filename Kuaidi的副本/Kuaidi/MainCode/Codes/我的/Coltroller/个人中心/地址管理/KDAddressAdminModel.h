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
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
+(instancetype)ModelWithDict:(NSDictionary*)dict;
@end


