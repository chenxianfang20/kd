//
//  HCTCodeVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/17.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDCodeVC.h"
#import "CRBoxInputView.h"
#import "KDLoginPwdVC.h"
@interface KDCodeVC ()
@property(nonatomic ,strong)NSString* codeStr;
@property (nonatomic,strong) UIButton*  nextBtn ;
@end

@implementation KDCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}
-(void)addChildViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    //大标题
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(42), kScreenWidth, 30)];
    titleLabel.text=@"请输入短信验证";
    titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    titleLabel.font =[UIFont fontWithName:@"PingFang SC" size: 30];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //副标题
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,titleLabel.bottom+ kAdaptationWidth(6), kScreenWidth, 30)];
    desLabel.text=[NSString stringWithFormat:@"验证码已经发送至：%@",self.phoneStr];
    desLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    desLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    desLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:desLabel];
    
    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(kAdaptationWidth(36), desLabel.bottom+kAdaptationWidth(70), kAdaptationWidth(303), 50)];
    boxInputView.codeLength = 6;// 不设置时，默认4
    boxInputView.keyBoardType = UIKeyboardTypeNumberPad;// 不设置时，默认UIKeyboardTypeNumberPad
    [boxInputView loadAndPrepareViewWithBeginEdit:YES]; // BeginEdit:是否自动启用编辑模式
    [self.view addSubview:boxInputView];
    __weak typeof(self)weakSelf = self;
    boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        
        
        [weakSelf  endEdit:text];
    };
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.showLine = YES; //必需
    cellProperty.borderWidth=0;
    cellProperty.cellFont=[UIFont fontWithName:@"PingFang SC" size: 30];
    cellProperty.cellTextColor=[UIColor colorWithHex:@"#DF2F31"];
    cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
        CRLineView *lineView = [CRLineView new];
        lineView.underlineColorNormal = [UIColor colorWithHex:@"#DF2F31"];
        lineView.underlineColorSelected = [UIColor colorWithHex:@"#DF2F31"];
        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.left.right.bottom.offset(0);
        }];
        
        return lineView;
    }; //可选
    
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    
    //快速注册按钮
    UIButton* resendCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, boxInputView.bottom, kAdaptationWidth(105), kAdaptationWidth(40))];
    [resendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    resendCodeBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [resendCodeBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [resendCodeBtn addTarget:self action:@selector(resendCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resendCodeBtn];
    
    
    //下一步
    _nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(36), boxInputView.bottom+kAdaptationWidth(72), kAdaptationWidth(303), kAdaptationWidth(54))];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:rgb(247, 70, 74, 1)] forState:UIControlStateNormal];
    _nextBtn.layer.cornerRadius=kAdaptationWidth(2);
    _nextBtn.layer.masksToBounds=YES;
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    _nextBtn.userInteractionEnabled=NO;
    [_nextBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
    
}
//重新发送验证码
-(void)resendCodeBtnClick{
    
}
-(void)nextBtnClick{
    if(self.codeStr.length!= 6){
        [self.view showToastWithText:@"验证码输入不全" time:1];
        
        return;
    }
    
    KDLoginPwdVC* vc= [[KDLoginPwdVC alloc]init];
    vc.codeStr=self.codeStr;
    vc.phoneStr = self.phoneStr;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)endEdit:(NSString*)text{
    NSLog(@"text:%@", text);
    self.codeStr = text;
    if (text.length>=6) {//输入完成
        _nextBtn.userInteractionEnabled=YES;
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:rgb(247, 70, 74, 1)] forState:UIControlStateNormal];
    }else{
        _nextBtn.userInteractionEnabled=NO;
        [_nextBtn setTitleColor:[UIColor colorWithHex:@"#A9A9A9"]  forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#F1F1F1"]] forState:UIControlStateNormal];
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
