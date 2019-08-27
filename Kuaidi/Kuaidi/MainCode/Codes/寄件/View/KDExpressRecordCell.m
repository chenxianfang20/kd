//
//  KDExpressRecordCell.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressRecordCell.h"
#import "KDOrderListModel.h"
#import "KDWuliuListModel.h"

@interface KDExpressRecordCell()

@property(nonatomic, strong)UIImageView *iconImageV;

@property(nonatomic, strong)UILabel *expressTitleLabel;

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UILabel *sendCityLabel;

@property(nonatomic, strong)UILabel *receiveCityLabel;

@property(nonatomic, strong)UILabel *sendNameLabel;

@property(nonatomic, strong)UILabel *receiveNameLabel;

@property(nonatomic, strong)UILabel *statusLabel;

@end

@implementation KDExpressRecordCell

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
    self.contentView.layer.shadowOffset = CGSizeMake(0,0);
    self.contentView.layer.shadowOpacity = 1;
    self.contentView.layer.shadowRadius = 24;
    self.contentView.layer.cornerRadius = 12;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
    }];
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    self.iconImageV = iconImageV;
//    iconImageV.image = [UIImage imageNamed:@"Logo"];
    iconImageV.layer.cornerRadius = 15;
    iconImageV.layer.borderWidth = 1;
    iconImageV.layer.borderColor = rgb(237, 237, 237, 1.0).CGColor;
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.contentView).offset(18);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *expressTitleLabel = [[UILabel alloc] init];
    self.expressTitleLabel = expressTitleLabel;
//    expressTitleLabel.text = @"快递么优选上门取件";
    expressTitleLabel.textColor = rgb(92, 92, 92, 1.0);
    expressTitleLabel.font = PingFangBold(15);
    [self.contentView addSubview:expressTitleLabel];
    [expressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(12);
        make.centerY.equalTo(iconImageV.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(140, 15));
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
//    timeLabel.text = @"19/08/08 14:00";
    timeLabel.textColor = rgb(169, 169, 169, 1.0);
    timeLabel.font = PingFangBold(14);
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.centerY.equalTo(iconImageV.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(130, 13));
    }];
    
    UIImageView *sendImageV = [[UIImageView alloc] init];
    sendImageV.image = [UIImage imageNamed:@"图标-寄往"];
    [self.contentView addSubview:sendImageV];
    [sendImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expressTitleLabel.mas_bottom).offset(32);
        make.centerX.equalTo(self.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(41, 15));
    }];
    
    UILabel *sendCityLabel = [[UILabel alloc] init];
    self.sendCityLabel = sendCityLabel;
//    sendCityLabel.text = @"巴音郭楞蒙古自治";
    sendCityLabel.textAlignment = NSTextAlignmentCenter;
    sendCityLabel.textColor = rgb(11, 11, 11, 1.0);
    sendCityLabel.font = PingFangBold(15);
    [self.contentView addSubview:sendCityLabel];
    [sendCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sendImageV.mas_centerY).offset(0);
        make.right.equalTo(sendImageV.mas_left).offset(-15);
        make.left.equalTo(self.contentView).offset(18);
    }];
    
    UILabel *receiveCityLabel = [[UILabel alloc] init];
    self.receiveCityLabel = receiveCityLabel;
//    receiveCityLabel.text = @"巴音郭楞蒙古自治";
    receiveCityLabel.textAlignment = NSTextAlignmentCenter;
    receiveCityLabel.textColor = rgb(11, 11, 11, 1.0);
    receiveCityLabel.font = PingFangBold(15);
    [self.contentView addSubview:receiveCityLabel];
    [receiveCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sendImageV.mas_centerY).offset(0);
        make.left.equalTo(sendImageV.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-18);
    }];
    
    UILabel *sendNameLabel = [[UILabel alloc] init];
    self.sendNameLabel = sendNameLabel;
//    sendNameLabel.text = @"刘德华";
    sendNameLabel.textAlignment = NSTextAlignmentCenter;
    sendNameLabel.textColor = rgb(169, 169, 169, 1.0);
    sendNameLabel.font = PingFangMedium(14);
    [self.contentView addSubview:sendNameLabel];
    [sendNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sendCityLabel.mas_bottom).offset(11);
        make.centerX.equalTo(sendCityLabel.mas_centerX).offset(0);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *receiveNameLabel = [[UILabel alloc] init];
    self.receiveNameLabel = receiveNameLabel;
//    receiveNameLabel.text = @"郭富城";
    receiveNameLabel.textAlignment = NSTextAlignmentCenter;
    receiveNameLabel.textColor = rgb(169, 169, 169, 1.0);
    receiveNameLabel.font = PingFangMedium(14);
    [self.contentView addSubview:receiveNameLabel];
    [receiveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(receiveCityLabel.mas_bottom).offset(11);
        make.centerX.equalTo(receiveCityLabel.mas_centerX).offset(0);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    self.statusLabel = statusLabel;
//    statusLabel.text = @"待付款";
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = rgb(223, 47, 49, 1.0);
    statusLabel.font = PingFangMedium(14);
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receiveNameLabel.mas_centerY).offset(0);
        make.centerX.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(13);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = rgb(241, 241, 241, 1.0);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.right.equalTo(self.contentView).offset(-18);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.contentView).offset(-60);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消订单" forState:UIControlStateNormal];
    [button setTitleColor:rgb(92, 92, 92, 1.0) forState:UIControlStateNormal];
    button.titleLabel.font = PingFangMedium(14);
    button.layer.cornerRadius = 18;
    button.layer.borderColor = rgb(92, 92, 92, 1.0).CGColor;
    button.layer.borderWidth = 1;
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(line.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(78, 36));
    }];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailButton setTitle:@"订单详情" forState:UIControlStateNormal];
    [detailButton setTitleColor:rgb(92, 92, 92, 1.0) forState:UIControlStateNormal];
    detailButton.titleLabel.font = PingFangMedium(14);
    detailButton.layer.cornerRadius = 18;
    detailButton.layer.borderColor = rgb(92, 92, 92, 1.0).CGColor;
    detailButton.layer.borderWidth = 1;
    [self.contentView addSubview:detailButton];
    [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button.mas_left).offset(-18);
        make.top.equalTo(line.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(78, 36));
    }];
}

-(void)setModel:(KDOrderListModel *)model{
    
    _model = model;
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.kuaidi.logistics_icon] placeholderImage:[UIImage imageNamed:@"Logo"]];
    self.expressTitleLabel.text = model.kuaidi.logistics_name;
    self.timeLabel.text = model.create_time;
    self.sendCityLabel.text = model.send_province_name;
    self.receiveCityLabel.text = model.accept_province_name;
    self.sendNameLabel.text = model.send_name;
    self.receiveNameLabel.text = model.accept_name;
    
    if (model.status.integerValue == 0) {
        self.statusLabel.text = @"待联系";
    }else if (model.status.integerValue == 1) {
        self.statusLabel.text = @"";
    }else if (model.status.integerValue == 2) {
        self.statusLabel.text = @"";
    }
    
}

@end
