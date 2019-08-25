//
//  KDMailingVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMailingVC.h"
#import "KDTitleView.h"
#import "KDAddressInfoView.h"
#import "KDGoodsInfoView.h"
#import "KDGoodsTypeInfoSelectView.h"
#import "KDExpressRecordController.h"
#import "KDExpressSelectView.h"
#import "KDTimeSelectView.h"
#import "KDMessageBoardView.h"
#import "KDAddressAdminVC.h"
#import "KDWuliuListModel.h"
#import "KDGoodsListModel.h"
#import "KDAddressAdminModel.h"

@interface KDMailingVC ()
<UITableViewDelegate,
UITableViewDataSource,
KDGoodsInfoViewDelegate,
KDTitleViewDelegate,
KDAddressInfoViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)KDTitleView *sendTitleView;

@property(nonatomic, strong)UILabel *tipLabel;

@property(nonatomic, strong)KDAddressInfoView *addressView;

@property(nonatomic, strong)KDGoodsInfoView *goodsInfoView;

@property(nonatomic, strong)NSMutableArray *wuliuArr;

@property(nonatomic, strong)NSMutableArray *goodsArr;

@property(nonatomic, assign)NSInteger goodsIndex;

@property(nonatomic, copy)NSString *imageUrl;

@property(nonatomic, copy)NSString *count;

@property(nonatomic, assign)NSInteger wuliuIndex;

@end

@implementation KDMailingVC

-(NSMutableArray *)wuliuArr{
    
    if (!_wuliuArr) {
        _wuliuArr = [NSMutableArray array];
    }
    return _wuliuArr;
}

-(NSMutableArray *)goodsArr{
    
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}

-(KDAddressInfoView *)addressView{
    
    if (!_addressView) {
        _addressView = [KDAddressInfoView addressInfoView];
        _addressView.center = CGPointMake(self.view.width/2.0, _addressView.center.y + 12);
        _addressView.delegate = self;
    }
    return _addressView;
}
-(KDGoodsInfoView *)goodsInfoView{
    if (!_goodsInfoView) {
        _goodsInfoView = [KDGoodsInfoView goodsInfoView];
        _goodsInfoView.goodsInfoViewDelegate = self;
        _goodsInfoView.frame = CGRectMake(18, CGRectGetMaxY(self.addressView.frame) - 12, _goodsInfoView.width, _goodsInfoView.height);
    }
    return _goodsInfoView;
}
-(UILabel *)tipLabel{
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"温馨提示：请填写正确的联系方式，\n预约成功后我们的工作人员将在2小时内与您联系。";
        _tipLabel.textColor = rgb(169, 169, 169, 1);
        _tipLabel.numberOfLines = 2;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = PingFangMedium(13);
    }
    return _tipLabel;
}

-(KDTitleView *)sendTitleView{
    
    if (!_sendTitleView) {
        _sendTitleView = [[KDTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        _sendTitleView.delegate = self;
    }
    return _sendTitleView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sendTitleView.height, self.view.width, kScreenRealHeight - self.sendTitleView.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = [self headerView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    }
    return _tableView;
}

- (UIView *)headerView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.addressView.height + self.goodsInfoView.height)];
    headerView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:self.addressView];
    
    [headerView addSubview:self.goodsInfoView];
    
    [headerView bringSubviewToFront:self.addressView];
    
    return headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.goodsIndex = -1;
    
    self.wuliuIndex = -1;
    
    [self setNav];
    
    [self createSubViews];
    
    [self updateFrame];
    
    [self getWuliuList];
    
    [self getGoodsTypeList];
}

-(void)setNav{
    
    self.backgroungImgView.image = [UIImage imageWithColor:rgb(223, 47, 49, 1)];
    self.backButton.hidden = YES;
    
}

- (void)createSubViews{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,NavibarH, kScreenWidth, kScreenRealHeight)];
    contentView.backgroundColor = rgb(250, 248, 248, 1);
    [self.view addSubview:contentView];
    
    [contentView addSubview:[self bgView]];
    
    [contentView addSubview:self.sendTitleView];
    
    [contentView addSubview:self.tipLabel];
    
    [contentView addSubview:self.tableView];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX).offset(0);
        make.bottom.equalTo(contentView.mas_bottom).offset(-25);
        make.width.mas_equalTo(300);
    }];
}

