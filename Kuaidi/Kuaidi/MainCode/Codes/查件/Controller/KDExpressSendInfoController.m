//
//  KDExpressSendInfoController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressSendInfoController.h"
#import "DKExpressSendInfoCell.h"
#import "DKExpressSendInfoHeaderView.h"
#import "KDWuliuGuijiModel.h"
#import "DKExpressFindTextView.h"

@interface KDExpressSendInfoController ()<UITableViewDelegate,UITableViewDataSource,DKExpressFindTextViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)DKExpressSendInfoHeaderView *headerView;

@property(nonatomic, strong)DKExpressFindTextView *textfieldHeaderView;

@property(nonatomic, strong)UIView *footerView;

@property(nonatomic, strong)KDWuliuGuijiModel *model;

@property(nonatomic, copy)NSString *phoneNum;

@end

@implementation KDExpressSendInfoController

-(DKExpressSendInfoHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [DKExpressSendInfoHeaderView expressSendInfoHeaderView];
    }
    return _headerView;
}

-(DKExpressFindTextView *)textfieldHeaderView{
    
    if (!_textfieldHeaderView) {
        _textfieldHeaderView = [DKExpressFindTextView expressFindTextView];
        _textfieldHeaderView.delegate = self;
    }
    return _textfieldHeaderView;
}

-(UIView *)footerView{
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIView *shadowView = [[UIView alloc] init];
        shadowView.backgroundColor = rgb(255, 255, 255, 1.0);
        shadowView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0,3);
        shadowView.layer.shadowOpacity = 0.7;
        shadowView.layer.shadowRadius = 3;
        shadowView.layer.cornerRadius = 12;
        [_footerView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_footerView).offset(0);
            make.left.equalTo(self->_footerView).offset(18);
            make.right.equalTo(self->_footerView).offset(-18);
            make.height.mas_equalTo(24);
        }];
        
        UIView *maskView = [[UIView alloc] init];
        maskView.backgroundColor = [UIColor whiteColor];
        [shadowView addSubview:maskView];
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(shadowView).offset(0);
            make.height.mas_equalTo(12);
        }];
    }
    return _footerView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavibarH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.phoneNum = @"";
    
    [self setNav];
    
    [self createSubViews];
    
    [self getDataFrom];
}


-(void)setNav{
    
    self.backgroungImgView.image = [UIImage imageWithColor:rgb(223, 47, 49, 1)];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(255, 255, 255, 1.0);
    self.titleView.titleLable.text = @"查询结果";
    self.titleView.titleLable.hidden = NO;
}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createSubViews{
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = rgb(250, 248, 248, 1);
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavibarH);
    }];
    
    [contentView addSubview:[self bgView]];
    
    [contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.top.equalTo(contentView).offset(0);
        make.bottom.equalTo(contentView).offset(0);
    }];
}

- (UIView *)bgView{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,0,kScreenWidth,60);
    bgView.backgroundColor = rgb(223, 47, 49, 1.0);
    return bgView;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"cellId";
    DKExpressSendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DKExpressSendInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.row = indexPath.row;
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.Traces.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

#pragma mark -- 请求物流轨迹数据
- (void)getDataFrom{
    
    if (!self.scanString) {
        return;
    }
    
    NSDictionary *params = @{
                             @"code" : self.scanString,
                             @"num" : self.phoneNum
                             };
    NSString *url = kWuliuGuiji;
    if ([self.scanString hasPrefix:@"SF"]) {
        url = kSFWuliu;
    }
        
    
    [SVProgressHUD showWithStatus:@"查询中..."];
    [KDNetWorkManager GetHttpDataWithUrlStr:url Dic:params headDic:nil SuccessBlock:^(id obj) {
        
        [SVProgressHUD dismiss];
        
        if([obj[@"code"] integerValue] == 1){
            
            NSDictionary *dic = obj[@"data"];
            if (dic.count != 0) {
                KDWuliuGuijiModel *model = [KDWuliuGuijiModel mj_objectWithKeyValues:dic];
                model.logistic.logistics_code = self.scanString;
                self.model = model;
                if (self.phoneNum.length == 0 ) {//&& ![self.scanString hasPrefix:@"SF"]
                    self.tableView.tableHeaderView = self.textfieldHeaderView;
                    self.textfieldHeaderView.model = model;
                }else{
                    self.tableView.tableHeaderView = self.headerView;
                    self.headerView.model = model;
                    self.tableView.tableFooterView = self.footerView;
                    [self.tableView reloadData];
                }
            }else{
                NSString *msg = @"未查到物流信息";
                [ZJCustomHud showWithText:msg WithDurations:2.0];
            }
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
}

#pragma mark -- DKExpressFindTextViewDelegate
- (void)searchExpressInfoWithNum:(NSString *)num{
    
    self.phoneNum = num;
    
    [self getDataFrom];
    
}

@end
