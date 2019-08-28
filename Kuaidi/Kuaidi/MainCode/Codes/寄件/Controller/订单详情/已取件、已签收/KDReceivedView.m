//
//  KDReceivedView.m
//  Kuaidi
//
//  Created by cxf on 2019/8/28.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDReceivedView.h"
#import "UIButton+EnlargeTouchArea.h"
@interface KDReceivedView()
//取件码
@property (nonatomic,strong) UIView *qjmBgView;
@property (nonatomic,strong) UILabel* qjmLabel;
@property (nonatomic,strong) UIImageView* qjmImgView;


@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,strong) UILabel* smTimeLabel;


@property (nonatomic,strong) UIView *midBgView;
@property (nonatomic,strong) UIImageView* iconImgView;
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

@implementation KDReceivedView

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
    _qjmBgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftX, 8, kAdaptationWidth(339), kAdaptationWidth(66))];
    _qjmBgView.backgroundColor=[UIColor whiteColor];
    _qjmBgView.layer.cornerRadius=10.0f;
    _qjmBgView.layer.masksToBounds=YES;
    [self addSubview:_qjmBgView];
    _qjmLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(25), kAdaptationWidth(339), kAdaptationWidth(20))];
    _qjmLabel.text=@"百世单号：51788830908260";
    _qjmLabel.textColor=[UIColor colorWithHex:@"#DF2F31"];
    _qjmLabel.textAlignment=NSTextAlignmentCenter;
    _qjmLabel.font =PingFangBold(15);
    [_qjmBgView addSubview:_qjmLabel];
    
     //****顶部快递员相关
    _topBgView = [[UIView alloc]initWithFrame:CGRectMake(kLeftX,_qjmBgView.bottom+ 8, kAdaptationWidth(339), kAdaptationWidth(192))];
    _topBgView.backgroundColor=[UIColor whiteColor];
    _topBgView.layer.cornerRadius=10.0f;
    _topBgView.layer.masksToBounds=YES;
    [self addSubview:_topBgView];
    UILabel* topTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(36), kAdaptationWidth(339), kAdaptationWidth(20))];
    topTitleLabel.text=@"快递员已接单";
    topTitleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    topTitleLabel.textAlignment=NSTextAlignmentCenter;
    topTitleLabel.font =PingFangBold(18);
    [_topBgView addSubview:topTitleLabel];
    _smTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, topTitleLabel.bottom+10, kAdaptationWidth(339), kAdaptationWidth(18))];
    _smTimeLabel.text=@"取件时间：2019/08/08 14:00";
    _smTimeLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _smTimeLabel.textAlignment=NSTextAlignmentCenter;
    _smTimeLabel.font = PingFangMedium(14);
    [_topBgView addSubview:_smTimeLabel];
    
    UIView* expressBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(120), kAdaptationWidth(339), kAdaptationWidth(78))];
    expressBgView.backgroundColor=rgb(245, 245, 245, 1);
    [_topBgView addSubview:expressBgView];
    
    _iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, kAdaptationWidth(42), kAdaptationWidth(42))];
    _iconImgView.image=[UIImage imageNamed:@"Logo"];
    _iconImgView.layer.cornerRadius =kAdaptationWidth(21);
    _iconImgView.layer.masksToBounds=YES;
    _iconImgView.image = [UIImage imageNamed:@"图片-头像"];
    [expressBgView addSubview:_iconImgView];
    _nameExpressLabel =[[UILabel alloc]initWithFrame:CGRectMake(73, topTitleLabel.bottom, kAdaptationWidth(239), kAdaptationWidth(18))];
    _nameExpressLabel.text=@"周杰伦";
    _nameExpressLabel.textColor=[UIColor colorWithHex:@"5C5C5C"];
    _nameExpressLabel.font = PingFangMedium(15);
    [expressBgView addSubview:_nameExpressLabel];
    _nameExpressLabel.centerY =_iconImgView.centerY;
    
    UIButton*  phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(297, 18, kAdaptationWidth(24), kAdaptationWidth(24))];
    [phoneBtn setImage:[UIImage imageNamed:@"图标-电话1"] forState:UIControlStateNormal];
    phoneBtn.layer.cornerRadius = kAdaptationWidth(12);
    phoneBtn.layer.borderColor=[UIColor colorWithHex:@"#DF2F31"].CGColor;
    phoneBtn.layer.borderWidth=1;
    phoneBtn.layer.masksToBounds=YES;
    [phoneBtn setEnlargeEdge:20];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.centerY=_iconImgView.centerY;
    [expressBgView addSubview:phoneBtn];
    
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
    
    _moneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(200), _toCityLabel.bottom, kAdaptationWidth(120), kAdaptationWidth(18))];
    _moneyLabel.text=@"已支付￥800元";
    _moneyLabel.textColor=[UIColor colorWithHex:@"#DF2F31"];
    _moneyLabel.textAlignment=NSTextAlignmentCenter;
    _moneyLabel.font = PingFangRegular(13);
    [_midBgView addSubview:_moneyLabel];
    _moneyLabel.centerX=toImgView.centerX;
    
    _kgLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(87), kAdaptationWidth(339), kAdaptationWidth(18))];
    _kgLabel.text=@"首重¥8.0，续重¥2.0/公斤";
    _kgLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    _kgLabel.textAlignment=NSTextAlignmentCenter;
    _kgLabel.font = PingFangRegular(13);
    [_midBgView addSubview:_kgLabel];
    
    _showInfoBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(95), _midBgView.bottom+15, kAdaptationWidth(149), kAdaptationWidth(18))];
    [_showInfoBtn setTitle:@"点击展开订单详情" forState:UIControlStateNormal];
    _showInfoBtn.titleLabel.font = PingFangRegular(14);
    [_showInfoBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
    [_showInfoBtn addTarget:self action:@selector(showInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _showInfoBtn.tag=0;
    [self addSubview:_showInfoBtn];
    
    
    //底部按钮
    _contactBgView =[[UIView alloc]initWithFrame:CGRectMake(0, self.size.height-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    _contactBgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_contactBgView];
    
    //再下一单
    _contactBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [_contactBtn setTitle:@"再下一单" forState:UIControlStateNormal];
    [_contactBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_contactBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    _contactBtn.layer.cornerRadius=kAdaptationWidth(10);
    _contactBtn.layer.masksToBounds=YES;
    [_contactBtn addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contactBgView addSubview:_contactBtn];
    
    [self setInfoDetail];
    _bottomBgView.hidden = YES;
}
-(void)showInfoBtnClick:(UIButton*)btn{
    if(btn.tag == 0){
        btn.top=_bottomBgView.bottom+15;
        _contactBgView.hidden=YES;
        _bottomBgView.hidden = NO;
        btn.tag=1;
        [_showInfoBtn setTitle:@"点击收起订单详情" forState:UIControlStateNormal];
    }else{
        btn.top=_midBgView.bottom+15;
        _contactBgView.hidden=NO;
        _bottomBgView.hidden = YES;
        btn.tag=0;
        [_showInfoBtn setTitle:@"点击展开订单详情" forState:UIControlStateNormal];
    }
    if(self.myIsShowInfoBlock){
        self.myIsShowInfoBlock(btn.tag);
    }
}
-(void)contactBtnClick{
    
}
-(void)setInfoDetail{
    
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
    sendNameLabel.text=@"刘德华";
    sendNameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    sendNameLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:sendNameLabel];
    
    UILabel* sendPhoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, 18, kAdaptationWidth(90), kAdaptationWidth(18))];
    sendPhoneLabel.text=@"13987867564";
    sendPhoneLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    sendPhoneLabel.font = PingFangMedium(14);
    sendPhoneLabel.textAlignment=NSTextAlignmentRight;
    [_bottomBgView addSubview:sendPhoneLabel];
    sendPhoneLabel.right=_bottomBgView.width- kAdaptationWidth(18);
    
    UILabel* sendaddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), sendPhoneLabel.bottom+8, kAdaptationWidth(224), kAdaptationWidth(34))];
    sendaddressLabel.text=@" 广东省 深圳市 龙岗区 横岗街道大运软件小镇大运软件小镇01栋";
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
    receiveNameLabel.text=@"郭富城";
    receiveNameLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    receiveNameLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:receiveNameLabel];
    
    UILabel* receivePhoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, receiveInfoLabel.top, kAdaptationWidth(90), kAdaptationWidth(18))];
    receivePhoneLabel.text=@"13987867566";
    receivePhoneLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    receivePhoneLabel.font = PingFangMedium(14);
    receivePhoneLabel.textAlignment=NSTextAlignmentRight;
    [_bottomBgView addSubview:receivePhoneLabel];
    receivePhoneLabel.right=_bottomBgView.width- kAdaptationWidth(18);
    
    
    UILabel* receivedaddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), receivePhoneLabel.bottom+8, kAdaptationWidth(224), kAdaptationWidth(34))];
    receivedaddressLabel.text=@" 广东省 深圳市 龙岗区 横岗街道大运软件小镇大运软件小镇01栋";
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
    wpDetailLabel.text=@"文件/1.0公交";
    wpDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    wpDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:wpDetailLabel];
    
    //***留言备注
    UILabel* messageLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,wpDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    messageLabel.text=@"留言备注";
    messageLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    messageLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:messageLabel];
    
    UILabel* messageDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), messageLabel.top, kAdaptationWidth(200), kAdaptationWidth(18))];
    messageDetailLabel.text=@"这里是留言备注测文字，这里是留言备注测文字。 ";
    messageDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    messageDetailLabel.font = PingFangMedium(14);
    messageDetailLabel.numberOfLines=0;
    [_bottomBgView addSubview:messageDetailLabel];
    [messageDetailLabel sizeToFit];
    
    //***已付运费
    UILabel* moneyInfoLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,messageDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    moneyInfoLabel.text=@"已付运费";
    moneyInfoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    moneyInfoLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:moneyInfoLabel];
    
    UILabel* moneyDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), moneyInfoLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    moneyDetailLabel.text=@"¥8.0";
    moneyDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    moneyDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:moneyDetailLabel];
    
    //***运费方式
    UILabel* moneyStyleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,moneyDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    moneyStyleLabel.text=@"付费方式";
    moneyStyleLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    moneyStyleLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:moneyStyleLabel];
    
    UILabel* moneyStyleDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), moneyStyleLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    moneyStyleDetailLabel.text=@"在线支付";
    moneyStyleDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    moneyStyleDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:moneyStyleDetailLabel];
    
    //***订单编号
    UILabel* orderLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,moneyStyleDetailLabel.bottom+20, kAdaptationWidth(60), kAdaptationWidth(18))];
    orderLabel.text=@"订单编号";
    orderLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    orderLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:orderLabel];
    
    UILabel* orderDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), orderLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    orderDetailLabel.text=@"201808071400";
    orderDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    orderDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:orderDetailLabel];
    UIButton*  copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(orderDetailLabel.right+20, orderDetailLabel.top, 80, 20)];
    [copyBtn setTitleColor:[UIColor colorWithHex:@"#DF2F31"] forState:UIControlStateNormal];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:copyBtn];
    copyBtn.centerY= orderDetailLabel.centerY;
    
    //***下单时间
    UILabel* timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,orderDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    timeLabel.text=@"下单时间";
    timeLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    timeLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:timeLabel];
    
    UILabel* timeDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), timeLabel.top, kAdaptationWidth(180), kAdaptationWidth(18))];
    timeDetailLabel.text=@"2019/09/09 14:00:00";
    timeDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    timeDetailLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:timeDetailLabel];
    
    //***下单来源
    UILabel* orderFromLabel =[[UILabel alloc]initWithFrame:CGRectMake(kLeftX,timeDetailLabel.bottom+20, kAdaptationWidth(65), kAdaptationWidth(18))];
    orderFromLabel.text=@"下单来源";
    orderFromLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    orderFromLabel.font = PingFangMedium(14);
    [_bottomBgView addSubview:orderFromLabel];
    
    UILabel* orderFromDetailLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(98), orderFromLabel.top, kAdaptationWidth(120), kAdaptationWidth(18))];
    orderFromDetailLabel.text=@"APP";
    orderFromDetailLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    orderFromDetailLabel.font = PingFangMedium(14);
    
    [_bottomBgView addSubview:orderFromDetailLabel];
    
    _bottomBgView.height=orderFromDetailLabel.bottom+15;
    self.height=_bottomBgView.bottom+45;
}

-(void)phoneBtnClick{
    
}

@end
