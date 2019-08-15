//
//  KDMineVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMineVC.h"
#import "KDInfoCell.h"
#import "KDInfoModel.h"
#import "KDLoginVC.h"
@interface KDMineVC ()<UITableViewDelegate,UITableViewDataSource>
//头像图片
@property(nonatomic,strong)UIImageView* headImgVIew;
//账号label
@property(nonatomic,strong)UILabel* nameLabel;

@property(nonatomic,strong)UIView* infoBgView;

@property(nonatomic,strong)UITableView* tableview;

@property(nonatomic,strong)NSMutableArray* dataSource;



@end

@implementation KDMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViews];
}
//66666666666
-(void)addChildViews{
    
    //隐藏自定义导航栏
    self.nav.hidden = YES;
    
    CGFloat heightX= 0;
    if((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)){
        heightX=20;
    }
    //顶部背景图片
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(178)+heightX)];
    topBgImgView.image = [UIImage imageNamed:@"我的-背景"];
    [self.view addSubview:topBgImgView];
    
    //头像图片
    _headImgVIew = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(44)+heightX, kAdaptationWidth(60), kAdaptationWidth(60))];
    _headImgVIew.image = [UIImage imageNamed:@"图片-头像"];
    [self.view addSubview:_headImgVIew];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(96), kAdaptationWidth(53)+heightX, kAdaptationWidth(260), kAdaptationWidth(22))];
    _nameLabel.text=@"登录/注册";
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 22];
    [self.view addSubview:_nameLabel];
    
    UITapGestureRecognizer* clickTap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginTapClick)];
    _nameLabel.userInteractionEnabled=YES;
    [_nameLabel addGestureRecognizer:clickTap];
    
    
    //欢迎使用快递么
    UILabel* desLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(96),_nameLabel.bottom+ kAdaptationWidth(7), kAdaptationWidth(260), kAdaptationWidth(15))];
    desLabel.text=@"欢迎使用快递么";
    desLabel.textColor=[UIColor whiteColor];
    desLabel.font =[UIFont fontWithName:@"PingFang-SC-Regular" size: 13];
    [self.view addSubview:desLabel];
    
    //寄件二维码UIView*******
    UIView*  scanView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), _headImgVIew.bottom+kAdaptationWidth(24), kAdaptationWidth(339), kAdaptationWidth(60))];
    scanView.backgroundColor=[UIColor whiteColor];
    scanView.layer.cornerRadius=6.0f;
    scanView.layer.masksToBounds=YES;
    [self.view addSubview:scanView];
    
    UILabel* scanTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), 0, kAdaptationWidth(120), kAdaptationWidth(60))];
    scanTitleLabel.text=@"寄件二维码";
    scanTitleLabel.textColor=[UIColor blackColor];
    scanTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [scanView addSubview:scanTitleLabel];
    
    UIImageView* scanIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(297), kAdaptationWidth(10), kAdaptationWidth(18), kAdaptationWidth(18))];
    scanIconImgView.image=[UIImage imageNamed:@"我的-图标-二维码"];
    [scanView addSubview:scanIconImgView];
    scanIconImgView.centerY=scanTitleLabel.centerY;
    
    //淘宝客  京东客
    UIView*  platformView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), scanView.bottom+kAdaptationWidth(10), kAdaptationWidth(339), kAdaptationWidth(86))];
    platformView.backgroundColor=[UIColor whiteColor];
    platformView.layer.cornerRadius=6.0f;
    platformView.layer.masksToBounds=YES;
    [self.view addSubview:platformView];
    
    //淘宝客Btn
    UIButton* tbBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(67), kAdaptationWidth(10), kAdaptationWidth(53), kAdaptationWidth(52))];
    [tbBtn setBackgroundImage:[UIImage imageNamed:@"图标-淘宝"] forState:UIControlStateNormal];
    [tbBtn addTarget:self action:@selector(tbBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [platformView addSubview:tbBtn];
    //淘宝客Label
    UILabel* tbLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(67), kAdaptationWidth(61), tbBtn.width, kAdaptationWidth(15))];
    tbLabel.text=@"淘宝客";
    tbLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    tbLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
    tbLabel.textAlignment=NSTextAlignmentCenter;
    [platformView addSubview:tbLabel];
    
    
    //京东Btn
    UIButton* jdBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(219), kAdaptationWidth(10), kAdaptationWidth(53), kAdaptationWidth(52))];
    [jdBtn setBackgroundImage:[UIImage imageNamed:@"图标-京东"] forState:UIControlStateNormal];
    [jdBtn addTarget:self action:@selector(jdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [platformView addSubview:jdBtn];
    //京东Label
    UILabel* jdLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(219), kAdaptationWidth(61), jdBtn.width, kAdaptationWidth(15))];
    jdLabel.text=@"京东客";
    jdLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    jdLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
    jdLabel.textAlignment=NSTextAlignmentCenter;
    [platformView addSubview:jdLabel];
    
    //订单导入UIView*******
    UIView*  orderBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), platformView.bottom+kAdaptationWidth(8), kAdaptationWidth(339), kAdaptationWidth(95))];
    orderBgView.backgroundColor=[UIColor whiteColor];
    orderBgView.layer.cornerRadius=6.0f;
    orderBgView.layer.masksToBounds=YES;
    [self.view addSubview:orderBgView];
    
    UILabel* orderTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(12), kAdaptationWidth(120), kAdaptationWidth(15))];
    orderTitleLabel.text=@"订单导入";
    orderTitleLabel.textColor=[UIColor blackColor];
    orderTitleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 15];
    [orderBgView addSubview:orderTitleLabel];
    
    NSArray* btnImgNameArr = @[@"我的-图标-淘宝",@"我的-图标-京东",@"我的-图标-顺丰"];
    for(NSInteger i=0;i<3;i++){
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(33)+i* kAdaptationWidth(48+65),orderTitleLabel.bottom+kAdaptationWidth(10), kAdaptationWidth(48), kAdaptationWidth(48))];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:btnImgNameArr[i]] forState:UIControlStateNormal];
        btn.layer.borderWidth=1.0f;
        btn.layer.borderColor=rgb(220, 220, 220, 1).CGColor;
        btn.layer.cornerRadius=kAdaptationWidth(24);
        btn.layer.masksToBounds=YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [orderBgView addSubview:btn];
    }
    
    //个人设置UIview********
    _infoBgView = [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), orderBgView.bottom+kAdaptationWidth(8), kAdaptationWidth(339), kScreenHeight- orderBgView.bottom - kAdaptationWidth(20)-TabbarH)];
    _infoBgView.backgroundColor=[UIColor whiteColor];
    _infoBgView.layer.cornerRadius=6.0f;
    _infoBgView.layer.masksToBounds=YES;
    [self.view addSubview:_infoBgView];
    
    [_infoBgView addSubview:self.tableview];
    
    if(self.dataSource.count>0){
        [self.tableview reloadData];
    }
}


