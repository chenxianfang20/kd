//
//  KDExpressSendInfoController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressSendInfoController.h"
#import "DKExpressSendInfoHeaderView.h"

@interface KDExpressSendInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)DKExpressSendInfoHeaderView *headerView;

@end

@implementation KDExpressSendInfoController

-(DKExpressSendInfoHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [DKExpressSendInfoHeaderView expressSendInfoHeaderView];
    }
    return _headerView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, kScreenHeight - NavibarH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
