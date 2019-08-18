//
//  UIColor+Tool.h
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Tool)
/**
 *  16进制转换成UIColo
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex: (NSString *) stringToConvert;


@end

NS_ASSUME_NONNULL_END
