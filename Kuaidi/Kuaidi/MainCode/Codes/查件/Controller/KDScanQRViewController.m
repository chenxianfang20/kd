//
//  KDScanQRViewController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/27.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDScanQRViewController.h"

@interface KDScanQRViewController ()

@end

@implementation KDScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showsZBarControls = NO; //隐藏控制项
    self.tracksSymbols = NO; //隐藏追踪框
    
    //设置识别范围（距离左边/宽度，距离上边/高度，识别宽度/宽度，识别高度/高度）
    float width = kScreenWidth*500.f/750.f;
    float height = kScreenWidth*500.f/750.f;
    float scanV_X = (kScreenWidth-width)/2.f;
    float scanV_Y = (kScreenHeight-height)/2.f;
    CGRect scanViewRect = CGRectMake(scanV_X/kScreenWidth, scanV_Y/kScreenHeight, width/kScreenWidth, height/kScreenHeight);
    self.scanCrop = scanViewRect;
    
    
    [self setMaskViewAndScanAnimation];
}

-(void)setMaskViewAndScanAnimation {
    //掩盖视图maskView
    UIView * maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.backgroundColor = [UIColor clearColor];
    self.cameraOverlayView = maskView;//添加蒙版视图
    
    //扫描范围
    float width = kScreenWidth*500.f/750.f;
    float height = kScreenWidth*500.f/750.f;
    UIView * scanBoxV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scanBoxV.backgroundColor = [UIColor clearColor];//透明色才能扫描
    scanBoxV.center = maskView.center;
    [maskView addSubview:scanBoxV];
    scanBoxV.layer.borderWidth = 2.f;
    scanBoxV.layer.borderColor = [UIColor blueColor].CGColor;
    
    
    //扫描动画 （根据UI需求：放图片或试图）
    UIImageView *lineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 3)];
    [scanBoxV addSubview:lineImgV];
    lineImgV.image = [UIImage imageNamed:@"scan_line"];
    [UIView beginAnimations:@"animationID" context:NULL];
    [UIView setAnimationDuration:3.f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:lineImgV cache:YES];
    [UIView setAnimationRepeatCount:100];//重复次数
    
    [lineImgV setFrame:CGRectMake(0, 0+width, width, 3)]; //最终位置
    [UIView commitAnimations];
}
@end
