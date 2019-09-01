//
//  KDExpressDetailVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDExpressDetailVC.h"
#import "KDExpressDetailModel.h"
@interface KDExpressDetailVC ()
@property (nonatomic,strong) UIImageView* iconImgView;
@property (nonatomic,strong) UIView*  noticeBgView ;
@property (nonatomic,strong) UIView*  serviceBgView;
@property (nonatomic,strong) KDExpressDetailModel*  detailModel;


@end

@implementation KDExpressDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    //[self addChildViews];
    
    [self getWuLiuDetailData];
    
}

-(void)addChildViews{
    self.view.backgroundColor=rgb(240, 240, 240, 1);
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(274))];
    topBgImgView.image = [UIImage imageNamed:@"快递背景"];
    [self.view addSubview:topBgImgView];
    [self.view sendSubviewToBack:topBgImgView];
    
     _iconImgView= [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(152), NavibarH+kAdaptationWidth(10), kAdaptationWidth(70), kAdaptationWidth(70))];
    _iconImgView.layer.cornerRadius=kAdaptationWidth(35);
    _iconImgView.layer.masksToBounds = YES;
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *imageUrl = [NSURL URLWithString:weakSelf.model.src];
        weakSelf.iconImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    });
    [self.view addSubview:_iconImgView];
    
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconImgView.bottom+ 10, kScreenWidth, kAdaptationWidth(18))];
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.font =  PingFangBold(18);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    nameLabel.text=self.model.name;
    
     _noticeBgView= [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), topBgImgView.bottom-kAdaptationWidth(75), kAdaptationWidth(339), kAdaptationWidth(83))];
    _noticeBgView.backgroundColor=[UIColor whiteColor];
    _noticeBgView.layer.cornerRadius=6.0f;
    _noticeBgView.layer.masksToBounds=YES;
    [self.view addSubview:_noticeBgView];
    
    UILabel* noticeTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(18, 18, kAdaptationWidth(120), 18)];
    noticeTitleLabel.text=@"通知公告";
    noticeTitleLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    noticeTitleLabel.font = PingFangRegular(15);
    [_noticeBgView addSubview:noticeTitleLabel];
    
    UILabel* noticeLabel =[[UILabel alloc]initWithFrame:CGRectMake(18, noticeTitleLabel.bottom+10, kAdaptationWidth(321), 18)];
    noticeLabel.text=@"通知公告文字测试。通知公告文字测试，通知…";
    noticeLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    noticeLabel.font = PingFangRegular(15);
    [_noticeBgView addSubview:noticeLabel];
    
    //UIView*******
    _serviceBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), _noticeBgView.bottom+kAdaptationWidth(12), kAdaptationWidth(339), kAdaptationWidth(117))];
    _serviceBgView.backgroundColor=[UIColor whiteColor];
    _serviceBgView.layer.cornerRadius=8.0f;
    _serviceBgView.layer.masksToBounds=YES;
    [self.view addSubview:_serviceBgView];
    
    UILabel* serviceTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(16), kAdaptationWidth(120), kAdaptationWidth(15))];
    serviceTitleLabel.text=@"常用服务";
    serviceTitleLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    serviceTitleLabel.font = PingFangRegular(15);
    [_serviceBgView addSubview:serviceTitleLabel];
    
    NSArray* btnImgNameArr = @[@"图标-单号查询",@"图标-官方网站",@"图标-批量录单"];
    NSArray* titleNameArr = @[@"单号查询",@"官方网站",@"批量录单"];
    
    for(NSInteger i=0;i<3;i++){
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(45)+i* kAdaptationWidth(24+89),kAdaptationWidth(50), kAdaptationWidth(24), kAdaptationWidth(24))];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:btnImgNameArr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_serviceBgView addSubview:btn];
        
        UILabel* titleName=[[UILabel alloc]initWithFrame:CGRectMake(29, 86, 60, 18)];
        titleName.text=titleNameArr[i];
        titleName.textColor=[UIColor colorWithHex:@"#0B0B0B"];
        titleName.font = PingFangRegular(15);
        titleName.textAlignment=NSTextAlignmentCenter;
        titleName.centerX=btn.centerX;
        [_serviceBgView addSubview:titleName];
    }
    //底部新增快递按钮
    UIView* phoneBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    phoneBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:phoneBgView];
    
    //新增地址
    UIButton*  phoneBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
   
    [phoneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    phoneBtn.layer.cornerRadius=kAdaptationWidth(10);
    phoneBtn.layer.masksToBounds=YES;
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [phoneBgView addSubview:phoneBtn];
    
    UIImageView* phoneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(102), kAdaptationWidth(22), kAdaptationWidth(18), kAdaptationWidth(18))];
    phoneImgView.centerY=phoneBtn.centerY;
    phoneImgView.image = [UIImage imageNamed:@"图标-电话"];
    [phoneBgView addSubview:phoneImgView];
    
    UILabel* phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(142), 22, 180, 20)];
    phoneLabel.text=self.detailModel.logistics_mobile;
    phoneLabel.font = PingFangBold(18);
    phoneLabel.centerY=phoneBtn.centerY;
    phoneLabel.textColor=[UIColor whiteColor];
    phoneLabel.textAlignment=NSTextAlignmentCenter;
    [phoneBgView addSubview:phoneLabel];
}

-(void)phoneBtnClick{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",self.detailModel.logistics_mobile];
                          
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:self.detailModel.logistics_mobile preferredStyle:UIAlertControllerStyleAlert];
 
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

      }];
     UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
     }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)btnClick:(UIButton*)button{
    
}

-(void)getWuLiuDetailData{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":@"iphone"};
    NSDictionary* dic=@{@"id":self.model.model_ID};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kDetailwuliu Dic:dic headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            weakSelf.detailModel = [KDExpressDetailModel ModelWithDict:obj[@"data"]];
            [weakSelf addChildViews];
        }
    } FailureBlock:^(id obj) {
        
    }];
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    [self.titleView setTitle:@"快递详情"];
    self.nav.backgroundColor = [UIColor clearColor];
    self.backgroungImgView.hidden=YES;
}

@end
