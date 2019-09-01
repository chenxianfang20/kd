//
//  KDHelpVC.m
//  Kuaidi
//
//  Created by cxf on 2019/9/1.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDHelpVC.h"

@interface KDHelpVC ()
@property (nonatomic,strong) UIView *sendBgView;
@property (nonatomic,strong) UIButton *sendBtn;

@property (nonatomic,strong) UIView *checkBgView;
@property (nonatomic,strong) UIButton *checkBtn;

@property (nonatomic,strong) UIView *problemBgView;
@property (nonatomic,strong) UIButton *problemBtn;

@end
@implementation KDHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self addChildViews];
}

-(void)addChildViews{
    self.view.backgroundColor = rgb(230, 230, 230, 1);
    
    //寄件相关
    self.sendBgView=[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), NavibarH+kLeftX, kAdaptationWidth(339), kAdaptationWidth(210))];
    self.sendBgView.backgroundColor=rgb(238, 238, 238, 1);
    self.sendBgView.layer.cornerRadius=10.0f;
    self.sendBgView.layer.masksToBounds=YES;
    [self.view addSubview:self.sendBgView];
    
    UIView* sendTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAdaptationWidth(339), kAdaptationWidth(50))];
    sendTopView.backgroundColor=[UIColor whiteColor];
    sendTopView.layer.cornerRadius=10.0f;
    sendTopView.layer.masksToBounds=YES;
    [self.sendBgView addSubview:sendTopView];
    sendTopView.userInteractionEnabled=YES;
    UITapGestureRecognizer* sendTopViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendTopViewTapClick)];
    [sendTopView addGestureRecognizer:sendTopViewTap];
    
    
    UILabel* sendTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  kAdaptationWidth(18), kAdaptationWidth(100), kAdaptationWidth(18))];
    sendTitleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    sendTitleLabel.font =  PingFangBold(15);
    sendTitleLabel.text=@"寄件相关";
    [sendTopView addSubview:sendTitleLabel];
    sendTitleLabel.centerY =sendTopView.height/2.0;
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(306), 21, 12, 12)];
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
    _sendBtn.enabled = NO;
    _sendBtn.tag =0;
    _sendBtn.centerY =sendTopView.height/2.0;
    [sendTopView addSubview:_sendBtn];
    
    
    NSArray* titleArr =  @[@"下单成功后，如何支付?",@"如何联系快递员?",@"下单成功后，如何支付?",@"如何联系快递员?"];
    for (NSInteger i = 0; i<4; i++) {
        UILabel* topTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  i*kAdaptationWidth(37.5)+sendTopView.bottom+5, kAdaptationWidth(200), kAdaptationWidth(37.5))];
        topTitleLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
        topTitleLabel.font =  PingFangRegular(15);
        topTitleLabel.text=titleArr[i];
        [self.sendBgView addSubview:topTitleLabel];
    }
    
    //查件相关
    self.checkBgView=[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), self.sendBgView.bottom+12, kAdaptationWidth(339), kAdaptationWidth(50))];
    self.checkBgView.backgroundColor=rgb(238, 238, 238, 1);
    self.checkBgView.layer.cornerRadius=10.0f;
    self.checkBgView.layer.masksToBounds=YES;
    [self.view addSubview:self.checkBgView];
    
    UIView* checkTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAdaptationWidth(339), kAdaptationWidth(50))];
    checkTopView.backgroundColor=[UIColor whiteColor];
    checkTopView.layer.cornerRadius=10.0f;
    checkTopView.layer.masksToBounds=YES;
    [self.checkBgView addSubview:checkTopView];
    checkTopView.userInteractionEnabled=YES;
    UITapGestureRecognizer* checkTopViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkTopViewTapClick)];
    [checkTopView addGestureRecognizer:checkTopViewTap];
    
    
    UILabel* checkTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  kAdaptationWidth(18), kAdaptationWidth(100), kAdaptationWidth(18))];
    checkTitleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    checkTitleLabel.font =  PingFangBold(15);
    checkTitleLabel.text=@"查件相关";
    [checkTopView addSubview:checkTitleLabel];
    checkTitleLabel.centerY =checkTopView.height/2.0;
    
    _checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(306), 21, 12, 12)];
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
    _checkBtn.tag =0;
    _checkBtn.enabled = NO;
    _checkBtn.centerY =checkTopView.height/2.0;
    [checkTopView addSubview:_checkBtn];
    
    //问题相关
    self.problemBgView=[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), self.checkBgView.bottom+12, kAdaptationWidth(339), kAdaptationWidth(50))];
    self.problemBgView.backgroundColor=rgb(238, 238, 238, 1);
    self.problemBgView.layer.cornerRadius=10.0f;
    self.problemBgView.layer.masksToBounds=YES;
    [self.view addSubview:self.problemBgView];
    
    UIView* problemTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAdaptationWidth(339), kAdaptationWidth(50))];
    problemTopView.backgroundColor=[UIColor whiteColor];
    problemTopView.layer.cornerRadius=10.0f;
    problemTopView.layer.masksToBounds=YES;
    [self.problemBgView addSubview:problemTopView];
    problemTopView.userInteractionEnabled=YES;
    UITapGestureRecognizer* problemTopViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(problemTopViewTapClick)];
    [problemTopView addGestureRecognizer:problemTopViewTap];
    
    
    UILabel* problemTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  kAdaptationWidth(18), kAdaptationWidth(100), kAdaptationWidth(18))];
    problemTitleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    problemTitleLabel.font =  PingFangBold(15);
    problemTitleLabel.text=@"问题相关";
    [problemTopView addSubview:problemTitleLabel];
    problemTitleLabel.centerY =problemTopView.height/2.0;
    
    _problemBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(306), 21, 12, 12)];
    [_problemBtn setBackgroundImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
    _problemBtn.tag =0;
    _problemBtn.enabled = NO;
    _problemBtn.centerY =problemTopView.height/2.0;
    [problemTopView addSubview:_problemBtn];
}

//点击寄件相关顶部
-(void)sendTopViewTapClick{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        
        if(weakSelf.sendBtn.tag == 0){
            weakSelf.sendBgView.height = kAdaptationWidth(50);
            [weakSelf.sendBtn setBackgroundImage:[UIImage imageNamed:@"图标-上"] forState:UIControlStateNormal];
            weakSelf.sendBtn.tag =1;
        }else{
            weakSelf.sendBgView.height = kAdaptationWidth(210);
            [weakSelf.sendBtn setBackgroundImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
            weakSelf.sendBtn.tag =0;
        }
        weakSelf.checkBgView.top = weakSelf.sendBgView.bottom+ 12;
        weakSelf.problemBgView.top =weakSelf.checkBgView.bottom+12;
    }];
   
}
//点击插件相关
-(void)checkTopViewTapClick{
    
}

//点击问题相关
-(void)problemTopViewTapClick{
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"帮助中心"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(230, 230, 230, 1)];
}
@end
