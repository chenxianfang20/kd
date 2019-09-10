//
//  KDExpressRecordListController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressRecordListController.h"
#import "KDExpressRecordCell.h"
#import "KDOrderListModel.h"
#import "KDWuliuListModel.h"
#import "KDOrderDetailVC.h"
#import "KDCancellOrderController.h"

@interface KDExpressRecordListController ()< UITableViewDelegate, UITableViewDataSource,KDExpressRecordCellDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)NSInteger page;

@property(nonatomic, strong)NSMutableArray *dataArr;

@property(nonatomic, strong)UIView *noDataView;

@end

@implementation KDExpressRecordListController

#pragma mark - Getters
-(UIView *)noDataView{
    
    if (!_noDataView) {
        
        _noDataView = [[UIView alloc] init];
        _noDataView.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"图标-暂无寄件"];
        [_noDataView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_noDataView.mas_centerX).offset(0);
            make.centerY.equalTo(self->_noDataView.mas_centerY).offset(-100);
            make.size.mas_equalTo(CGSizeMake(180, 180));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.text = @"暂无任何寄件订单呢，去寄件试试看吧～！";
        tipLabel.textColor = rgb(166, 166, 166, 1.0);
        tipLabel.font = PingFangMedium(15);
        [_noDataView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(20);
            make.centerX.equalTo(self->_noDataView.mas_centerX).offset(0);
        }];
    }
    return _noDataView;
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.rowHeight = 207;
        _tableView.backgroundColor = rgb(250, 248, 248, 1.0);
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 12)];
        headerView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 12)];
        footerView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = footerView;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self tableViewRefresh];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [self getDataFromNet];
    
}

//上下拉刷新
- (void)tableViewRefresh{
    
    //下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    
    //上拉
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)downRefresh{
    
    self.page = 1;
    [self getDataFromNet];
}

- (void)upRefresh {
    
    [self getDataFromNet];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellIdentifier = @"KDExpressRecordCell";
    KDExpressRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[KDExpressRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = self.dataArr[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDOrderListModel*  model = self.dataArr[indexPath.row];
    KDOrderDetailVC* detailVC =[[KDOrderDetailVC alloc]init];
    detailVC.model=model;
    // 0 待联系  1 已接单 2 已取件 3 已签收  4 已取消
    detailVC.type=model.status.integerValue;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- KDExpressRecordCellDelegate
-(void)clickDetailButtonWithModel:(KDOrderListModel *)model{
    
    KDOrderDetailVC* detailVC =[[KDOrderDetailVC alloc]init];
    detailVC.model=model;
    // 0 待联系  1 已接单 2 已取件 3 已签收  4 已取消
    detailVC.type=model.status.integerValue;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(void)clickOperateButtonWithModel:(KDOrderListModel *)model{
    
    if (model.status.integerValue == 0) {
        //取消订单
        KDCancellOrderController *vc = [[KDCancellOrderController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (model.status.integerValue == 1 || model.status.integerValue == 2) {
        //再下一单
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (model.status.integerValue == 3) {
        //再下一单
       [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (model.status.integerValue == 4) {
        //重新下单
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)getDataFromNet{
    
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary * dic = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    NSDictionary *params = @{
                             @"status":@(self.status),
                             @"page" : @(self.page),
                             @"limit" : @(10)
                             };
    
    __weak typeof(self) weakSelf =self;
    
    [KDNetWorkManager GetHttpDataWithUrlStr:kOrderList Dic:params headDic:dic SuccessBlock:^(id obj) {
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if([obj[@"code"] integerValue] == 1){
            
            if (weakSelf.page == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            
            NSArray *data = obj[@"data"];
            for (NSDictionary *dic in data) {
                
                KDOrderListModel *model = [KDOrderListModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArr addObject:model];
                
            }
            [self.tableView reloadData];
            
            self.noDataView.hidden = weakSelf.dataArr.count > 0;
            
            self.tableView.mj_footer.hidden = self.dataArr.count < 10;
            
            if (data.count < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                self.page ++;
            }
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        [SVProgressHUD dismiss];
        [ZJCustomHud showWithText:@"网络错误" WithDurations:2.0];
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
