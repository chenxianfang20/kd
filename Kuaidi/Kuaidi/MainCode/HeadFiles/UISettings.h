//
//  UISettings.h
//
//
//
//  Copyright © 2019年 HCT. All rights reserved.
//

#ifndef UISettings_h
#define UISettings_h

#define kWindow  [[[UIApplication sharedApplication] windows] lastObject]

#define PingFangMedium(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size: fontSize]
#define PingFangBold(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size: fontSize]
#define PingFangRegular(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size: fontSize]

/***********************适配相关****************************/

#define kScale (kScreenWidth/375.0)
#define kAdaptationFont(size) ([UIFont systemFontOfSize:size * kScale])
#define kAdaptationFont(size) ([UIFont systemFontOfSize:size * kScale])
#define kAdaptationBoldFont(size) ([UIFont boldSystemFontOfSize:size * kScale])
#define kAdaptationWidth(a) (a  * kScale)


#define kMainRedColor @"#DF2F31"

#define kLeftX kAdaptationWidth(18)
/**
 *   颜色                                    v
 */
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RandomColor rgb(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

/**
 *   路径添加图片
 */
#define kImgWithContentsOfFile(a,b)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:a ofType:b]]

/**
 *   屏幕宽高
 */
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define BottomH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 34 : 0)
#define NavibarH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88 : 64)
#define TabbarH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? (49 + 34) : 49)
#define StatusbarH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44 : 20)
#define headH ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 24 : 0)
#define headForHB ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 48 : 0)

#define kScreenRealHeight (kScreenHeight - NavibarH - TabbarH)

#define is_iPhoneX (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)

#endif /* UISettings_h */
