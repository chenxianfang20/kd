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
    self.contentView.layer.shadowOffset = CGSizeMake(0,-5);
    self.contentView.layer.shadowOpacity = 1;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.top.bottom.equalTo(self).offset(0);
    }];
    
}

@end
