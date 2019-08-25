//
//  KDExpressCell.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//  height  102

#import "KDExpressCell.h"
@interface KDExpressCell()
@property (nonatomic,strong) UILabel *mailingMameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UIButton *starBtn;
@end
@implementation KDExpressCell
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
    UIView* bgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), 6, kAdaptationWidth(339), kAdaptationWidth(90))];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.cornerRadius=10.0f;
    bgView.layer.masksToBounds=YES;
    [self addSubview:bgView];
    
    _headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(22), kAdaptationWidth(18), kAdaptationWidth(54), kAdaptationWidth(54))];
    _headImgView.layer.cornerRadius=kAdaptationWidth(27);
    _headImgView.layer.masksToBounds=YES;
    [bgView addSubview:_headImgView];
    
    _mailingMameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(25), kAdaptationWidth(120), kAdaptationWidth(18))];
    _mailingMameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _mailingMameLabel.font =  PingFangRegular(18);
    [bgView addSubview:_mailingMameLabel];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(52), kAdaptationWidth(120), kAdaptationWidth(18))];
    _phoneLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _phoneLabel.font =  PingFangRegular(16);
    [bgView addSubview:_phoneLabel];
    
    _starBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(285), kAdaptationWidth(33), kAdaptationWidth(24), kAdaptationWidth(24))];
    [_starBtn setBackgroundImage:[UIImage imageNamed:@"图标-收藏 "] forState:UIControlStateNormal];
    [bgView addSubview:_starBtn];
}

-(void)setModel:(KDExpressModel *)model{
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:model.logistics_icon];
        weakSelf.headImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    });
   
    _mailingMameLabel.text=model.logistics_name;
    _phoneLabel.text=model.logistics_mobile;
}
@end
