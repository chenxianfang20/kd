//
//  KDLoginVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/14.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDLoginVC.h"

@interface KDLoginVC ()

@end

@implementation KDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self addChildViews];
}
-(void)addChildViews{
    
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(274))];
    topBgImgView.image = [UIImage imageNamed:@"登录-背景"];
    [self.view addSubview:topBgImgView];
    [self.view sendSubviewToBack:topBgImgView];
    
    UIImageView* topLogoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(146), NavibarH+kAdaptationWidth(15), kAdaptationWidth(84), kAdaptationWidth(84))];
    topLogoImgView.image = [UIImage imageNamed:@"Logo"];
    [self.view addSubview:topLogoImgView];
    
    //UIView*******
    UIView*  infoBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), topLogoImgView.bottom+kAdaptationWidth(32), kAdaptationWidth(339), kAdaptationWidth(216))];
    infoBgView.backgroundColor=[UIColor whiteColor];
    infoBgView.layer.cornerRadius=10.0f;
    infoBgView.layer.masksToBounds=YES;
    [self.view addSubview:infoBgView];
    
    //
    
//    UILabel* scanTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), 0, kAdaptationWidth(120), kAdaptationWidth(60))];
//    scanTitleLabel.text=@"寄件二维码";
//    scanTitleLabel.textColor=[UIColor blackColor];
//    scanTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
//    [scanView addSubview:scanTitleLabel];
//
//    UIImageView* scanIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(297), kAdaptationWidth(10), kAdaptationWidth(18), kAdaptationWidth(18))];
//    scanIconImgView.image=[UIImage imageNamed:@"我的-图标-二维码"];
//    [scanView addSubview:scanIconImgView];
//    scanIconImgView.centerY=scanTitleLabel.centerY;
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    [self.titleView setTitle:@"登录"];
    self.nav.backgroundColor = [UIColor clearColor];
    self.backgroungImgView.hidden=YES;
}

@end
