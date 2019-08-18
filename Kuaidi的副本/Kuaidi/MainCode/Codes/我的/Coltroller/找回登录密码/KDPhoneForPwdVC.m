//
//  KDPhoneForPwdVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/17.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDPhoneForPwdVC.h"
#import "KDCodeForPwdVC.h"
@interface KDPhoneForPwdVC()
{
    NSInteger i;
    UIButton*  nextBtn;
}
@property (nonatomic,strong) UITextField *phoneTF;;
@end
@implementation KDPhoneForPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    i = 0;
    [self setNav];
    [self addChildViews];
    
}
-(void)addChildViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    //大标题
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(42), kScreenWidth, 30)];
    titleLabel.text=@"请输入手机号码";
    titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    titleLabel.font =PingFangBold(30);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //副标题
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,titleLabel.bottom, kScreenWidth, 30)];
    desLabel.text=@"请输入注册时所填的手机号码";
    desLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    desLabel.font =PingFangMedium(15);
    desLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:desLabel];
    
    self.phoneTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), desLabel.bottom+ kAdaptationWidth(62), kAdaptationWidth(303), kAdaptationWidth(50))];
    self.phoneTF.textColor=[UIColor colorWithHex:@"#DF2F31"];
    self.phoneTF.font= PingFangBold(30);
    self.phoneTF.placeholder=@"请输入手机号码";
    self.phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.phoneTF setValue: PingFangBold(25) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.phoneTF];
    self.phoneTF.clearButtonMode=UITextFieldViewModeAlways;
    [self.phoneTF addTarget:self action:@selector(phoneTFChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), _phoneTF.bottom, kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#DF2F31"];
    [self.view addSubview:sepLabel];
    
    //下一步
     nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), sepLabel.bottom+kAdaptationWidth(72), kAdaptationWidth(303), kAdaptationWidth(54))];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
     [nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius=kAdaptationWidth(2);
    nextBtn.layer.masksToBounds=YES;
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.userInteractionEnabled=NO;
    
}
-(void)nextBtnClick{
    if(self.phoneTF.text.length == 0){
        [self.view showToastWithText:@"请输入手机号" time:1];
        return;
    }
    NSString *phoneFieldStr =[self.phoneTF.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    if(![NSString isValidatePhoneNum:phoneFieldStr]){
        [self.view showToastWithText:@"手机号不合法" time:1];
        return;
    }
    
    KDCodeForPwdVC* vc= [[KDCodeForPwdVC alloc]init];
    vc.phoneStr = self.phoneTF.text;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)phoneTFChanged:(UITextField*)textField{
    if (textField == self.phoneTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
            }
            i = textField.text.length;
            
        }else if (textField.text.length < i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
        NSString *phoneFieldStr =[self.phoneTF.text stringByReplacingOccurrencesOfString:@" "withString:@""];
        if (textField.text.length >= 13 && [NSString isValidatePhoneNum:phoneFieldStr]) {//输入完成
            nextBtn.userInteractionEnabled=YES;
            [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [nextBtn setBackgroundImage:[UIImage imageWithColor:rgb(247, 70, 74, 1)] forState:UIControlStateNormal];
        }else{
            nextBtn.userInteractionEnabled=NO;
            [nextBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
            [nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
        }
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
