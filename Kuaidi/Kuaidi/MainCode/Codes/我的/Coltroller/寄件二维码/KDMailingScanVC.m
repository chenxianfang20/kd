//
//  KDMailingScanVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMailingScanVC.h"
@interface KDMailingScanVC()

@end
@implementation KDMailingScanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}


-(void)addChildViews{
    
    UIScrollView* scrollowView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight-kAdaptationWidth(90)-NavibarH )];
    scrollowView.scrollEnabled=YES;
    scrollowView.backgroundColor=rgb(245, 245, 245, 1);
    [self.view addSubview:scrollowView];
    
    UIView* topBgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), 2, kAdaptationWidth(267), kAdaptationWidth(371))];
    topBgView.backgroundColor=[UIColor whiteColor];
    topBgView.layer.cornerRadius=8.0f;
    topBgView.layer.masksToBounds=YES;
    [scrollowView addSubview:topBgView];
    
    UIView* redBgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAdaptationWidth(371), kAdaptationWidth(264))];
    redBgView.backgroundColor=[UIColor redColor];
    [topBgView addSubview:redBgView];
    //标题
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(15), kAdaptationWidth(267), 20)];
    titleLabel.text=@"微信扫一扫 直接寄快递";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font =[UIFont fontWithName:@"PingFang SC" size: 18];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topBgView addSubview:titleLabel];
    
    UIView* whiteScanBgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(41), titleLabel.bottom+kAdaptationWidth(10), kAdaptationWidth(186), kAdaptationWidth(186))];
    whiteScanBgView.backgroundColor=[UIColor whiteColor];
    [topBgView addSubview:whiteScanBgView];
    
    //描述文字
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, redBgView.bottom+ kAdaptationWidth(8), kAdaptationWidth(267), 43)];
    desLabel.text=@"扫码后填写你的收件地址，我就\n可以给你寄快递了！";
    desLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    desLabel.font =[UIFont fontWithName:@"PingFang SC" size: 14];
    desLabel.textAlignment=NSTextAlignmentCenter;
    desLabel.numberOfLines=0;
    [topBgView addSubview:desLabel];
    
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), desLabel.bottom+kAdaptationWidth(8), kAdaptationWidth(231), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#F1F1F1"];
    [topBgView addSubview:sepLabel];
    
    //描述文字
    UILabel* bottomDesLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, sepLabel.bottom+ kAdaptationWidth(2), kAdaptationWidth(267), 43)];
    bottomDesLabel.text=@"由快递么提供技术支持";
    bottomDesLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    bottomDesLabel.font =[UIFont fontWithName:@"PingFang SC" size: 13];
    bottomDesLabel.textAlignment=NSTextAlignmentCenter;
    [topBgView addSubview:bottomDesLabel];
    
    
    
    
    //底部分享按钮
    UIView* shareBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    shareBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:shareBgView];
    
    //下一步
    UIButton*  shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [shareBtn setTitle:@"分享给微信好友" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius=kAdaptationWidth(10);
    shareBtn.layer.masksToBounds=YES;
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBgView addSubview:shareBtn];
    
}

-(void)shareBtnClick{
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"寄件二维码"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
