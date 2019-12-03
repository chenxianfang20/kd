//
//  KDGoodsInfoFooterView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsInfoFooterView.h"

@interface KDGoodsInfoFooterView()

@property(nonatomic, strong)UIButton *orderButton;

@property(nonatomic, strong)UIButton *cancellButton;

@property(nonatomic, strong)UILabel *feeValueLabel;

@end

@implementation KDGoodsInfoFooterView

+(KDGoodsInfoFooterView *)goodsInfoFooterView{
    
    KDGoodsInfoFooterView *view = [[KDGoodsInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 67)];
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
    
    self.backgroundColor = rgb(255, 255, 255, 1);
    
    UIView *hLine = [[UIView alloc] init];
    hLine.backgroundColor = rgb(241, 241, 241, 1);
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *feeTitleLabel = [[UILabel alloc] init];
    feeTitleLabel.text = @"预计运费：";
    feeTitleLabel.textColor = rgb(11, 11, 11, 1);
    feeTitleLabel.font = PingFangMedium(15);
    [self addSubview:feeTitleLabel];
    [feeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self).offset(27);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *feeValueLabel = [[UILabel alloc] init];
    self.feeValueLabel = feeValueLabel;
    feeValueLabel.text = @"¥0.0";
    feeValueLabel.textColor = rgb(223, 47, 49, 1);
    feeValueLabel.font = [UIFont fontWithName:@"PingFangSC-Heavy" size: 15];
    [self addSubview:feeValueLabel];
    [feeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(feeTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(feeTitleLabel.mas_centerY).offset(0);
        make.height.mas_equalTo(15);
    }];

    CGFloat buttonW = 86;
    
    UIButton *cancellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancellButton = cancellButton;
    [cancellButton setTitle:@"取消下单" forState:UIControlStateNormal];
    cancellButton.titleLabel.font = PingFangBold(15);
    [self selectButtonConvert:cancellButton];
    cancellButton.layer.cornerRadius = 20;
    [self addSubview:cancellButton];
    [cancellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13);
        make.right.equalTo(self).offset(-18 - buttonW - 10);
        make.size.mas_equalTo(CGSizeMake(buttonW, 40));
    }];
    [cancellButton addTarget:self action:@selector(cancellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancellButton.selected = YES;
    [self selectButtonConvert:self.cancellButton];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderButton = orderButton;
    [orderButton setTitle:@"立即下单" forState:UIControlStateNormal];
    orderButton.titleLabel.font = PingFangBold(15);
    [self selectButtonConvert:orderButton];
    orderButton.layer.cornerRadius = 20;
    [self addSubview:orderButton];
    [orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13);
        make.right.equalTo(self).offset(-18);
        make.size.mas_equalTo(CGSizeMake(buttonW, 40));
    }];
    [orderButton addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectButtonConvert:(UIButton *)button{
    
    if (button.selected) {
        button.backgroundColor = rgb(223, 47, 49, 1);
        [button setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateNormal];
    }else{
        button.backgroundColor = rgb(241, 241, 241, 1);
        [button setTitleColor:rgb(169, 169, 169, 1) forState:UIControlStateNormal];
    }
    
}

- (void)orderButtonClick:(UIButton *)button{
    
    if (!button.selected) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(clickConfirmButton)]) {
        [self.delegate clickConfirmButton];
    }
}

- (void)cancellButtonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(clickCancellOrder)]) {
        [self.delegate clickCancellOrder];
    }
    
}

-(void)setIsOrderButtonSelect:(BOOL)isOrderButtonSelect{
    
    _isOrderButtonSelect = isOrderButtonSelect;
    
    self.orderButton.selected = isOrderButtonSelect;
    
    [self selectButtonConvert:self.orderButton];
    
}

-(void)setMoney:(CGFloat)money{
    
    _money = money;
    
    self.feeValueLabel.text = [NSString stringWithFormat:@"¥%.2f",money];
}

@end
