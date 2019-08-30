//
//  KDAddExpressCell.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAddExpressCell.h"
#import "UIButton+EnlargeTouchArea.h"
@interface KDAddExpressCell()
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIButton *favitBtn;
@end
@implementation KDAddExpressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addChildViews];
    }
    return self;
}

-(void)addChildViews{
    _iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, kAdaptationWidth(40), kAdaptationWidth(40))];
    _iconImgView.layer.cornerRadius=kAdaptationWidth(20);
    _iconImgView.layer.masksToBounds=YES;
    [self addSubview:_iconImgView];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(_iconImgView.right+ kAdaptationWidth(18),  kAdaptationWidth(12), kAdaptationWidth(100), kAdaptationWidth(20))];
    _nameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _nameLabel.font =  PingFangRegular(15);
    [self addSubview:_nameLabel];
    _nameLabel.centerY=_iconImgView.centerY;
    
    //编辑按钮
    _favitBtn = [[UIButton alloc]initWithFrame:CGRectMake((265), kAdaptationWidth(108), kAdaptationWidth(24), kAdaptationWidth(24))];
    
    [_favitBtn addTarget:self action:@selector(favitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_favitBtn];
    [_favitBtn setEnlargeEdge:18];
    _favitBtn.centerY =_iconImgView.centerY;
    _favitBtn.right = kScreenWidth-30;
}

-(void)setModel:(KDAddExpressModel *)model{
    _nameLabel.text=model.name;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.src] placeholderImage:nil];
    if(model.heart.integerValue == 0){
        [_favitBtn setBackgroundImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
    }else if (model.heart.integerValue == 1){
        [_favitBtn setBackgroundImage:[UIImage imageNamed:@"图标-收藏 "] forState:UIControlStateNormal];
    }
}
-(void)favitBtnClick:(UIButton*)btn{
    if(self.favitBtnBlock){
        self.favitBtnBlock();
    }
}

@end
