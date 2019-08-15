//
//  KDLoginVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/14.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDLoginVC.h"

@interface KDLoginVC ()
@property (nonatomic,strong) UITextField *phoneTF;
@property (nonatomic,strong) UITextField *pwdTF;
@end

@implementation KDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self addChildViews];
}
-(void)addChildViews{
    self.view.backgroundColor=[UIColor colorWithHex:@"#FAF8F8"];
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
    
    //账户
    UIImageView*  phoneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(24), kAdaptationWidth(18), kAdaptationWidth(18))];
    phoneImgView.image= [UIImage imageNamed:@"图标-账号"];
    [infoBgView addSubview:phoneImgView];
    
    self.phoneTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), kAdaptationWidth(5), kAdaptationWidth(270), kAdaptationWidth(50))];
    self.phoneTF.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    self.phoneTF.font= [UIFont fontWithName:@"PingFang-SC-Medium" size: 18];
    self.phoneTF.placeholder=@"请输入手机号码";
    self.phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.phoneTF setValue: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15] forKeyPath:@"_placeholderLabel.font"];
    [infoBgView addSubview:self.phoneTF];
    self.phoneTF.clearButtonMode=UITextFieldViewModeAlways;
    [self.phoneTF addTarget:self action:@selector(phoneTFChanged:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.centerY =phoneImgView.centerY;
    
    //分割线
    UILabel* sepLabel= [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(66), kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor= [UIColor colorWithHex:@"#F1F1F1"];
    [infoBgView addSubview:sepLabel];
    
    //密码
    UIImageView*  pwdImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(90), kAdaptationWidth(18), kAdaptationWidth(18))];
    pwdImgView.image= [UIImage imageNamed:@"图标-密码"];
    [infoBgView addSubview:pwdImgView];
    
    self.pwdTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), kAdaptationWidth(80), kAdaptationWidth(270), kAdaptationWidth(50))];
    self.pwdTF.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    self.pwdTF.font= [UIFont fontWithName:@"PingFang-SC-Medium" size: 18];
    self.pwdTF.placeholder=@"请输入密码";
    //self.pwdTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.pwdTF setValue: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15] forKeyPath:@"_placeholderLabel.font"];
    self.pwdTF.secureTextEntry=YES;
    [infoBgView addSubview:self.pwdTF];
    self.pwdTF.clearButtonMode=UITextFieldViewModeAlways;
    [self.pwdTF addTarget:self action:@selector(pwdTFChanged:) forControlEvents:UIControlEventEditingChanged];
    self.pwdTF.centerY =pwdImgView.centerY;
    
    UIView* longinBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(132) , kAdaptationWidth(339), kAdaptationWidth(84))];
    longinBgView.backgroundColor=[UIColor colorWithHex:@"#FAF8F8"];
    [infoBgView addSubview:longinBgView];
    
    UIButton* loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(150), kAdaptationWidth(303), kAdaptationWidth(48))];
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#ECECEC"]] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [loginBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [infoBgView addSubview:loginBtn];
    
    //快速注册按钮
    UIButton* registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(2, infoBgView.bottom+ kAdaptationWidth(2), kAdaptationWidth(105), kAdaptationWidth(50))];
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [registerBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    //忘记密码按钮
    UIButton* forgetPwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-kAdaptationWidth(105), infoBgView.bottom+ kAdaptationWidth(2), kAdaptationWidth(105), kAdaptationWidth(50))];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [forgetPwdBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
    
    //微信登录
    UIButton* wxLoginBtn =  [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(48), forgetPwdBtn.bottom+ kAdaptationWidth(90), kAdaptationWidth(54), kAdaptationWidth(54))];
    wxLoginBtn.backgroundColor=[UIColor whiteColor];
    [wxLoginBtn setImage:[UIImage imageNamed:@"图标-微信"] forState:UIControlStateNormal];
    wxLoginBtn.layer.cornerRadius = kAdaptationWidth(27);
    wxLoginBtn.layer.masksToBounds=YES;
    [wxLoginBtn addTarget:self action:@selector(wxLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxLoginBtn];
    
    UILabel* wxLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(47),wxLoginBtn.bottom+ kAdaptationWidth(12), kAdaptationWidth(68), kAdaptationWidth(13))];
    wxLabel.text=@"微信登录";
    wxLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    wxLabel.font =[UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
    wxLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:wxLabel];
    wxLabel.centerX=wxLoginBtn.centerX;
    
    //qq登录
    UIButton* qqLoginBtn =  [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(161), forgetPwdBtn.bottom+ kAdaptationWidth(90), kAdaptationWidth(54), kAdaptationWidth(54))];
    qqLoginBtn.backgroundColor=[UIColor whiteColor];
    [qqLoginBtn setImage:[UIImage imageNamed:@"图标-QQ"] forState:UIControlStateNormal];
    qqLoginBtn.layer.cornerRadius = kAdaptationWidth(27);
    qqLoginBtn.layer.masksToBounds=YES;
    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqLoginBtn];
    
    UILabel* qqLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(163),qqLoginBtn.bottom+ kAdaptationWidth(12), kAdaptationWidth(68), kAdaptationWidth(13))];
    qqLabel.text=@"QQ登录";
    qqLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    qqLabel.font =[UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
    qqLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:qqLabel];
    qqLabel.centerX=qqLoginBtn.centerX;
    
    //微博登录
    UIButton* wbLoginBtn =  [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(274), forgetPwdBtn.bottom+ kAdaptationWidth(90), kAdaptationWidth(54), kAdaptationWidth(54))];
    wbLoginBtn.backgroundColor=[UIColor whiteColor];
    [wbLoginBtn setImage:[UIImage imageNamed:@"图标-微博"] forState:UIControlStateNormal];
    wbLoginBtn.layer.cornerRadius = kAdaptationWidth(27);
    wbLoginBtn.layer.masksToBounds=YES;
    [wbLoginBtn addTarget:self action:@selector(wbLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wbLoginBtn];
    
    UILabel* wbLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(274),wbLoginBtn.bottom+ kAdaptationWidth(12), kAdaptationWidth(68), kAdaptationWidth(13))];
    wbLabel.text=@"微博登录";
    wbLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    wbLabel.font =[UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
    wbLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:wbLabel];
    wbLabel.centerX=wbLoginBtn.centerX;
}

-(void)phoneTFChanged:(UITextField*)text{
    
}

-(void)pwdTFChanged:(UITextField*)text{
    
}

-(void)loginBtnClick{
    
}

-(void)registerBtnClick{
    
}
-(void)forgetPwdBtnClick{
    
}
-(void)wxLoginBtnClick{
    
}
-(void)qqLoginBtnClick{
    
}
-(void)wbLoginBtnClick{
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    [self.titleView setTitle:@"登录"];
    self.nav.backgroundColor = [UIColor clearColor];
    self.backgroungImgView.hidden=YES;
}

@end
