//
//  KDAddExpressModel.h
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDAddExpressModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *model_ID;
@property (nonatomic,strong) NSString *src;
@property (nonatomic,strong) NSString *heart;
+(instancetype)ModelWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
