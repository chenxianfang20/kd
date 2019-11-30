//
//  KDQuitOrderView.m
//  Kuaidi
//
//  Created by cxf on 2019/8/28.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDQuitOrderView.h"
#import "UIButton+EnlargeTouchArea.h"
@interface  KDQuitOrderView()
@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,strong) UILabel *quitReasonLabel;;

@property (nonatomic,strong) UIView *midBgView;
@property (nonatomic,strong) UILabel* nameExpressLabel;

@property (nonatomic,strong) UILabel* fromCityLabel;
@property (nonatomic,strong) UILabel* toCityLabel;
@property (nonatomic,strong) UILabel* fromNameLabel;
@property (nonatomic,strong) UILabel* moneyLabel;
@property (nonatomic,strong) UILabel* toNameLabel;
@property (nonatomic,strong) UILabel* kgLabel;

@property (nonatomic,strong)  UIButton*  contactBtn;
@property (nonatomic,strong)  UIView* contactBgView;
@end

@implementation KDQuitOrderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildViews];
    }
    return self;
}

-(void)addChildViews{
    //取件码
    _topBgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftX, 8, kAdaptationWidth(339), kAdaptationWidth(114))];
    _topBgView.backgroundColor=[UIColor whiteColor];
    _topBgView.layer.cornerRadius=10.0f;
    _topBgView.layer.masksToBounds=YES;
    [self addSubview:_topBgView];
  
    UILabel* topTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(36), kAdaptationWidth(339), kAdaptationWidth(20))];
    topTitleLabel.text=@"订单已取消";
    topTitleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    topTitleLabel.textAlignment=NSTextAlignmentCenter;
    topTitleLabel.font =PingFangBold(18);
    [_topBgView addSubview:topTitleLabel];
    
    _quitReasonLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, topTitleLabel.bottom+10, kAdaptationWidth(339), kAdaptationWidth(18))];
    _quitReasonLabel.text=@"取消原因：填写错了/重复下单";
    _quitReasonLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _quitReasonLabel.textAlignment=NSTextAlignmentCenter;
    _quitReasonLabel.font = PingFangMedium(14);
    [_topBgView addSubview:_quitReasonLabel];
    //城市到往
    _midBgView=[[UIView alloc]initWithFrame:CGRectMake(kLeftX,_topBgView.bottom+ 12, kAdaptationWidth(339), kAdaptationWidth(118))];
    _midBgView.backgroundColor=[UIColor whiteColor];
    _midBgView.layer.cornerRadius=10.0f;
    _midBgView.layer.masksToBounds=YES;
    [self addSubview:_midBgView];
    
    _fromCityLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(24), kAdaptationWidth(139), kAdaptationWidth(18))];
    _fromCityLabel.text=@"深圳市";
    _fromCityLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _fromCityLabel.textAlignment=NSTextAlignmentCenter;
    _fromCityLabel.font = PingFangBold(15);
    [_midBgView addSubview:_fromCityLabel];
    
    UIImageView* toImgView  =[[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(149), kAdaptationWidth(25), kAdaptationWidth(41), kAdaptationWidth(9))];
    toImgView.image = [UIImage imageNamed:@"图标-寄往"];
    toImgView.centerY=_fromCityLabel.centerY;
    [_midBgView addSubview:toImgView];
    
    _toCityLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(200), kAdaptationWidth(24), kAdaptationWidth(149), kAdaptationWidth(18))];
    _toCityLabel.text=@"北京市";
    _toCityLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    _toCityLabel.textAlignment=NSTextAlignmentCenter;
    _toCityLabel.font = PingFangBold(15);
    _toCityLabel.centerY=_fromCityLabel.centerY;
    [_midBgView addSubview:_toCityLabel];
    
    _fromNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, _fromCityLabel.bottom+8, kAdaptationWidth(139), kAdaptationWidth(18))];
    _fromNameLabel.text=@"刘德华";
    _fromNameLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    _fromNameLabel.textAlignment=NSTextAlignmentCenter;
    _fromNameLabel.font = PingFangRegular(13);
    _fromNameLabel.centerX=_fromCityLabel.centerX;
    [_midBgView addSubview:_fromNameLabel];
    
    _toNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(200), _toCityLabel.bottom+8, kAdaptationWidth(139), kAdaptationWidth(18))];
    _toNameLabel.text=@"郭富城";
    _toNameLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    _toNameLabel.textAlignment=NSTextAlignmentCenter;
    _toNameLabel.font = PingFangRegular(13);
    [_midBgView addSubview:_toNameLabel];
    _toNameLabel.centerX=_toCityLabel.centerX;
    
