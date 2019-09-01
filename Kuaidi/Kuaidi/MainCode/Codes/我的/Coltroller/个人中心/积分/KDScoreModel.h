//
//  KDScoreModel.h
//  Kuaidi
//
//  Created by cxf on 2019/9/1.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KDScoreModel : NSObject
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *timeStr;
@property (nonatomic,strong) NSString *score;

+(instancetype)ModelWithDict:(NSDictionary*)dict;
@end


