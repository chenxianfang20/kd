//
//  KDAddressInfoView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDAddressInfoView.h"

@interface KDAddressInfoView()

@property(nonatomic, strong)UILabel *sendHolder;

@property(nonatomic, strong)UILabel *receiveHolder;

@property(nonatomic, strong)UILabel *sendNameLabel;

@property(nonatomic, strong)UILabel *receiveNameLabel;

@property(nonatomic, strong)UILabel *sendPhoneLabel;

@property(nonatomic, strong)UILabel *receivePhoneLabel;

@property(nonatomic, strong)UILabel *sendAddressLabel;

@property(nonatomic, strong)UILabel *receiveAddressLabel;

@end

@implementation KDAddressInfoView

+ (KDAddressInfoView *)addressInfoView{
    
    KDAddressInfoView *view = [[KDAddressInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 188)];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1.0);
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    self.layer.cornerRadius = 12;
    
    UIImageView *sendImageV = [[UIImageView alloc] init];
    sendImageV.image = [UIImage imageNamed:@"图标-寄件人"];
    [self addSubview:sendImageV];
    [sendImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self).offset(38);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        
    }];
    
    UIImageView *sendContactImageV = [[UIImageView alloc] init];
    sendContactImageV.image = [UIImage imageNamed:@"图标-通讯录"];
    [self addSubview:sendContactImageV];
    [sendContactImageV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(sendImageV.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        
    }];

    UILabel *sendHolder = [[UILabel alloc] init];
    self.sendHolder = sendHolder;
    sendHolder.text = @"请填写寄件人详细信息";
    sendHolder.textColor = rgb(206, 206, 206, 1.0);
    sendHolder.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self addSubview:sendHolder];
    [sendHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendImageV.mas_right).offset(18);
        make.centerY.equalTo(sendImageV.mas_centerY).offset(0);
    }];

    UIImageView *receiveImageV = [[UIImageView alloc] init];
    receiveImageV.image = [UIImage imageNamed:@"图标-收件人"];
    [self addSubview:receiveImageV];
    [receiveImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sendImageV.mas_centerX).offset(0);
        make.bottom.equalTo(self).offset(-38);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];

    UIImageView *receiveContactImageV = [[UIImageView alloc] init];
    receiveContactImageV.image = [UIImage imageNamed:@"图标-通讯录"];
    [self addSubview:receiveContactImageV];
    [receiveContactImageV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(receiveImageV.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));

    }];

    UILabel *receiveHolder = [[UILabel alloc] init];
    self.receiveHolder = receiveHolder;
    receiveHolder.text = @"请请填写收件人详细信息";
    receiveHolder.textColor = rgb(206, 206, 206, 1.0);
    receiveHolder.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self addSubview:receiveHolder];
    [receiveHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(receiveImageV.mas_right).offset(18);
        make.centerY.equalTo(receiveImageV.mas_centerY).offset(0);
    }];

    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = rgb(169, 169, 169, 1);
    [self addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sendImageV.mas_centerX).offset(0);
        make.top.equalTo(sendImageV.mas_bottom).offset(0);
        make.bottom.equalTo(receiveImageV.mas_top).offset(0);
        make.width.mas_equalTo(1);
    }];

    UIView *hLine = [[UIView alloc] init];
    hLine.backgroundColor = rgb(241, 241, 241, 1);
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vLine.mas_right).offset(27);
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(vLine.mas_centerY).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
