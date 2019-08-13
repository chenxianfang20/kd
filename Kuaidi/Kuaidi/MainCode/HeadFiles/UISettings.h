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




/***********************适配相关****************************/

#define kScale (kScreenWidth/375.0)
#define kAdaptationFont(size) ([UIFont systemFontOfSize:size * kScale])
#define kAdaptationFont(size) ([UIFont systemFontOfSize:size * kScale])
#define kAdaptationBoldFont(size) ([UIFont boldSystemFontOfSize:size * kScale])
#define kAdaptationWidth(a) (a  * kScale)
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



/**iPHONE X 适配***/
#define is_iPhoneX               (kScreenWidth == 375 && kScreenHeight == 812 ? true:false)
#define BottomH                  (is_iPhoneX ? 34 : 0)
#define NavibarH                 (is_iPhoneX ? 88 : 64)
#define TabbarH                  (is_iPhoneX ? (49 + 34) : 49)
#define StatusbarH               (is_iPhoneX ? 44 : 20)

#define headH               (is_iPhoneX ? 24 : 0)

#define headForHB               (is_iPhoneX ? 48 : 0)

#endif /* UISettings_h */
