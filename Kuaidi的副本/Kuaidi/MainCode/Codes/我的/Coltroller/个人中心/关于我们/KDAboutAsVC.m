//
//  KDAboutAsVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAboutAsVC.h"

@implementation KDAboutAsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self addChildViews];
}

-(void)addChildViews{
    self.view.backgroundColor=[UIColor colorWithHex:@"#FAF8F8"];
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(268))];
    topBgImgView.image = [UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]];
    [self.view addSubview:topBgImgView];
    [self.view sendSubviewToBack:topBgImgView];
    
    UIImageView* iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(128), NavibarH+kAdaptationWidth(14), kAdaptationWidth(120), kAdaptationWidth(41))];
    iconImgView.image = [UIImage imageNamed:@"关于-图片"];
    [self.view addSubview:iconImgView];
    
    UIView*  infoBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), NavibarH+kAdaptationWidth(82), kAdaptationWidth(339), kAdaptationWidth(202))];
    infoBgView.backgroundColor=[UIColor whiteColor];
    infoBgView.layer.cornerRadius=10.0f;
    infoBgView.layer.masksToBounds=YES;
    [self.view addSubview:infoBgView];
    
    
    UILabel* infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(24), kAdaptationWidth(295), kAdaptationWidth(154))];
    infoLabel.text=@"      公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试。\n     公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试，公司介绍文字测试。";
    infoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    infoLabel.font =[UIFont fontWithName:@"PingFang SC" size: 14];
    infoLabel.numberOfLines=0;
    [infoBgView addSubview:infoLabel];
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    [self.titleView setTitle:@"关于我们"];
    self.nav.backgroundColor = [UIColor clearColor];
    self.backgroungImgView.hidden=YES;
}
@end
