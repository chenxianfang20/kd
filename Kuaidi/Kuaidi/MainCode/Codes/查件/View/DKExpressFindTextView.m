//
//  DKExpressFindTextView.m
//  Kuaidi
//
//  Created by ljp on 2019/9/8.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKExpressFindTextView.h"
#import "KDExpressTitleView.h"
#import "KDWuliuGuijiModel.h"
#import "KDExpressModel.h"

@interface DKExpressFindTextView()<UITextFieldDelegate>

@property(nonatomic, strong)KDExpressTitleView *expressTitleView;

@end;

@implementation DKExpressFindTextView

+(DKExpressFindTextView *)expressFindTextView{
    
    DKExpressFindTextView *view = [[DKExpressFindTextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 94 + 100)];
    return view;
    
}

-(KDExpressTitleView *)expressTitleView{
    
    if (!_expressTitleView) {
        _expressTitleView = [KDExpressTitleView expressTitleView];
    }
    return _expressTitleView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self= [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.expressTitleView];
    [self.expressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(90);
    }];
    
    UIView *textFieldView = [[UIView alloc] init];
    textFieldView.backgroundColor = rgb(255, 255, 255, 1.0);
    textFieldView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    textFieldView.layer.shadowOffset = CGSizeMake(0,0);
    textFieldView.layer.shadowOpacity = 1;
    textFieldView.layer.shadowRadius = 24;
    textFieldView.layer.cornerRadius = 12;
    [self addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expressTitleView.mas_bottom).offset(20);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(60);
    }];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"输入客户手机号码后四位";
    phoneTextField.textColor = rgb(33, 33, 33, 1.0);
    phoneTextField.font = PingFangMedium(15);
    phoneTextField.delegate = self;
    phoneTextField.textAlignment = NSTextAlignmentCenter;
    phoneTextField.returnKeyType = UIReturnKeySearch;
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [textFieldView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldView).offset(80);
        make.right.equalTo(textFieldView).offset(-80);
        make.centerY.equalTo(textFieldView).offset(0);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    
    if ([self.delegate respondsToSelector:@selector(searchExpressInfoWithNum:)]) {
        [self.delegate searchExpressInfoWithNum:textField.text];
    }
    
    return YES;
}

-(void)setModel:(KDWuliuGuijiModel *)model{
    
    _model = model;
    
    [self.expressTitleView.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.logistic.logistics_icon]];
    self.expressTitleView.expressTitleLabel.text = model.logistic.logistics_name;
    self.expressTitleView.expressNoLabel.text = model.logistic.logistics_code;
}
@end
