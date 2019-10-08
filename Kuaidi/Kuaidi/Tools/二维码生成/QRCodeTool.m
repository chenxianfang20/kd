//
//  QRCodeTool.m
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/9/11.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import "QRCodeTool.h"
#import "UIView+YYAdd.h"
@implementation QRCodeTool

/**
 *  生成二维码图片
 */
+(UIImage*)createScanImage:(NSString*)text
{
    //生成coreImage框架中的滤镜来生产二维码
    CIFilter* filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    [filter setValue:[text dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    //获取生成的图片
    CIImage *ciImg=filter.outputImage;
    //设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImg forKey:@"inputImage"];
    //获取生存的图片
    ciImg=colorFilter.outputImage;
    
    CGAffineTransform scale=CGAffineTransformMakeScale(8, 8);
    ciImg=[ciImg imageByApplyingTransform:scale];
    
    //6.在中心增加一张图片
    UIImage *img=[UIImage imageWithCIImage:ciImg];
    //7.生存图片
    //7.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //7.2将二维码的图片画入
    //BSXPCMessage received error for message: Connection interrupted   why??
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //7.3在中心划入其他图片
    
    UIImage *centerImg=[UIImage imageNamed:@"icon二维码"];
    
    CGFloat centerW = 100;
    CGFloat centerH = 100;
    CGFloat centerX=(img.size.width-centerW)*0.5;
    CGFloat centerY=(img.size.height-centerH)*0.5;
    
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    
    
    
    //7.4获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    
    //7.5关闭图像上下文
    UIGraphicsEndImageContext();
    //设置图片
    return  finalImg;
    
}

/**
 *  生成二维码图片给微信扫码
 */
+(UIImage*)createScanImageForWX_Scan:(NSString*)str
{
    //生成coreImage框架中的滤镜来生产二维码
    CIFilter* filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
//    NSString *scanString = [HCTJsonTool creatJsonStringWithDic:info];
//    NSString * encryptStr = [JKEncrypt doEncryptStr:scanString];
//
//    NSLog(@"加密前：%@",scanString);
//
//    NSString *resultString = [NSString stringWithFormat:@"(%@)",encryptStr];//用括号括起来
//    NSLog(@"加密后：%@",resultString);
    
    [filter setValue:[str dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    //获取生成的图片
    CIImage *ciImg=filter.outputImage;
    //设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImg forKey:@"inputImage"];
    //获取生存的图片
    ciImg=colorFilter.outputImage;
    
    CGAffineTransform scale=CGAffineTransformMakeScale(8, 8);
    ciImg=[ciImg imageByApplyingTransform:scale];
    
    //6.在中心增加一张图片
    UIImage *img=[UIImage imageWithCIImage:ciImg];
    //7.生存图片
    //7.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //7.2将二维码的图片画入
    //BSXPCMessage received error for message: Connection interrupted   why??
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //7.3在中心划入其他图片
    
    //UIImage *centerImg=[UIImage imageNamed:@"icon二维码"];
    
//    CGFloat centerW = 100;
//    CGFloat centerH = 100;
//    CGFloat centerX=(img.size.width-centerW)*0.5;
//    CGFloat centerY=(img.size.height-centerH)*0.5;
//
//    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    
    
    
    //7.4获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    
    //7.5关闭图像上下文
    UIGraphicsEndImageContext();
    //设置图片
    return  finalImg;
    
}
@end
