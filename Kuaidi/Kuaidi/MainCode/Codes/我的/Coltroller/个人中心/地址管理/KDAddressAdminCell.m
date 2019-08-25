//
//  KDAddressAdminCell.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//  height  168

#import "KDAddressAdminCell.h"
@interface KDAddressAdminCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) UIButton *defaultBtn;

@end
@implementation KDAddressAdminCell
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
    UIView* bgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), 6, kAdaptationWidth(339), kAdaptationWidth(156))];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.cornerRadius=10.0f;
    bgView.layer.masksToBounds=YES;
    [self addSubview:bgView];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  kAdaptationWidth(18), kAdaptationWidth(100), kAdaptationWidth(18))];
    _nameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _nameLabel.font =  PingFangRegular(15);
    [bgView addSubview:_nameLabel];
    
    _phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(180),  kAdaptationWidth(18), kAdaptationWidth(150), kAdaptationWidth(18))];
    _phoneLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _phoneLabel.font =  PingFangRegular(16);
    _phoneLabel.textAlignment=NSTextAlignmentRight;
    _phoneLabel.right = bgView.width - kAdaptationWidth(18);
    [bgView addSubview:_phoneLabel];
    
    _addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),  kAdaptationWidth(44), kAdaptationWidth(303), kAdaptationWidth(40))];
    _addressLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _addressLabel.font =  PingFangRegular(14);
    _addressLabel.numberOfLines=0;
    _addressLabel.textAlignment=NSTextAlignmentLeft;
    [bgView addSubview:_addressLabel];
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(96), kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#ECECEC"];
    [bgView addSubview:sepLabel];
    
    
    //编辑按钮
    UIButton* editBtn = [[UIButton alloc]initWithFrame:CGRectMake((165), kAdaptationWidth(108), kAdaptationWidth(72), kAdaptationWidth(36))];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"]  forState:UIControlStateNormal];
    editBtn.titleLabel.font = PingFangRegular(16);
    editBtn.layer.cornerRadius=18;
    editBtn.layer.borderWidth=1;
    editBtn.layer.borderColor=[UIColor colorWithHex:@"#5C5C5C"].CGColor;
    editBtn.layer.masksToBounds=YES;
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:editBtn];
    [editBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    //删除按钮
    UIButton* deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((249), kAdaptationWidth(108), kAdaptationWidth(72), kAdaptationWidth(36))];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"]  forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = PingFangRegular(16);
    deleteBtn.layer.cornerRadius=18;
    deleteBtn.layer.borderWidth=1;
    deleteBtn.layer.borderColor=[UIColor colorWithHex:@"#5C5C5C"].CGColor;
    deleteBtn.layer.masksToBounds=YES;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:deleteBtn];
    [deleteBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    _defaultBtn =[[UIButton alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(108), kAdaptationWidth(120), kAdaptationWidth(30))];
    [_defaultBtn setImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
    [_defaultBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [_defaultBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"]  forState:UIControlStateNormal];
    _defaultBtn.titleLabel.font = PingFangBold(14);
    [_defaultBtn addTarget:self action:@selector(defaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_defaultBtn];
    [_defaultBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    _defaultBtn.imageEdgeInsets = UIEdgeInsetsMake(kAdaptationWidth(6), kAdaptationWidth(0), kAdaptationWidth(6), kAdaptationWidth(100));
    _defaultBtn.titleEdgeInsets = UIEdgeInsetsMake(kAdaptationWidth(6), kAdaptationWidth(10), kAdaptationWidth(6), 0);
    _defaultBtn.centerY =deleteBtn.centerY;
}

-(void)setModel:(KDAddressAdminModel *)model{
    _nameLabel.text=model.name;
    _addressLabel.text=[NSString stringWithFormat:@"%@ %@ %@%@",model.province_name,model.city_name,model.district_name, model.address];
    if(model.isDefault.integerValue == 1){
        [_defaultBtn setImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateNormal];
    }else{
        [_defaultBtn setImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
    }
    //添加间隔
    NSMutableString * str = [[NSMutableString alloc ] init];
    for(int  i =0; i < [model.mobile length]; i++)
    {
        [str appendString:[model.mobile substringWithRange:NSMakeRange(i, 1)]];
        if (str.length == 4 || str.length == 9 ) {
            [str insertString:@" " atIndex:(str.length-1)];
        }
    }
    _phoneLabel.text = str;
}
-(void)editBtnClick{
    if(self.editBtnBlock){
        self.editBtnBlock();
    }
}
-(void)deleteBtnClick{
    if(self.deleteBtnBlock){
        self.deleteBtnBlock();
    }
}
-(void)defaultBtnClick:(UIButton*)btn{
    if(self.defaultBtnBlock){
        self.defaultBtnBlock();
    }
}
@end