- (UIView *)bgView{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,0,kScreenWidth,180);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = bgView.frame;
    gl.startPoint = CGPointMake(0, 1);
    gl.endPoint = CGPointMake(0, 0);
    gl.colors = @[(__bridge id)rgb(250, 248, 248, 1.0).CGColor,(__bridge id)rgb(223, 47, 49, 1.0).CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [bgView.layer addSublayer:gl];
    return bgView;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

#pragma mark -- KDGoodsInfoViewDelegate
-(void)selectCellIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf =self;
    
    if (indexPath.row == 0) {
        if (self.goodsArr.count > 0) {
            
            [KDGoodsTypeInfoSelectView showSelectViewWithGoodsArr:self.goodsArr select:self.goodsIndex imageUrl:self.imageUrl confirmBlock:^(NSInteger index, NSString * _Nonnull imageUrl, NSString * _Nonnull count) {
                weakSelf.goodsIndex = index;
                weakSelf.imageUrl = imageUrl;
                weakSelf.count = count;
                KDGoodsListModel *model = weakSelf.goodsArr[index];
                weakSelf.goodsInfoView.goodsTypeTF.text = [NSString stringWithFormat:@"%@、%@公斤",model.goods_name,count];
                [weakSelf updateOrderButtonStatus];
            }];
            
        }
    }else if (indexPath.row == 1) {
        [KDExpressSelectView showSelectViewWithWuliuArr:self.wuliuArr select:self.wuliuIndex ConfirmBlock:^(NSInteger index) {
            
            weakSelf.wuliuIndex = index;
            KDWuliuListModel *model = weakSelf.wuliuArr[weakSelf.wuliuIndex + 1];
            weakSelf.goodsInfoView.expressTypeTF.text = model.logistics_name;
            [weakSelf updateOrderButtonStatus];
            
        }];
    }else if (indexPath.row == 2) {
        
        [KDTimeSelectView showSelectViewWithConfirmBlock:^(NSString * _Nonnull day, NSString * _Nonnull time) {
            
            NSString *date = @"";
            if ([day isEqualToString:@"今天"]) {
                date = [self getDayWithDiffrentDay:0];
            }else if ([day isEqualToString:@"明天"]) {
                date = [self getDayWithDiffrentDay:1];
            }else{
                date = [self getDayWithDiffrentDay:2];
            }
            
            weakSelf.goodsInfoView.timeTF.text = [NSString stringWithFormat:@"%@ %@",date,time];
            [weakSelf updateOrderButtonStatus];
            
        }];
    }else if (indexPath.row == 3) {
        
        [KDMessageBoardView showSelectViewWithConfirmBlock:^(NSString * _Nonnull customerMsg, NSString * _Nonnull traditionMsg) {
            
            if (customerMsg.length == 0) {
                 weakSelf.goodsInfoView.messageTF.text = traditionMsg;
            }else{
                 weakSelf.goodsInfoView.messageTF.text = [NSString stringWithFormat:@"%@,%@",customerMsg,traditionMsg];
            }
            [weakSelf updateOrderButtonStatus];
        }];
    }
    
}

