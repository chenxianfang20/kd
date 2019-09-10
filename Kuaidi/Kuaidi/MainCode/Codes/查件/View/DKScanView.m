//
//  DKScanView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKScanView.h"

@interface DKScanView()<UITextFieldDelegate>

@end

@implementation DKScanView

+(DKScanView *)scanView{
    
    DKScanView *view = [[DKScanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 156)];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}


-(void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1.0);
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    self.layer.cornerRadius = 12;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = rgb(255, 255, 255, 1.0);
    bgView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0,0);
    bgView.layer.shadowOpacity = 1;
    bgView.layer.shadowRadius = 24;
    bgView.layer.cornerRadius = 12;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self).offset(0);
        make.height.mas_equalTo(72);
    }];
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = rgb(255, 255, 255, 1.0);
    [bgView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(bgView).offset(0);
        make.height.mas_equalTo(12);
    }];
    
    UIImageView *qrcodeV = [[UIImageView alloc] init];
    qrcodeV.image = [UIImage imageNamed:@"图标-快递单号"];
    [bgView addSubview:qrcodeV];
    [qrcodeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(bgView).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    self.textField = textField;
    textField.textColor = rgb(11, 11, 11, 1.0);
    textField.font = PingFangBold(18);
    textField.placeholder = @"请输入快递单号查询信息";
    [textField setValue:rgb(206, 206, 206, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:PingFangMedium(15) forKeyPath:@"_placeholderLabel.font"];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [bgView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(54);
        make.right.equalTo(bgView).offset(-96);
        make.centerY.equalTo(bgView).offset(0);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setImage:[UIImage imageNamed:@"图标-扫码"] forState:UIControlStateNormal];
    [bgView addSubview:scanButton];
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-18);
        make.centerY.equalTo(bgView).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [scanButton addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lookUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lookUpButton setTitle:@"查询快递" forState:UIControlStateNormal];
    lookUpButton.titleLabel.font = PingFangBold(15);
    lookUpButton.layer.cornerRadius = 4;
    [self selectButtonCovert:lookUpButton];
    [self addSubview:lookUpButton];
    [lookUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.bottom.equalTo(self).offset(-18);
        make.top.equalTo(bgView.mas_bottom).offset(18);
    }];
    [lookUpButton addTarget:self action:@selector(lookUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectButtonCovert:(UIButton *)button{
    
    if (button.selected) {
        button.backgroundColor = rgb(223, 47, 49, 1.0);
        [button setTitleColor:rgb(255, 255, 255, 1.0) forState:UIControlStateNormal];
    }else{
        button.backgroundColor = rgb(241, 241, 241, 1.0);
        [button setTitleColor:rgb(169, 169, 169, 1.0) forState:UIControlStateNormal];
    }
    
}

- (void)scanButtonClick:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(clickScanQrCodeButton)]) {
        [self.delegate clickScanQrCodeButton];
    }
}

- (void)lookUpButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(clickLookUpButton)]) {
        [self.delegate clickLookUpButton];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    return YES;
}

@end
