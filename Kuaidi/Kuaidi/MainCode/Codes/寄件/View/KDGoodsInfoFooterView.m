//
//  KDGoodsInfoFooterView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsInfoFooterView.h"

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
    feeTitleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self addSubview:feeTitleLabel];
    [feeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self).offset(27);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *feeValueLabel = [[UILabel alloc] init];
    feeValueLabel.text = @"¥8.0";
    feeValueLabel.textColor = rgb(223, 47, 49, 1);
    feeValueLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size: 15];
    [self addSubview:feeValueLabel];
    [feeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(feeTitleLabel.mas_right).offset(0);
        make.centerY.equalTo(feeTitleLabel.mas_centerY).offset(0);
        make.height.mas_equalTo(15);
    }];

    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderButton setTitle:@"立即下单" forState:UIControlStateNormal];
    orderButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self selectButtonConvert:orderButton];
    orderButton.layer.cornerRadius = 21;
    [self addSubview:orderButton];
    [orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13);
        make.right.equalTo(self).offset(-18);
        make.size.mas_equalTo(CGSizeMake(96, 42));
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
    
    if ([self.delegate respondsToSelector:@selector(clickConfirmButton)]) {
        [self.delegate clickConfirmButton];
    }
    
}

@end
