//
//  KDAddressInfoView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDAddressInfoView.h"
#import "KDUserInfoView.h"

@interface KDAddressInfoView()

@property(nonatomic, strong)KDUserInfoView *sendUserInfoView;

@property(nonatomic, strong)KDUserInfoView *receiveUserInfoView;

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
    
    KDUserInfoView *sendUserInfoView = [KDUserInfoView userInfoView];
    sendUserInfoView.userInfoType = KDUserInfoTypeSend;
    self.sendUserInfoView = sendUserInfoView;
    [self addSubview:sendUserInfoView];
    [sendUserInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendImageV.mas_right).offset(18);
        make.top.right.equalTo(self).offset(0);
        make.height.mas_equalTo(93);
    }];
    
    UIImageView *receiveImageV = [[UIImageView alloc] init];
    receiveImageV.image = [UIImage imageNamed:@"图标-收件人"];
    [self addSubview:receiveImageV];
    [receiveImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sendImageV.mas_centerX).offset(0);
        make.bottom.equalTo(self).offset(-38);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];

    KDUserInfoView *receiveUserInfoView = [KDUserInfoView userInfoView];
    receiveUserInfoView.userInfoType = KDUserInfoTypeReceive;
    self.receiveUserInfoView = receiveUserInfoView;
    [self addSubview:receiveUserInfoView];
    [receiveUserInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(receiveImageV.mas_right).offset(18);
        make.bottom.right.equalTo(self).offset(0);
        make.height.mas_equalTo(93);
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
    
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    bottomView.backgroundColor = rgb(255, 255, 255, 1);
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(12);
    }];
    
    [self.sendUserInfoView hiddenAddress];
    [self.receiveUserInfoView hiddenAddress];
    
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendTap:)];
    [self.sendUserInfoView addGestureRecognizer:sendTap];
    
    UITapGestureRecognizer *receiveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receiveTap:)];
    [self.receiveUserInfoView addGestureRecognizer:receiveTap];
}

-(void)sendTap:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(selectSendExpressAddress)]) {
        [self.delegate selectSendExpressAddress];
    }
    
}

-(void)receiveTap:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(selectReceiveExpressAddress)]) {
        [self.delegate selectReceiveExpressAddress];
    }
    
}

@end
