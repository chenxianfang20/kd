//
//  KDCheckHistoryView.m
//  Kuaidi
//
//  Created by cxf on 2019/11/24.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDCheckHistoryView.h"
#import "UIView+YYAdd.h"
@interface KDCheckHistoryView()

@property (nonatomic,strong) UIImageView *headImgView;

@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *orderLabel;

@property (nonatomic,strong) UIButton *detailBtn;
@end
@implementation KDCheckHistoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)createUI{
    _headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(38), kAdaptationWidth(50), kAdaptationWidth(50))];
    _headImgView.layer.cornerRadius=kAdaptationWidth(25);
    _headImgView.layer.masksToBounds=YES;
    [self addSubview:_headImgView];
    
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImgView.right+10, kAdaptationWidth(30), kAdaptationWidth(120), kAdaptationWidth(22))];
    _stateLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _stateLabel.font =  PingFangBold(16);
    [self addSubview:_stateLabel];
    
    _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(_stateLabel.left, _stateLabel.bottom+5, kAdaptationWidth(220), kAdaptationWidth(18))];
    _desLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _desLabel.font =  PingFangBold(15);
    [self addSubview:_desLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_stateLabel.left, _desLabel.bottom+5, kAdaptationWidth(120), kAdaptationWidth(18))];
    _dateLabel.textColor=rgb(130, 130, 130, 1);
    _dateLabel.font =  PingFangRegular(14);
    [self addSubview:_dateLabel];
    
    _orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(_stateLabel.left, _desLabel.bottom+5, kAdaptationWidth(180), kAdaptationWidth(18))];
    _orderLabel.textColor=rgb(130, 130, 130, 1);
    _orderLabel.font =  PingFangRegular(14);
    [self addSubview:_orderLabel];
    _orderLabel.textAlignment = NSTextAlignmentRight;
    _orderLabel.right = self.width-kAdaptationWidth(40);
    
    _detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(305), kAdaptationWidth(40), kAdaptationWidth(20), kAdaptationWidth(20))];
    [_detailBtn setBackgroundImage:[UIImage imageNamed:@"图标-更多"] forState:UIControlStateNormal];
    [self addSubview:_detailBtn];
    _detailBtn.centerY = _headImgView.centerY;
}

-(void)setModel:(KDCheckHisoryModel *)model{
    _model = model;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.delivery_icon] placeholderImage:nil];
    _stateLabel.text = model.status_name;
    _desLabel.text = [NSString stringWithFormat:@"%@%@",model.delivery_name,model.fisrt_guiji] ;
    _dateLabel.text = model.create_time;
    _orderLabel.text = model.delivery_orderno;
}

-(void)tapClick{
    if(self.clickBlock){
        self.clickBlock(_model);
    }
}
@end
