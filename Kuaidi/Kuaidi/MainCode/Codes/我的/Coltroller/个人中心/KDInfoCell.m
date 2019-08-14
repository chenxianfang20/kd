//
//  KDInfoCell.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/13.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDInfoCell.h"
@interface KDInfoCell()

@property(nonatomic,strong)UIImageView* headImgView;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UILabel*desLabel;
@end
@implementation KDInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addChildViews];
    }
    return self;
}
-(void)addChildViews{
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(10), kAdaptationWidth(10), kAdaptationWidth(25), kAdaptationWidth(25))];
    [self addSubview:_headImgView];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(60), _headImgView.top, kAdaptationWidth(100), kAdaptationWidth(24))];
    _titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
    _titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self addSubview:_titleLabel];
    
    
    //箭头图标
    UIImageView* jtImgView=[[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(10), kAdaptationWidth(8), kAdaptationWidth(12), kAdaptationWidth(12))];
    jtImgView.image=[UIImage imageNamed:@"我的-图标-关于我们"];
    [self addSubview:jtImgView];
    jtImgView.right = kAdaptationWidth(329);
    jtImgView.centerY=_headImgView.centerY;
    
    _desLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(60), kAdaptationWidth(8), kAdaptationWidth(150), kAdaptationWidth(24))];
    _desLabel.font= [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
    _desLabel.textColor=[UIColor colorWithHex:@"#A6A6A6"];
    _desLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_desLabel];
    _desLabel.right = jtImgView.left-10;
    _desLabel.centerY =_headImgView.centerY;
}
-(void)setModel:(KDInfoModel *)model{
    
    _headImgView.image=[UIImage imageNamed:model.headImgName];
    _titleLabel.text=model.titleStr;
    _desLabel.text=model.desStr;
}
@end