//    _moneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(200), _toCityLabel.bottom, kAdaptationWidth(120), kAdaptationWidth(18))];
//    _moneyLabel.text=@"已支付￥800元";
//    _moneyLabel.textColor=[UIColor colorWithHex:@"#DF2F31"];
//    _moneyLabel.textAlignment=NSTextAlignmentCenter;
//    _moneyLabel.font = PingFangRegular(13);
//    [_midBgView addSubview:_moneyLabel];
//    _moneyLabel.centerX=toImgView.centerX;
    
    _kgLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(87), kAdaptationWidth(339), kAdaptationWidth(18))];
    _kgLabel.text=@"首重¥8.0，续重¥2.0/公斤";
    _kgLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    _kgLabel.textAlignment=NSTextAlignmentCenter;
    _kgLabel.font = PingFangRegular(13);
    [_midBgView addSubview:_kgLabel];
    
    _showInfoBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(95), _midBgView.bottom+15, kAdaptationWidth(149), kAdaptationWidth(18))];
    _showInfoBtn.titleLabel.font = PingFangRegular(14);
    [_showInfoBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [_showInfoBtn setTitle:@"点击展开订单详情" forState:UIControlStateNormal];
    [_showInfoBtn setImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
    [_showInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _showInfoBtn.imageView.image.size.width, 0, _showInfoBtn.imageView.image.size.width)];
    [_showInfoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _showInfoBtn.titleLabel.bounds.size.width, 0, -_showInfoBtn.titleLabel.bounds.size.width-10)];
    [_showInfoBtn addTarget:self action:@selector(showInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _showInfoBtn.tag=0;
    [self addSubview:_showInfoBtn];
    
    
    //底部按钮
    _contactBgView =[[UIView alloc]initWithFrame:CGRectMake(0, self.size.height-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    _contactBgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_contactBgView];
    
    //再下一单
    _contactBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [_contactBtn setTitle:@"重新下单" forState:UIControlStateNormal];
    [_contactBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_contactBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    _contactBtn.layer.cornerRadius=kAdaptationWidth(10);
    _contactBtn.layer.masksToBounds=YES;
    [_contactBtn addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contactBgView addSubview:_contactBtn];
    
    
}
-(void)showInfoBtnClick:(UIButton*)btn{
    if(btn.tag == 0){
        btn.top=_bottomBgView.bottom+15;
        _contactBgView.hidden=YES;
        _bottomBgView.hidden = NO;
        btn.tag=1;
        [_showInfoBtn setTitle:@"点击收起订单详情" forState:UIControlStateNormal];
        [_showInfoBtn setImage:[UIImage imageNamed:@"图标-上"] forState:UIControlStateNormal];
    }else{
        btn.top=_midBgView.bottom+15;
        _contactBgView.hidden=NO;
        _bottomBgView.hidden = YES;
        btn.tag=0;
        [_showInfoBtn setTitle:@"点击展开订单详情" forState:UIControlStateNormal];
        [_showInfoBtn setImage:[UIImage imageNamed:@"图标-下"] forState:UIControlStateNormal];
    }
    if(self.myIsShowInfoBlock){
        self.myIsShowInfoBlock(btn.tag);
    }
}
-(void)contactBtnClick{
    if(self.myReOrderBlock){
        self.myReOrderBlock();
    }
}
-(void)setModel:(KDOrderListModel *)model{
    _model=model;
    _fromCityLabel.text= model.send_city_name;
    _fromNameLabel.text=model.send_name;
    _toCityLabel.text=model.accept_city_name;
    _toNameLabel.text=model.accept_name;
    _moneyLabel.text=[NSString stringWithFormat:@"已支付￥%@元",model.pay_money] ;
    [self setInfoDetail:model];
}
-(void)setInfoDetail:(KDOrderListModel *)model{
    
    //****底部具体信息
    _bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftX, _midBgView.bottom+12, kAdaptationWidth(339), kAdaptationWidth(460))];
    _bottomBgView.backgroundColor=[UIColor whiteColor];
    _bottomBgView.layer.cornerRadius=10.0f;
    _bottomBgView.layer.masksToBounds=YES;
    [self addSubview:_bottomBgView];
    
    UILabel* sendInfoLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, 18, kAdaptationWidth(65), kAdaptationWidth(18))];
    sendInfoLabel.text=@"寄件信息";
    sendInfoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    sendInfoLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:sendInfoLabel];
    
    UILabel* sendNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), 18, kAdaptationWidth(120), kAdaptationWidth(18))];
    sendNameLabel.text=model.send_name;
    sendNameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    sendNameLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:sendNameLabel];
    
    UILabel* sendPhoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, 18, kAdaptationWidth(90), kAdaptationWidth(18))];
    sendPhoneLabel.text=model.send_mobile;
    sendPhoneLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    sendPhoneLabel.font = PingFangMedium(14);
    sendPhoneLabel.textAlignment=NSTextAlignmentRight;
    [_bottomBgView addSubview:sendPhoneLabel];
    sendPhoneLabel.right=_bottomBgView.width- kAdaptationWidth(18);
    
    UILabel* sendaddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), sendPhoneLabel.bottom+8, kAdaptationWidth(224), kAdaptationWidth(34))];
    sendaddressLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",model.send_province_name,model.send_city_name,model.send_district_name,model.send_address];
    sendaddressLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    sendaddressLabel.font = PingFangMedium(14);
    sendaddressLabel.numberOfLines=0;
    [_bottomBgView addSubview:sendaddressLabel];
    [sendaddressLabel sizeToFit];
    
    //***收件信息
    UILabel* receiveInfoLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,sendaddressLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    receiveInfoLabel.text=@"收件信息";
    receiveInfoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    receiveInfoLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:receiveInfoLabel];
    
    UILabel* receiveNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), receiveInfoLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    receiveNameLabel.text=model.accept_name;
    receiveNameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    receiveNameLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:receiveNameLabel];
    
    UILabel* receivePhoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, receiveInfoLabel.top, kAdaptationWidth(90), kAdaptationWidth(18))];
    receivePhoneLabel.text=model.accept_mobile;
    receivePhoneLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    receivePhoneLabel.font = PingFangMedium(14);
    receivePhoneLabel.textAlignment=NSTextAlignmentRight;
    [_bottomBgView addSubview:receivePhoneLabel];
    receivePhoneLabel.right=_bottomBgView.width- kAdaptationWidth(18);
    
    
    UILabel* receivedaddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), receivePhoneLabel.bottom+8, kAdaptationWidth(224), kAdaptationWidth(34))];
    receivedaddressLabel.text=[NSString localizedStringWithFormat:@"%@ %@ %@ %@",model.accept_province_name,model.accept_city_name,model.accept_district_name,model.accept_address];
    receivedaddressLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    receivedaddressLabel.font = PingFangMedium(14);
    receivedaddressLabel.numberOfLines=0;
    [_bottomBgView addSubview:receivedaddressLabel];
    [receivedaddressLabel sizeToFit];
    
    //***物品信息
    UILabel* wpInfoLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,receivedaddressLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    wpInfoLabel.text=@"物品信息";
    wpInfoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    wpInfoLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:wpInfoLabel];
    
    UILabel* wpDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), wpInfoLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    wpDetailLabel.text=[NSString stringWithFormat:@"%@/%@公斤",model.ordergoods.goods_type,model.ordergoods.goods_weight] ;
    wpDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    wpDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:wpDetailLabel];
    
    //***留言备注
    UILabel* messageLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,wpDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    messageLabel.text=@"留言备注";
    messageLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    messageLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:messageLabel];
    
    UILabel* messageDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), messageLabel.top, kAdaptationWidth(224), kAdaptationWidth(18))];
    if(model.user_remark.length == 0){
        messageDetailLabel.text=@"(无)";
    }else{
        messageDetailLabel.text=model.user_remark;
    }
    messageDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    messageDetailLabel.font = PingFangMedium(14);
    messageDetailLabel.numberOfLines=0;
    [_bottomBgView addSubview:messageDetailLabel];
    [messageDetailLabel sizeToFit];
    
    //***已付运费
