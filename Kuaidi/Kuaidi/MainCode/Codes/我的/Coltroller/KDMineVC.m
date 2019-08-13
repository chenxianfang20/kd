//
//  KDMineVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMineVC.h"

@interface KDMineVC ()
//头像图片
@property(nonatomic,strong)UIImageView* headImgVIew;
//账号label
@property(nonatomic,strong)UILabel* nameLabel;

@end

@implementation KDMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViews];
}
//66666666666
-(void)addChildViews{
    
    //隐藏自定义导航栏
    self.nav.hidden = YES;
    
    //顶部背景图片
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(198))];
    topBgImgView.image = [UIImage imageNamed:@"我的-背景"];
    [self.view addSubview:topBgImgView];
    
    //头像图片
    _headImgVIew = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(64), kAdaptationWidth(60), kAdaptationWidth(60))];
    _headImgVIew.image = [UIImage imageNamed:@"图片-头像"];
    [self.view addSubview:_headImgVIew];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(96), kAdaptationWidth(73), kAdaptationWidth(260), kAdaptationWidth(22))];
    _nameLabel.text=@"登录/注册";
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 22];
    [self.view addSubview:_nameLabel];
    
    //欢迎使用快递么
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(96),_nameLabel.bottom+ kAdaptationWidth(7), kAdaptationWidth(260), kAdaptationWidth(15))];
    desLabel.text=@"欢迎使用快递么";
    desLabel.textColor=[UIColor whiteColor];
    desLabel.font =[UIFont fontWithName:@"PingFang-SC-Regular" size: 13];
    [self.view addSubview:desLabel];
    
    //寄件二维码UIView*******
    UIView*  scanView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), _headImgVIew.bottom+kAdaptationWidth(24), kAdaptationWidth(339), kAdaptationWidth(60))];
    scanView.backgroundColor=[UIColor whiteColor];
    scanView.layer.cornerRadius=6.0f;
    scanView.layer.masksToBounds=YES;
    [self.view addSubview:scanView];
    
    UILabel* scanTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), 0, kAdaptationWidth(120), kAdaptationWidth(60))];
    scanTitleLabel.text=@"寄件二维码";
    scanTitleLabel.textColor=[UIColor blackColor];
    scanTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [scanView addSubview:scanTitleLabel];
    
    UIImageView* scanIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(297), kAdaptationWidth(10), kAdaptationWidth(18), kAdaptationWidth(18))];
    scanIconImgView.image=[UIImage imageNamed:@"我的-图标-二维码"];
    [scanView addSubview:scanIconImgView];
    scanIconImgView.centerY=scanTitleLabel.centerY;
    
    //淘宝客  京东客
    UIView*  platformView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), scanView.bottom+kAdaptationWidth(12), kAdaptationWidth(339), kAdaptationWidth(103))];
    platformView.backgroundColor=[UIColor whiteColor];
    platformView.layer.cornerRadius=6.0f;
    platformView.layer.masksToBounds=YES;
    [self.view addSubview:platformView];
    
    //淘宝客Btn
    UIButton* tbBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(67), kAdaptationWidth(16), kAdaptationWidth(53), kAdaptationWidth(52))];
    [tbBtn setBackgroundImage:[UIImage imageNamed:@"图标-淘宝"] forState:UIControlStateNormal];
    [tbBtn addTarget:self action:@selector(tbBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [platformView addSubview:tbBtn];
    //淘宝客Label
    UILabel* tbLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(67), kAdaptationWidth(71), tbBtn.width, kAdaptationWidth(15))];
    tbLabel.text=@"淘宝客";
    tbLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    tbLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
    tbLabel.textAlignment=NSTextAlignmentCenter;
    [platformView addSubview:tbLabel];
    
    
    //京东Btn
    UIButton* jdBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(219), kAdaptationWidth(16), kAdaptationWidth(53), kAdaptationWidth(52))];
    [jdBtn setBackgroundImage:[UIImage imageNamed:@"图标-京东"] forState:UIControlStateNormal];
    [jdBtn addTarget:self action:@selector(jdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [platformView addSubview:jdBtn];
    //京东Label
    UILabel* jdLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(219), kAdaptationWidth(71), jdBtn.width, kAdaptationWidth(15))];
    jdLabel.text=@"京东客";
    jdLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    jdLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
    jdLabel.textAlignment=NSTextAlignmentCenter;
    [platformView addSubview:jdLabel];
    
    //订单导入UIView*******
    UIView*  orderBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), platformView.bottom+kAdaptationWidth(12), kAdaptationWidth(339), kAdaptationWidth(105))];
    orderBgView.backgroundColor=[UIColor whiteColor];
    orderBgView.layer.cornerRadius=6.0f;
    orderBgView.layer.masksToBounds=YES;
    [self.view addSubview:orderBgView];
    
    UILabel* orderTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(15), kAdaptationWidth(120), kAdaptationWidth(15))];
    orderTitleLabel.text=@"订单导入";
    orderTitleLabel.textColor=[UIColor blackColor];
    orderTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [orderBgView addSubview:orderTitleLabel];
    
    NSArray* btnImgNameArr = @[@"我的-图标-淘宝",@"我的-图标-京东",@"我的-图标-顺丰"];
    for(NSInteger i=0;i<3;i++){
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(33)+i* kAdaptationWidth(48+65),orderTitleLabel.bottom+kAdaptationWidth(10), kAdaptationWidth(48), kAdaptationWidth(48))];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:btnImgNameArr[i]] forState:UIControlStateNormal];
        btn.layer.borderWidth=1.0f;
        btn.layer.borderColor=rgb(220, 220, 220, 1).CGColor;
        btn.layer.cornerRadius=kAdaptationWidth(24);
        btn.layer.masksToBounds=YES;
        [orderBgView addSubview:btn];
    }
    
}

//淘宝客按钮
-(void)tbBtnClick{
    
}
//京东按钮
-(void)jdBtnClick{
    
}
@end
