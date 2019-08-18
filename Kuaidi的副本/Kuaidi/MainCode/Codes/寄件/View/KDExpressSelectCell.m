//
//  KDExpressSelectCell.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressSelectCell.h"

@implementation KDExpressSelectCell

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
    
    UIImageView *icoImageV = [[UIImageView alloc] init];
    icoImageV.layer.borderColor = rgb(237, 237, 237, 1.0).CGColor;
    icoImageV.layer.borderWidth = 1;
    icoImageV.layer.cornerRadius = 24;
    [self addSubview:icoImageV];
    [icoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(18);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"顺丰快递";
    titleLabel.textColor = rgb(92, 92, 92, 1.0);
    titleLabel.font = PingFangBold(15);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icoImageV.mas_right).offset(18);
        make.centerY.equalTo(icoImageV.mas_centerY).offset(0);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateSelected];
    [self addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(icoImageV.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
}

@end
