//
//  KDUserInfoView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDUserInfoView.h"

@interface KDUserInfoView()

@property(nonatomic, strong)UILabel *holderLabel;

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *phoneLabel;

@property(nonatomic, strong)UILabel *addressLabel;

@end

@implementation KDUserInfoView

+(KDUserInfoView *)userInfoView{
    
    KDUserInfoView *view = [[KDUserInfoView alloc] init];
    return view;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.text = @"刘德华";
    nameLabel.textColor = rgb(11, 11, 11, 1);
    nameLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    [self  addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(18);
        make.left.equalTo(self).offset(0);
        make.height.mas_equalTo(14);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    self.phoneLabel = phoneLabel;
    phoneLabel.text = @"150 1358 1358";
    phoneLabel.textColor = rgb(11, 11, 11, 1);
    phoneLabel.textAlignment = NSTextAlignmentRight;
    phoneLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.right.equalTo(self).offset(-63);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    self.addressLabel = addressLabel;
    addressLabel.text = @"广东省 深圳市 龙岗区 横岗街道大运软件小镇大运软件小镇01栋";
    addressLabel.textColor = rgb(169, 169, 169, 1);
    addressLabel.numberOfLines = 0;
    addressLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    [self addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-63);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *contactImageV = [[UIImageView alloc] init];
    contactImageV.image = [UIImage imageNamed:@"图标-通讯录"];
    [self addSubview:contactImageV];
    [contactImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        
    }];
    
    UILabel *holderLabel = [[UILabel alloc] init];
    holderLabel.hidden = YES;
    self.holderLabel = holderLabel;
    holderLabel.textColor = rgb(206, 206, 206, 1.0);
    holderLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self addSubview:holderLabel];
    [holderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.centerY.equalTo(self).offset(0);
    }];
}

-(void)setUserInfoType:(KDUserInfoType)userInfoType{
    
    _userInfoType = userInfoType;
    if (userInfoType == KDUserInfoTypeSend) {
        self.holderLabel.text = @"请填写寄件人详细信息";
    }else if (userInfoType == KDUserInfoTypeReceive) {
        self.holderLabel.text = @"请填写收件人详细信息";
    }
    
}

@end
