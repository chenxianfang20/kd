//
//  KDScoreCell.m
//  Kuaidi
//
//  Created by cxf on 2019/9/1.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDScoreCell.h"
@interface KDScoreCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@end
@implementation KDScoreCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = rgb(245, 245, 245, 1);
        [self addChildViews];
    }
    return self;
}
-(void)addChildViews{
    UIView* bgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(14), kAdaptationWidth(339), kAdaptationWidth(80))];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.cornerRadius=10.0f;
    bgView.layer.masksToBounds=YES;
    [self addSubview:bgView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(20), kAdaptationWidth(180), kAdaptationWidth(20))];
    _titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _titleLabel.font =  PingFangBold(15);
    [bgView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), _titleLabel.bottom+5, kAdaptationWidth(180), kAdaptationWidth(20))];
    _timeLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    _timeLabel.font = PingFangRegular(13);
    [bgView addSubview:_timeLabel];
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake( kAdaptationWidth(100), kAdaptationWidth(20), kAdaptationWidth(60), kAdaptationWidth(20))];
    _scoreLabel.textColor=[UIColor colorWithHex:@"#FB7F45"];
    _scoreLabel.font = PingFangBold(16);
    _scoreLabel.right=bgView.width-kLeftX;
    _scoreLabel.textAlignment=NSTextAlignmentRight;
    [bgView addSubview:_scoreLabel];
}

-(void)setModel:(KDScoreModel *)model{
    _titleLabel.text = model.titleStr;
    _timeLabel.text= model.timeStr;
    _scoreLabel.text = model.score;
}
@end