//    UILabel* moneyInfoLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,messageDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
//    moneyInfoLabel.text=@"已付运费";
//    moneyInfoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
//    moneyInfoLabel.font = PingFangMedium(14);
//    [_bottomBgView addSubview:moneyInfoLabel];
//
//    UILabel* moneyDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), moneyInfoLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
//    moneyDetailLabel.text=[NSString stringWithFormat:@"￥ %@",model.pay_money];
//    moneyDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
//    moneyDetailLabel.font = PingFangMedium(14);
//    [_bottomBgView addSubview:moneyDetailLabel];
    
    //***运费方式
//    UILabel* moneyStyleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,moneyDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
//    moneyStyleLabel.text=@"付费方式";
//    moneyStyleLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
//    moneyStyleLabel.font = PingFangMedium(14);
//    [_bottomBgView addSubview:moneyStyleLabel];
//
//    UILabel* moneyStyleDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), moneyStyleLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
//    moneyStyleDetailLabel.text=@"在线支付";
//    moneyStyleDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
//    moneyStyleDetailLabel.font = PingFangMedium(14);
//    [_bottomBgView addSubview:moneyStyleDetailLabel];
    
    //***订单编号
    UILabel* orderLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,messageDetailLabel.bottom+20, kAdaptationWidth(60), kAdaptationWidth(18))];
    orderLabel.text=@"订单编号";
    orderLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    orderLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:orderLabel];
    
    UILabel* orderDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), orderLabel.top, kAdaptationWidth(200), kAdaptationWidth(18))];
    orderDetailLabel.text=model.pay_orderno;
    orderDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    orderDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:orderDetailLabel];
    [orderDetailLabel sizeToFit];
    orderDetailLabel.centerY=orderLabel.centerY;
    UIButton*  copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(orderDetailLabel.right, orderDetailLabel.top, 80, 20)];
    [copyBtn setTitleColor:[UIColor colorWithHex:@"#DF2F31"] forState:UIControlStateNormal];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = PingFangMedium(14);
    //[_bottomBgView addSubview:copyBtn];
    copyBtn.centerY= orderDetailLabel.centerY;
    
    //***下单时间
    UILabel* timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,orderDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    timeLabel.text=@"下单时间";
    timeLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    timeLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:timeLabel];
    
    UILabel* timeDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), timeLabel.top, kAdaptationWidth(180), kAdaptationWidth(18))];
    timeDetailLabel.text=model.create_time;
    timeDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    timeDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:timeDetailLabel];
    
    //***下单来源
//    UILabel* orderFromLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,timeDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
//    orderFromLabel.text=@"下单来源";
//    orderFromLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
//    orderFromLabel.font = PingFangMedium(14);
//    [_bottomBgView addSubview:orderFromLabel];
//
//    UILabel* orderFromDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), orderFromLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
//    orderFromDetailLabel.text=@"APP";
//    orderFromDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
//    orderFromDetailLabel.font = PingFangMedium(14);
    
//    [_bottomBgView addSubview:orderFromDetailLabel];
    
    _bottomBgView.height=timeDetailLabel.bottom+15;
    self.height=_bottomBgView.bottom+45;
    
    _bottomBgView.hidden = YES;
}


@end
