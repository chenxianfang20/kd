//
//  QRCodeTool.h
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/9/11.
//  Copyright © 2017年 HCT. All rights reserved.
//  生成二维码图片工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCodeTool : NSObject

+(UIImage*)createScanImage:(NSDictionary*)info;

+(UIImage*)createScanImageForWX_Scan:(NSString*)str;
@end
