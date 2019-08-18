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

@interface KDMailingVC ()
<UITableViewDelegate,
UITableViewDataSource,
KDGoodsInfoViewDelegate,
KDTitleViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)KDTitleView *sendTitleView;

@property(nonatomic, strong)UILabel *tipLabel;

@property(nonatomic, strong)KDAddressInfoView *addressView;

@property(nonatomic, strong)KDGoodsInfoView *goodsInfoView;

@end

@implementation KDMailingVC
-(KDAddressInfoView *)addressView{
    
    if (!_addressView) {
        _addressView = [KDAddressInfoView addressInfoView];
        _addressView.center = CGPointMake(self.view.width/2.0, _addressView.center.y + 12);
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
    
    [self setNav];
    
    [self createSubViews];
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
    
//    [KDGoodsTypeInfoSelectView showSelectViewWithConfirmBlock:^(NSString * _Nonnull goodsType, NSInteger weight, UIImage * _Nonnull image) {
//
//    }];
    
    [KDExpressSelectView showSelectViewWithConfirmBlock:^(NSString * _Nonnull expressType) {
        
    }];
    
}

-(void)clickConfirmButton{
    
   
}

#pragma mark -- KDTitleViewDelegate
-(void)lookExpressRecord{
    
    KDExpressRecordController *vc = [[KDExpressRecordController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
