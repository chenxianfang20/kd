//
//  KDUserModelTool.m
//  Kuaidi
//
//  Created by cxf on 2019/8/21.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDUserModelTool.h"

@implementation KDUserModelTool
//************操作用户信息******************
+(void)saveUserModel:(KDUserModel *)userModel
{
    [NSKeyedArchiver archiveRootObject:userModel toFile:KDUserModelPath];
}
+(KDUserModel *)userModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:KDUserModelPath];
}
+(BOOL)deleteUserModel
{
    return [[NSFileManager defaultManager] removeItemAtPath:KDUserModelPath error:nil];
}
@end
