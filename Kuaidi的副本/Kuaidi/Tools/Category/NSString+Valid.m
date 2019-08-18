//
//  NSString+Valid.m
//  Kuaidi
//
//  Created by cxf on 2019/8/17.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)
+(BOOL)isValidatePhoneNum:(NSString *)phone {
    
    //    varpartten =  @"/^((\(\d{3}\))|(\d{3}\-))?1[3|4|5|6|7|8|9][0-9]\d{8}$/";
    //    NSString *phoneRegex = @"^[1][3578][0-9]{9}$";
    NSString *phoneRegex = @"^[1][35789][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}
@end
