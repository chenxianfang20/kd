//
//  DKExpressSendInfoHeaderView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/19.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKExpressSendInfoHeaderView.h"
#import "KDExpressTitleView.h"

@interface DKExpressSendInfoHeaderView()

@property(nonatomic, strong)KDExpressTitleView *expressTitleView;

@property(nonatomic, strong)NSArray *iconArr;

@end


@implementation DKExpressSendInfoHeaderView

-(KDExpressTitleView *)expressTitleView{
    
    if (!_expressTitleView) {
        _expressTitleView = [KDExpressTitleView expressTitleView];
    }
    return _expressTitleView;
}

-(NSArray *)iconArr{
    
    if (!_iconArr) {
        _iconArr = @[@"图标-反序",@"图标-未订阅",@"图标-分享"];
    }
    return _iconArr;
}

+(DKExpressSendInfoHeaderView *)expressSendInfoHeaderView{
    
    DKExpressSendInfoHeaderView *view = [[DKExpressSendInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 94 + 90 + 12)];
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
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.expressTitleView];
    [self.expressTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(90);
    }];
    
    UIView *expressInfoView = [[UIView alloc] init];
    expressInfoView.backgroundColor = rgb(255, 255, 255, 1.0);
    expressInfoView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    expressInfoView.layer.shadowOffset = CGSizeMake(0,0);
    expressInfoView.layer.shadowOpacity = 1;
    expressInfoView.layer.shadowRadius = 24;
    expressInfoView.layer.cornerRadius = 12;
    [self addSubview:expressInfoView];
    [expressInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expressTitleView.mas_bottom).offset(12);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(54);
    }];
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor whiteColor];
    [expressInfoView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(expressInfoView).offset(0);
        make.height.mas_equalTo(12);
    }];
    
    UILabel *expressInfoLabel = [[UILabel alloc] init];
    expressInfoLabel.text = @"物流信息";
    expressInfoLabel.textColor = rgb(92, 92, 92, 1.0);
    expressInfoLabel.font = PingFangBold(15);
    [expressInfoView addSubview:expressInfoLabel];
    [expressInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expressInfoView).offset(18);
        make.centerY.equalTo(expressInfoView).offset(0);
    }];
    
    for (NSInteger i = 0; i < self.iconArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:self.iconArr[i]] forState:UIControlStateNormal];
        [expressInfoView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(expressInfoView).offset(-(17 + (20 + 22) * i));
            make.centerY.equalTo(expressInfoView).offset(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
    }
    
    UIView *statusView = [[UIView alloc] init];
    statusView.backgroundColor = rgb(255, 255, 255, 1.0);
    statusView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    statusView.layer.shadowOffset = CGSizeMake(0,-5);
    statusView.layer.shadowOpacity = 1;
    [self addSubview:statusView];
    [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.top.equalTo(expressInfoView.mas_bottom).offset(0);
    }];
    
    UILabel *statuLabel = [[UILabel alloc] init];
    statuLabel.textColor = rgb(223, 47, 49, 1.0);
    statuLabel.font = PingFangBold(15);
    statuLabel.text = @"已签收";
    [statusView addSubview:statuLabel];
    [statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statusView).offset(18);
        make.centerY.equalTo(statusView).offset(0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = rgb(241, 241, 241, 1.0);
    [statusView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statusView).offset(18);
        make.right.equalTo(statusView).offset(-18);
        make.bottom.equalTo(statusView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self bringSubviewToFront:expressInfoView];
}

@end
