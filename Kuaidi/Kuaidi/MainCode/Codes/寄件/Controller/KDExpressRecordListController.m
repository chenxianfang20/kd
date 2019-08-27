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
@interface KDExpressRecordListController ()< UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)NSInteger page;

@property(nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation KDExpressRecordListController

#pragma mark - Getters

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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDOrderDetailVC* detailVC =[[KDOrderDetailVC alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
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
        if([obj[@"code"] integerValue] == 1){
            
            NSArray *data = obj[@"data"];
            for (NSDictionary *dic in data) {
                
                KDOrderListModel *model = [KDOrderListModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArr addObject:model];
                
            }
        
            [self.tableView reloadData];
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
    
}

@end
