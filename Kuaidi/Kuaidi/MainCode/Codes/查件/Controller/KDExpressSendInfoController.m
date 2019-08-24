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

@interface KDExpressSendInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)DKExpressSendInfoHeaderView *headerView;

@property(nonatomic, strong)UIView *footerView;

@end

@implementation KDExpressSendInfoController

-(DKExpressSendInfoHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [DKExpressSendInfoHeaderView expressSendInfoHeaderView];
    }
    return _headerView;
}

-(UIView *)footerView{
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 24)];
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
            make.top.bottom.equalTo(self->_footerView).offset(0);
            make.left.equalTo(self->_footerView).offset(18);
            make.right.equalTo(self->_footerView).offset(-18);
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
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self createSubViews];
}


-(void)setNav{
    
    self.backgroungImgView.image = [UIImage imageWithColor:rgb(223, 47, 49, 1)];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(255, 255, 255, 1.0);
    self.titleView.titleLable.text = @"查询结果";
    self.titleView.titleLable.hidden = NO;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

@end
