//
//  KDExpressTitleView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/20.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressTitleView.h"

@implementation KDExpressTitleView

+ (KDExpressTitleView *)expressTitleView{
    
    KDExpressTitleView *view = [[KDExpressTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 90)];
    return view;
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self= [super initWithFrame:frame];
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
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    self.iconImageV = iconImageV;
    iconImageV.layer.cornerRadius = 27;
    iconImageV.layer.borderWidth = 1;
    iconImageV.layer.borderColor = rgb(253, 255, 254, 1.0).CGColor;
    [self addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(54, 54));
    }];
    
    UILabel *expressTitleLabel = [[UILabel alloc] init];
    self.expressTitleLabel = expressTitleLabel;
    expressTitleLabel.textColor = rgb(11, 11, 11, 1.0);
    expressTitleLabel.font = PingFangBold(18);
    [self addSubview:expressTitleLabel];
    [expressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(18);
        make.top.equalTo(self).offset(25);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *expressNoLabel = [[UILabel alloc] init];
    self.expressNoLabel = expressNoLabel;
    expressNoLabel.textColor = rgb(92, 92, 92, 1.0);
    expressNoLabel.font = PingFangMedium(16);
    [self addSubview:expressNoLabel];
    [expressNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(18);
        make.top.equalTo(expressTitleLabel.mas_bottom).offset(10);
    }];
    
    
}
@end
