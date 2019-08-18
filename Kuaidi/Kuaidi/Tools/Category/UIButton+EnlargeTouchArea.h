//
//  UIButton+EnlargeTouchArea.h
//  mphoneLot
//
//  Created by ios01 on 2019/6/21.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)setEnlargeEdge:(CGFloat) size;

@end

NS_ASSUME_NONNULL_END
