//
//  KDResetLoginPwdVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDResetLoginPwdVC.h"
#import "UIButton+EnlargeTouchArea.h"

@interface KDResetLoginPwdVC(){
    UIButton*  doneBtn;
}
@property (nonatomic,strong) UITextField *pwdTF;


@end
@implementation KDResetLoginPwdVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self addChildViews];
    
}
-(void)addChildViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    //大标题
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(42), kScreenWidth, 30)];
    titleLabel.text=@"请设置登录新密码";
    titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    titleLabel.font =PingFangBold(30);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //副标题
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,titleLabel.bottom, kScreenWidth, 30)];
    desLabel.text=@"密码长度不小于6位";
    desLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    desLabel.font =PingFangMedium(15);
    desLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:desLabel];
    
    self.pwdTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), desLabel.bottom+ kAdaptationWidth(45), kAdaptationWidth(303), kAdaptationWidth(50))];
    self.pwdTF.secureTextEntry=YES;
    self.pwdTF.textColor=[UIColor colorWithHex:@"#DF2F31"];
    self.pwdTF.font= PingFangBold(25);
    self.pwdTF.placeholder=@"请输入登录密码";
    [self.pwdTF setValue: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.pwdTF];
    [self.pwdTF addTarget:self action:@selector(phoneTFChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), self.pwdTF.bottom, kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#DF2F31"];
    [self.view addSubview:sepLabel];
    
    //密码是否隐藏
    UIButton* pwdShowStyleBtn =[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(321), kAdaptationWidth(217), kAdaptationWidth(20), kAdaptationWidth(20))];
    [pwdShowStyleBtn setBackgroundImage:[UIImage imageNamed:@"注册-图标-开眼"] forState:UIControlStateNormal];
    [pwdShowStyleBtn setEnlargeEdge:15];
    pwdShowStyleBtn.centerY=self.pwdTF.centerY;
    [pwdShowStyleBtn addTarget:self action:@selector(pwdShowStyleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pwdShowStyleBtn];
    
    
    //注册
    doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), sepLabel.bottom+kAdaptationWidth(62), kAdaptationWidth(303), kAdaptationWidth(54))];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.userInteractionEnabled=NO;
    [doneBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
    doneBtn.layer.cornerRadius=kAdaptationWidth(2);
    doneBtn.layer.masksToBounds=YES;
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
//    //同意条例
//    UIButton* agreeBtn =[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(36),doneBtn.bottom+ kAdaptationWidth(17), kAdaptationWidth(20), kAdaptationWidth(20))];
//    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"注册-图标-选中"] forState:UIControlStateNormal];
//    agreeBtn.tag= 1;
//    [agreeBtn setEnlargeEdge:15];
//    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:agreeBtn];
//    
//    UILabel* agreeLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(62),agreeBtn.top, kAdaptationWidth(280), 20)];
//    agreeLabel.text=@"我已阅读并同意《注册协议》和《隐私条例》";
//    agreeLabel.textColor=rgb(120, 120, 120, 120);
//    agreeLabel.font =[UIFont fontWithName:@"PingFang SC" size: 14];
//    [self.view addSubview:agreeLabel];
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:agreeLabel.text];
//    
//    [string addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#0B0B0B"]} range:NSMakeRange(7, 6)];
//    
//    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:@"#0B0B0B"]} range:NSMakeRange(14, 6)];
//    agreeLabel.attributedText=string;
    
}
//是否显示密码
-(void)pwdShowStyleBtnClick:(UIButton*)btn{
    if(self.pwdTF.isSecureTextEntry == YES){
        self.pwdTF.secureTextEntry = NO;
    }else{
        self.pwdTF.secureTextEntry = YES;
    }
}
//是否同意条例
-(void)agreeBtnClick:(UIButton*)btn{
    if(btn.tag == 1){
        //[registerBtn setBackgroundImage:[UIImage imageWithColor:rgb(230, 230, 230, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"注册-图标-未选"] forState:UIControlStateNormal];
        doneBtn.enabled=NO;
        btn.tag = 0;
        
    }else{
        //[registerBtn setBackgroundImage:[UIImage imageWithColor:rgb(247, 70, 74, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"注册-图标-选中"] forState:UIControlStateNormal];
        doneBtn.enabled=YES;
        btn.tag = 1;
    }
}
-(void)doneBtnClick{
    if(self.pwdTF.text.length == 0){
        [self.view showToastWithText:@"请输入登录密码" time:1];
        return;
    }
    if(self.pwdTF.text.length <6){
        [self.view showToastWithText:@"密码不得少于6位" time:1];
        return;
    }
    
}

-(void)phoneTFChanged:(UITextField*)text{
    if (text.text.length>=6) {//输入完成
        doneBtn.userInteractionEnabled=YES;
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setBackgroundImage:[UIImage imageWithColor:rgb(247, 70, 74, 1)] forState:UIControlStateNormal];
    }else{
        doneBtn.userInteractionEnabled=NO;
        [doneBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
        [doneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
    }
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"快速注册"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:[UIColor whiteColor]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