//订单导入按钮
-(void)btnClick:(UIButton*)button{
    if(button.tag == 0){//淘宝
        
    }else if (button.tag == 1){//京东
        
    }else if (button.tag == 2){//顺丰
        
    }
}
//淘宝客按钮
-(void)tbBtnClick{
    
}
//京东按钮
-(void)jdBtnClick{
    
}
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kAdaptationWidth(339), _infoBgView.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
        }
        _tableview.tableFooterView=[UIView new];
    }
    return _tableview;
}
-(NSMutableArray*)dataSource{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc]init];
        NSArray* headImgArr= @[@"我的-图标-积分",@"我的-图标-地址管理",@"我的-图标-常用快递",@"我的-图-系统设置",@"我的-图标-帮助中心",@"我的-图标-关于我们"];
        NSArray* titleArr= @[@"积分:12",@"地址管理",@"常用快递",@"系统设置",@"帮助中心",@"关于我们"];
        NSArray* desArr= @[@"玩转任务,挣取积分",@"",@"关联平台,管理快递",@"",@"",@""];
        for (NSInteger i=0;i<headImgArr.count;i++){
            KDInfoModel* model = [[KDInfoModel alloc]init];
            model.headImgName=headImgArr[i];
            model.titleStr=titleArr[i];
            model.desStr=desArr[i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"KDInfoCell_ID";
    KDInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KDInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    KDInfoModel* model = self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES)?kAdaptationWidth(50):kAdaptationWidth(40);
}

-(void)loginTapClick{
    KDLoginVC* loginVC= [[KDLoginVC alloc]init];
    loginVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end
