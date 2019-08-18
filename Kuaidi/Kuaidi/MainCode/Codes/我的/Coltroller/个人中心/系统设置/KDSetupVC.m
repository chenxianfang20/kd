//
//  KDSetupVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDSetupVC.h"
#import "SDImageCache.h"
@interface KDSetupVC()

@end

@implementation KDSetupVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}


-(void)addChildViews{
    UIView* topBgView =[[UIView alloc]initWithFrame:CGRectMake(kLeftX,NavibarH, kAdaptationWidth(339), kAdaptationWidth(141))];
    topBgView.backgroundColor=[UIColor whiteColor];
    topBgView.layer.cornerRadius=8.0f;
    topBgView.layer.masksToBounds=YES;
    [self.view addSubview:topBgView];
    
    //访问官网
    UILabel* gwLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(18), kAdaptationWidth(100), kAdaptationWidth(18))];
    gwLabel.font=PingFangRegular(15);
    gwLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    gwLabel.text=@"访问官网";
    [topBgView addSubview:gwLabel];
    
    //关注微信
    UILabel* wxLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(57), kAdaptationWidth(100), kAdaptationWidth(18))];
    wxLabel.font=PingFangRegular(15);
    wxLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    wxLabel.text=@"关注微信";
    [topBgView addSubview:wxLabel];
    
    //快递摸摸哒
    UILabel* kdLabel=[[UILabel alloc]initWithFrame:CGRectMake( kAdaptationWidth(150), wxLabel.top, kAdaptationWidth(100), kAdaptationWidth(18))];
    kdLabel.font=PingFangRegular(15);
    kdLabel.textColor=[UIColor colorWithHex:@"#A6A6A6"];
    kdLabel.text=@"快递么么哒";
    kdLabel.textAlignment=NSTextAlignmentRight;
    [topBgView addSubview:kdLabel];
    kdLabel.right =topBgView.width- kAdaptationWidth(50);
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(90), kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#F1F1F1"];
    [topBgView addSubview:sepLabel];
    
    //APP store 评论
    UILabel* commentdLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(109), kAdaptationWidth(180), kAdaptationWidth(18))];
    commentdLabel.font=PingFangRegular(15);
    commentdLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    commentdLabel.text=@"APP Store 评论支持我们";
    [topBgView addSubview:commentdLabel];
    
    //缓存cache
    UIView* cacheBgView =[[UIView alloc]initWithFrame:CGRectMake(kLeftX,topBgView.bottom+kAdaptationWidth(12), kAdaptationWidth(339), kAdaptationWidth(51))];
    cacheBgView.backgroundColor=[UIColor whiteColor];
    cacheBgView.layer.cornerRadius=8.0f;
    cacheBgView.layer.masksToBounds=YES;
    [self.view addSubview:cacheBgView];
    
    UILabel* cacheDesLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(19), kAdaptationWidth(150), kAdaptationWidth(18))];
    cacheDesLabel.font=PingFangRegular(15);
    cacheDesLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    cacheDesLabel.text=@"清除缓存";
    [cacheBgView addSubview:cacheDesLabel];
    cacheDesLabel.centerY=cacheBgView.height/2.0;
    
    UILabel* cacheLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, cacheDesLabel.top, kAdaptationWidth(100), kAdaptationWidth(18))];
    cacheLabel.font=PingFangRegular(15);
    cacheLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    cacheLabel.text=@"0.71M";
    [cacheBgView addSubview:cacheLabel];
    cacheLabel.textAlignment=NSTextAlignmentRight;
    cacheLabel.right =cacheBgView.width- kAdaptationWidth(50);
    
    //退出登录
    UIView* quitBgView =[[UIView alloc]initWithFrame:CGRectMake(kLeftX,cacheBgView.bottom+kAdaptationWidth(12), kAdaptationWidth(339), kAdaptationWidth(51))];
    quitBgView.backgroundColor=[UIColor whiteColor];
    quitBgView.layer.cornerRadius=8.0f;
    quitBgView.layer.masksToBounds=YES;
    [self.view addSubview:quitBgView];
    
    UILabel* quitLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(19), kAdaptationWidth(150), kAdaptationWidth(18))];
    quitLabel.font=PingFangRegular(15);
    quitLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    quitLabel.text=@"退出登录";
    [quitBgView addSubview:quitLabel];
    quitLabel.centerY=quitBgView.height/2.0;
    
}

-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"系统设置"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}

@end
