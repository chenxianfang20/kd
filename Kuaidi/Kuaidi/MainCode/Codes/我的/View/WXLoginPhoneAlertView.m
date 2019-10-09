//
//  WXLoginPhoneAlertView.m
//  Kuaidi
//
//  Created by ljp on 2019/10/8.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "WXLoginPhoneAlertView.h"


@interface WXLoginPhoneAlertView()

@property(nonatomic, strong)UIView *maskBgView;

@property(nonatomic, strong)UITextField *phoneTextFiled;

@property(nonatomic, copy)void(^Block)(NSString *phoneNum);

@end

@implementation WXLoginPhoneAlertView

+(void)wx_LoginPhoneAlertViewShowWithCompeleteBlock:(void(^)(NSString *phoneNum))Block{
    
    WXLoginPhoneAlertView *alertView = [[WXLoginPhoneAlertView alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    alertView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    alertView.layer.cornerRadius = 5;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.alpha = 0;
    alertView.Block = Block;
    
    UIView *maskBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.maskBgView = maskBgView;
    maskBgView.backgroundColor = rgb(0, 0, 0, 0.3);
    maskBgView.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:alertView action:@selector(hidden)];
    [maskBgView addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:maskBgView];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    [UIView animateWithDuration:.25 animations:^{
        alertView.alpha = 1.0;
        maskBgView.alpha = 1.0;
    }];
}


- (void)hidden{
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.alpha = 0;
        self.maskBgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskBgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请输入您的手机号码";
    titleLabel.textColor = rgb(33, 33, 33, 1.0);
    titleLabel.font = PingFangMedium(15);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.centerX.equalTo(self).offset(0);
    }];
    
    //textfield
    UIView *phoneView = [[UIView alloc] init];
    phoneView.layer.cornerRadius = 3;
    phoneView.layer.borderWidth = 1.0;
    phoneView.layer.borderColor = rgb(240, 240, 240, 1.0).CGColor;
    [self addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(36);
    }];
    
    UITextField *phoneTextFiled = [[UITextField alloc] init];
    self.phoneTextFiled = phoneTextFiled;
    phoneTextFiled.textColor = rgb(33, 33, 33, 1.0);
    phoneTextFiled.font = PingFangMedium(16);
    phoneTextFiled.textAlignment = NSTextAlignmentCenter;
    phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextFiled.returnKeyType = UIReturnKeyDone;
    [phoneTextFiled becomeFirstResponder];
    [phoneView addSubview:phoneTextFiled];
    [phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView).offset(5);
        make.bottom.equalTo(phoneView).offset(-5);
        make.left.equalTo(phoneView).offset(20);
        make.right.equalTo(phoneView).offset(-20);
        make.height.mas_equalTo(36);
    }];
    
    UIView *buttonView = [[UIView alloc] init];
    [self addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.top.equalTo(phoneView.mas_bottom).offset(20);
        make.bottom.equalTo(self).offset(0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = rgb(240, 240, 240, 1.0);
    [buttonView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(buttonView).offset(0);
        make.centerX.equalTo(buttonView).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = rgb(240, 240, 240, 1.0);
    [buttonView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(buttonView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *cancellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancellButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancellButton setTitleColor:rgb(99, 99, 99, 1.0) forState:UIControlStateNormal];
    cancellButton.titleLabel.font = PingFangMedium(15);
    [buttonView addSubview:cancellButton];
    [cancellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonView).offset(-self.width/4);
        make.centerY.equalTo(buttonView).offset(0);
    }];
    [cancellButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:rgb(66, 66, 66, 1.0) forState:UIControlStateNormal];
    confirmButton.titleLabel.font = PingFangMedium(15);
    [buttonView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonView).offset(self.width/4);
        make.centerY.equalTo(buttonView).offset(0);
    }];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirmButtonClick:(UIButton *)button{
    
    if (![self valiMobile:self.phoneTextFiled.text]) {
        
       [ZJCustomHud showWithText:@"手机号输入错误" WithDurations:2.0];
        return;
    }
    
    [self hidden];
    
    if (self.Block) {
        self.Block(self.phoneTextFiled.text);
    }
}

- (BOOL)valiMobile:(NSString *)mobile {
    if (mobile.length != 11) {
        return NO;
    }
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES) ||
        ([regextestcm evaluateWithObject:mobile] == YES) ||
        ([regextestct evaluateWithObject:mobile] == YES) ||
        ([regextestcu evaluateWithObject:mobile] == YES)) {
        return YES;
    }else {
        return NO;
    }
}
@end
