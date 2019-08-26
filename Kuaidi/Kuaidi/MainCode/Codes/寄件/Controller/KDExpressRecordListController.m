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

@interface KDExpressRecordListController ()< UITableViewDelegate, UITableViewDataSource>

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
            
            self.noDataView.hidden = weakSelf.dataArr.count > 0;
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        
    }];
    
}

@end
