//
//  KDGoodsInfoCell.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsInfoCell.h"

@implementation KDGoodsInfoCell

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

-(void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.textColor = rgb(92, 92, 92, 1);
    titleLabel.font = PingFangMedium(15);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(self).offset(0);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    self.textField = textField;
    textField.userInteractionEnabled = NO;
    textField.textColor = rgb(11, 11, 11, 1);
    textField.font = PingFangBold(15);
    textField.textAlignment = NSTextAlignmentRight;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(129);
        make.right.equalTo(self).offset(-61);
        make.centerY.equalTo(self).offset(0);
    }];
    
    UIImageView *arrowImageV =[[UIImageView alloc] init];
    arrowImageV.image = [UIImage imageNamed:@"图标-前往"];
    [self addSubview:arrowImageV];
    [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
}

@end
