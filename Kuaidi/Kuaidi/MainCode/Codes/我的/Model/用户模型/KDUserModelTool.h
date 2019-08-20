//
//  KDUserModelTool.h
//  Kuaidi
//
//  Created by cxf on 2019/8/21.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDUserModel.h"
#import "Settings.h"
#define KDUserModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"KDUserModel.archive"]


@interface KDUserModelTool : NSObject
//保存一个account对象
+(void)saveUserModel:(KDUserModel *)userModel;

//拿到当前的account
+(KDUserModel *)userModel;

//删除当前account
+(BOOL)deleteUserModel;
@end


