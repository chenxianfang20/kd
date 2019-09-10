//
//  DKExpressSendInfoCell.m
//  Kuaidi
//
//  Created by ljp on 2019/8/20.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKExpressSendInfoCell.h"
#import "KDWuliuGuijiModel.h"
#import "KDWuliuListModel.h"

@interface DKExpressSendInfoCell()

@property(nonatomic, strong)UIView *circleView;

@property(nonatomic, strong)UILabel *statusLabel;

@property(nonatomic, strong)UILabel *infoLabel;

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UIView *topLine;

@property(nonatomic, strong)UIView *btmLine;

@end

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
    self.circleView = circleView;
    circleView.layer.cornerRadius = 7.5;
    [self.contentView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.contentView).offset(18);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    self.statusLabel = statusLabel;
    statusLabel.font = PingFangBold(15);
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(circleView.mas_centerY).offset(0);
        make.left.equalTo(circleView.mas_right).offset(18);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    self.infoLabel = infoLabel;
    infoLabel.font = PingFangBold(14);
    infoLabel.numberOfLines = 0;
    [self.contentView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusLabel.mas_bottom).offset(5);
        make.left.equalTo(statusLabel.mas_left).offset(0);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = PingFangMedium(13);
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).offset(11);
        make.left.equalTo(statusLabel.mas_left).offset(0);
    }];
    
    UIView *topLine = [[UIView alloc] init];
    self.topLine = topLine;
    topLine.backgroundColor = rgb(245, 245, 245, 1.0);
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.circleView.mas_top).offset(0);
        make.centerX.equalTo(self.circleView.mas_centerX).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UIView *btmLine = [[UIView alloc] init];
    self.btmLine = btmLine;
    btmLine.backgroundColor = rgb(245, 245, 245, 1.0);
    [self.contentView addSubview:btmLine];
    [btmLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.circleView.mas_bottom).offset(0);
        make.centerX.equalTo(self.circleView.mas_centerX).offset(0);
        make.width.mas_equalTo(1);
    }];
}

-(void)setModel:(KDWuliuGuijiModel *)model{
    
    _model = model;
    
    UIColor *titleColor = [UIColor clearColor];
    UIColor *subColor = [UIColor clearColor];
    KDWuliuTraces *tracesModel = model.Traces[self.row];
    if (self.row == 0) {
        self.circleView.backgroundColor = rgb(223, 47, 49, 1.0);
        titleColor = rgb(223, 47, 49, 1.0);
        subColor = rgb(223, 47, 49, 1.0);
    }else{
        self.circleView.backgroundColor = rgb(206, 206, 206, 1.0);
        titleColor = rgb(33, 33, 33, 1.0);
        subColor = rgb(206, 206, 206, 1.0);
    }
    
    self.statusLabel.text = tracesModel.remark;
    self.statusLabel.textColor = titleColor;
    
    self.infoLabel.text = tracesModel.AcceptStation;
    self.infoLabel.textColor = subColor;
    
    self.timeLabel.text = tracesModel.AcceptTime;
    self.timeLabel.textColor = subColor;
    
    if (self.model.Traces.count == 1) {
        self.topLine.hidden = YES;
        self.btmLine.hidden = YES;
    }else if (self.row == 0) {
        self.topLine.hidden = YES;
        self.btmLine.hidden = NO;
    }else if (self.row == model.Traces.count - 1) {
        self.topLine.hidden = NO;
        self.btmLine.hidden = YES;
    }else{
        self.topLine.hidden = NO;
        self.btmLine.hidden = NO;
    }
//    NSLog(@"self.row==%ld------self.model.Traces.count==%ld",self.row,self.model.Traces.count);
}

@end