-(void)clickConfirmButton{
    //下单
    
    __weak typeof(self) weakSelf =self;
    NSDictionary *params = @{
                             @"type":@"1",
                             @"user_id":@"",
                             @"pay_money":@"0",
                             @"send_name":self.addressView.sendAddressModel.name,
                             @"send_mobile":self.addressView.sendAddressModel.mobile,
                             @"send_province_name":self.addressView.sendAddressModel.province_name,
                             @"send_city_name":self.addressView.sendAddressModel.city_name,
                             @"send_district_name":self.addressView.sendAddressModel.district_name,
                             @"send_address":self.addressView.sendAddressModel.address,
                             @"accept_name":self.addressView.receiveAddressModel.name,
                             @"accept_mobile":self.addressView.receiveAddressModel.mobile,
                             @"accept_province_name":self.addressView.receiveAddressModel.province_name,
                             @"accept_city_name":self.addressView.receiveAddressModel.city_name,
                             @"accept_district_name":self.addressView.receiveAddressModel.district_name,
                             @"accept_address":self.addressView.receiveAddressModel.address,
                             @"delivery_code" : @"",
                             @"delivery_name" : @"",
                             @"delivery_orderno" : @"",
                             @"deliver_want_time" : self.goodsInfoView.timeTF.text,
                             @"user_remark" : self.goodsInfoView.messageTF.text,
                             @"goods_type" : @"",
                             @"weight" : @"",
                             @"goods_imgs" : @"",
                             @"goods_price" : @""
                             };
    [ZJCustomHud showWithStatus:@"下单中..."];
    [KDNetWorkManager GetHttpDataWithUrlStr:kCreateOrder Dic:params headDic:nil SuccessBlock:^(id obj) {
        
        [ZJCustomHud dismiss];
        
        if([obj[@"code"] integerValue] == 1){
            
            [ZJCustomHud showWithSuccess:@"下单成功"];
            KDExpressRecordController *vc = [[KDExpressRecordController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
    
   
}

#pragma mark -- KDTitleViewDelegate
-(void)lookExpressRecord{
    
    KDExpressRecordController *vc = [[KDExpressRecordController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- KDAddressInfoViewDelegate
-(void)selectSendExpressAddress{
    
    KDAddressAdminVC *vc = [[KDAddressAdminVC alloc] init]; 
    vc.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf =self;
    vc.selectAddressBlock = ^(KDAddressAdminModel * _Nonnull model) {
        weakSelf.addressView.sendAddressModel = model;
        [weakSelf updateFrame];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)selectReceiveExpressAddress{
    
    KDAddressAdminVC *vc = [[KDAddressAdminVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf =self;
    vc.selectAddressBlock = ^(KDAddressAdminModel * _Nonnull model) {
        weakSelf.addressView.receiveAddressModel = model;
        [weakSelf updateFrame];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateFrame{
    
    if (self.addressView.sendAddressModel && self.addressView.receiveAddressModel) {
        
        self.tableView.tableHeaderView.height = self.addressView.height + self.goodsInfoView.height;
        self.goodsInfoView.hidden = NO;
        self.addressView.bottomView.hidden = NO;
        
        if (self.goodsArr.count > 0) {
            __weak typeof(self) weakSelf =self;
            [KDGoodsTypeInfoSelectView showSelectViewWithGoodsArr:self.goodsArr select:self.goodsIndex imageUrl:self.imageUrl confirmBlock:^(NSInteger index, NSString * _Nonnull imageUrl, NSString * _Nonnull count) {
                weakSelf.goodsIndex = index;
                weakSelf.imageUrl = imageUrl;
                weakSelf.count = count;
                KDGoodsListModel *model = weakSelf.goodsArr[index];
                weakSelf.goodsInfoView.goodsTypeTF.text = [NSString stringWithFormat:@"%@、%@公斤",model.goods_name,count];
            }];
        }
        
    }else{
        
        self.tableView.tableHeaderView.height = self.addressView.height;
        self.goodsInfoView.hidden = YES;
        self.addressView.bottomView.hidden = YES;
        
    }
}

- (void)updateOrderButtonStatus{
    
    if (self.goodsInfoView.messageTF.text.length > 0 && self.goodsInfoView.goodsTypeTF.text.length > 0 && self.goodsInfoView.expressTypeTF.text.length > 0 && self.goodsInfoView.timeTF.text.length > 0) {
        self.goodsInfoView.isOrderButtonSelect = YES;
    }else{
        self.goodsInfoView.isOrderButtonSelect = NO;
    }
    
    if (self.count.integerValue > 0) {
        self.goodsInfoView.money = 12 + 5*(self.count.integerValue - 1);
    }
    
}

- (NSString *)getDayWithDiffrentDay:(NSInteger)diffrentDay {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:([components day]+diffrentDay)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark -- 网络请求
//物流列表
-(void)getWuliuList{
    
    __weak typeof(self) weakSelf =self;
    
    [KDNetWorkManager GetHttpDataWithUrlStr:kWuliuList Dic:nil headDic:nil SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            
            NSArray *data = obj[@"data"];
            for (NSDictionary *dic in data) {
                
                KDWuliuListModel *model = [KDWuliuListModel mj_objectWithKeyValues:dic];
                [weakSelf.wuliuArr addObject:model];
                
            }
            
            KDWuliuListModel *model = weakSelf.wuliuArr[weakSelf.wuliuIndex + 1];
            weakSelf.goodsInfoView.expressTypeTF.text = model.logistics_name;
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
}

//物流列表
-(void)getGoodsTypeList{
    
    __weak typeof(self) weakSelf =self;
    
    [KDNetWorkManager GetHttpDataWithUrlStr:kGoodsList Dic:nil headDic:nil SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            
            NSArray *data = obj[@"data"];
            for (NSDictionary *dic in data) {
                
                KDGoodsListModel *model = [KDGoodsListModel mj_objectWithKeyValues:dic];
                [weakSelf.goodsArr addObject:model];
                
            }
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
}


@end
