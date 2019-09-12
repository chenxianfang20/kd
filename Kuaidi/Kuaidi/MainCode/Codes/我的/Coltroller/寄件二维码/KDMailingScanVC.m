//
//  KDMailingScanVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMailingScanVC.h"
#import "KDAddressAdminModel.h"
#import "QRCodeTool.h"
@interface KDMailingScanVC(){
    UIScrollView* scrollowView;
    UIButton*  saveScanImgBtn;
}

//二维码图片
@property (nonatomic,strong) UIImageView *scanImgView;
@end
@implementation KDMailingScanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}


-(void)addChildViews{
    
    scrollowView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight-kAdaptationWidth(90)-NavibarH )];
    scrollowView.scrollEnabled=YES;
    scrollowView.backgroundColor=rgb(245, 245, 245, 1);
    [self.view addSubview:scrollowView];
    
    UIView* topBgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), 2, kAdaptationWidth(267), kAdaptationWidth(371))];
    topBgView.backgroundColor=[UIColor whiteColor];
    topBgView.layer.cornerRadius=8.0f;
    topBgView.layer.masksToBounds=YES;
    [scrollowView addSubview:topBgView];
    
    UIView* redBgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAdaptationWidth(371), kAdaptationWidth(264))];
    redBgView.backgroundColor=[UIColor redColor];
    [topBgView addSubview:redBgView];
    //标题
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, kAdaptationWidth(18), kAdaptationWidth(267), 20)];
    titleLabel.text=@"微信扫一扫 直接寄快递";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font =PingFangBold(18);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topBgView addSubview:titleLabel];
    
    UIView* whiteScanBgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(41), titleLabel.bottom+kAdaptationWidth(14), kAdaptationWidth(186), kAdaptationWidth(186))];
    whiteScanBgView.backgroundColor=[UIColor whiteColor];
    [topBgView addSubview:whiteScanBgView];
    _scanImgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 16, kAdaptationWidth(154), kAdaptationWidth(154))];
    //二维码图片
    _scanImgView.image = [QRCodeTool createScanImageForWX_Scan:@"https://itunes.apple.com/cn/app/快递么/id1479799971?mt=8"];
    [whiteScanBgView addSubview:_scanImgView];
    //描述文字
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, redBgView.bottom+ kAdaptationWidth(8), kAdaptationWidth(267), 43)];
    desLabel.text=@"扫码后填写你的收件地址，我就\n可以给你寄快递了！";
    desLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    desLabel.font =PingFangRegular(14);
    desLabel.textAlignment=NSTextAlignmentCenter;
    desLabel.numberOfLines=0;
    [topBgView addSubview:desLabel];
    
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), desLabel.bottom+kAdaptationWidth(8), kAdaptationWidth(231), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#F1F1F1"];
    [topBgView addSubview:sepLabel];
    
    //描述文字
    UILabel* bottomDesLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, sepLabel.bottom+ kAdaptationWidth(2), kAdaptationWidth(267), 43)];
    bottomDesLabel.text=@"由快递么提供技术支持";
    bottomDesLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    bottomDesLabel.font =PingFangMedium(13);
    bottomDesLabel.textAlignment=NSTextAlignmentCenter;
    [topBgView addSubview:bottomDesLabel];
    
    saveScanImgBtn= [[UIButton alloc]initWithFrame:CGRectMake(topBgView.left, topBgView.bottom+4, topBgView.width, kAdaptationWidth(45))];
    [saveScanImgBtn setTitle:@"保存二维码" forState:UIControlStateNormal];
    [saveScanImgBtn setTitleColor:[UIColor colorWithHex:kMainRedColor]  forState:UIControlStateNormal];
    saveScanImgBtn.titleLabel.font = PingFangBold(18);
    [scrollowView addSubview:saveScanImgBtn];
    
    [self getDefaultAddress];
    
    //底部分享按钮
    UIView* shareBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    shareBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:shareBgView];
    
    
    UIButton*  shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [shareBtn setTitle:@"分享给微信好友" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius=kAdaptationWidth(10);
    shareBtn.layer.masksToBounds=YES;
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBgView addSubview:shareBtn];
    
}
-(void)getDefaultAddress{
    KDUserModel* model = [KDUserModelTool userModel];
    
    NSDictionary* headData=@{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kDefaultAddress Dic:nil headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            if ([obj[@"data"] isKindOfClass:[NSNull class]] || [obj[@"data"] isEqual:[NSNull null]] || obj[@"data"] == nil) {
                return ;
            }
            KDAddressAdminModel* model = [KDAddressAdminModel ModelWithDict:obj[@"data"]];
            [weakSelf setUpDefault:model];
        }
    } FailureBlock:^(id obj) {
        
    }];
}
-(void)setUpDefault:(KDAddressAdminModel*)model{
    //底部寄件地址
    UILabel* addressTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), saveScanImgBtn.bottom+ kAdaptationWidth(22), kAdaptationWidth(180), 15)];
    addressTitleLabel.text=@"默认寄件地址：";
    addressTitleLabel.textColor=rgb(80, 80, 80, 1);
    addressTitleLabel.font =PingFangMedium(15);
    [scrollowView addSubview:addressTitleLabel];
    
    UIView* adressBgView =[[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), addressTitleLabel.bottom+10, kAdaptationWidth(267), kAdaptationWidth(95))];
    adressBgView.backgroundColor=[UIColor whiteColor];
    adressBgView.layer.cornerRadius=8.0f;
    adressBgView.layer.masksToBounds=YES;
    [scrollowView addSubview:adressBgView];
    scrollowView.contentSize= CGSizeMake(kScreenWidth, adressBgView.bottom+8);
    
    UIImageView* leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(38), kAdaptationWidth(18), kAdaptationWidth(18))];
    leftImgView.image = [UIImage imageNamed:@"图标-寄件人"];
    [adressBgView addSubview:leftImgView];
    
    UIImageView* rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(231), kAdaptationWidth(38), kAdaptationWidth(18), kAdaptationWidth(18))];
    rightImgView.image = [UIImage imageNamed:@"图标-通讯录"];
    [adressBgView addSubview:rightImgView];
    
    
    UILabel* infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(54), kAdaptationWidth(18), kAdaptationWidth(220), 15)];
    infoLabel.text=[NSString stringWithFormat:@"%@ %@",model.name,model.mobile];
    infoLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    infoLabel.font =PingFangMedium(15);
    [adressBgView addSubview:infoLabel];
    
    UILabel* addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(54),infoLabel.bottom+ kAdaptationWidth(8), kAdaptationWidth(160), 40)];
    addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",model.province_name,model.city_name,model.district_name,model.address];
    addressLabel.textColor=[UIColor colorWithHex:@"#A9A9A9"];
    addressLabel.font =PingFangMedium(13);
    [adressBgView addSubview:addressLabel];
    addressLabel.numberOfLines=0;
    
}

-(void)shareBtnClick{
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"寄件二维码"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
