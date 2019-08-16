//
//  UIView+Extension.h
//  QianMai
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 Micro credit information technology co., LTD. Shenzhen Qianhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// 判断一个控件是否真正显示在主窗口
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

@end
