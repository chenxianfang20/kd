//
//  DKExpressSendInfoCell.m
//  Kuaidi
//
//  Created by ljp on 2019/8/20.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKExpressSendInfoCell.h"

@implementation DKExpressSendInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView.backgroundColor = rgb(255, 255, 255, 1.0);
    self.contentView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(0,-3);
    self.contentView.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 2;
    self.layer.cornerRadius = 12;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.top.bottom.equalTo(self).offset(0);
    }];
    
    UIView *circleView = [[UIView alloc] init];
    circleView.backgroundColor = rgb(206, 206, 206, 1.0);
    circleView.layer.cornerRadius = 7.5;
    [self.contentView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.contentView).offset(18);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.text = @"运输中";
    statusLabel.font = PingFangBold(15);
    statusLabel.textColor = rgb(169, 169, 169, 1.0);
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(circleView.mas_centerY).offset(0);
        make.left.equalTo(circleView.mas_right).offset(18);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"【深圳市】配送员：快递么12312341234正在为您派件，感谢您的耐心等待";
    infoLabel.textColor = rgb(169, 169, 169, 1.0);
    infoLabel.font = PingFangBold(14);
    infoLabel.numberOfLines = 0;
    [self.contentView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusLabel.mas_bottom).offset(5);
        make.left.equalTo(statusLabel.mas_left).offset(0);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = rgb(169, 169, 169, 1.0);
    timeLabel.font = PingFangMedium(13);
    timeLabel.text = @"2018/08/07 14:00:00";
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).offset(11);
        make.left.equalTo(statusLabel.mas_left).offset(0);
    }];
}

@end
