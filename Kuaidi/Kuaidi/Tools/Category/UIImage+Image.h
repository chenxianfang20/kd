//
//  UIImage+Image.h
//  HCTProject
//
//  Created by cxf on 17/4/20.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

+ (UIImage *)fixOrientation:(UIImage *)aImage;


+ (UIImage *)imageWithColor:(UIColor *)color ;
@end
