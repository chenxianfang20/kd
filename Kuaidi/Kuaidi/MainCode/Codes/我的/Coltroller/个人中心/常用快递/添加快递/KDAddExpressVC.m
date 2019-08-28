//
//  KDAddExpressVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAddExpressVC.h"
#import "KDAddExpressModel.h"
#import "KDAddExpressCell.h"
#import "KDExpressDetailVC.h"
static CGFloat const kSearchBarHeight = 40.f;
@interface KDAddExpressVC()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate> {
    // 所有的indexsTitles
    NSArray *_allIndexTitles;
    // 存放索引对应的下标
    NSMutableArray *_sectionIndexs;
    // dataSource
    NSMutableArray *_data;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray * allData;

@property (nonatomic,strong) KDAddExpressModel * currModel;
@end
@implementation KDAddExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
    
    [self addExpressList];
    
}
-(void)addChildViews{
    [self.view addSubview:self.tableView];
    //self.tableView.tableHeaderView = self.searchBar;
}
- (void)addExpressList {
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* dic = @{@"XX-Token":model.token,@"XX-Device-Type":@"iphone"};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kShowwuliulist Dic:nil headDic:dic SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            NSArray*  resArr = obj[@"data"];
            if(resArr.count>0){
                NSMutableArray* tempArrM= [[NSMutableArray alloc]init];
                for(NSDictionary * modelDic in  resArr){
                    NSArray* listArr=modelDic[@"list"];
                    for (NSDictionary* tempDic in listArr) {
                        KDAddExpressModel* model = [KDAddExpressModel ModelWithDict:tempDic];
                        [tempArrM addObject:model];
                    }
                }
                 [weakSelf setupInitialAllDataArrayWithContacts:tempArrM];
                //[weakSelf.tableview reloadData];
            }
        }
    } FailureBlock:^(id obj) {
    }];
}
// 设置初始的所有数据
- (void)setupInitialAllDataArrayWithContacts:(NSArray *)addExpressList {
    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    // 获得当前语言下的所有的indexTitles
    _allIndexTitles = localIndex.sectionTitles;
    // 初始化所有数据的数组
    _data = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    // 为每一个indexTitle 生成一个可变的数组
    for (int i = 0; i<_allIndexTitles.count; i++) {
        // 初始化数组
        [_data addObject:[NSMutableArray array]];
    }
    // 初始化有效的sectionIndexs
    _sectionIndexs = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    for (KDAddExpressModel *model in addExpressList) {
        if (model == nil) continue;
        
        // 获取到这个contact的name的首字母对应的indexTitle
        // 注意这里必须使用对象, 这个selector也是有要求的
        // 必须是这个对象中的selector, 并且不能有参数, 必须返回字符串
        // 所以这里直接使用 name 属性的get方法就可以
        NSInteger index = [localIndex sectionForObject:model collationStringSelector:nameSelector];
        
        // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
//        if ([model.name hasPrefix:@"曾"]) {
//            index = [_allIndexTitles indexOfObject:@"Z"];
//        }
        // 将这个contact添加到对应indexTitle的数组中去
        [_data[index] addObject:model];
    }
    
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [_sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
    [self.tableView reloadData];
}
// 增加联系人
- (void)addExpress:(KDAddExpressModel *)model {
    if (model == nil) return;
    
    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    NSInteger index = [localIndex sectionForObject:model collationStringSelector:nameSelector];
    
    // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
    if ([model.name hasPrefix:@"曾"]) {
        index = [_allIndexTitles indexOfObject:@"Z"];
    }
    // 将这个contact添加到对应indexTitle的数组中去
    NSMutableArray *tempContacts = [_data[index] mutableCopy];
    [tempContacts addObject:model];
    _data[index] = tempContacts;
    // 移除原来的, 便于重新添加
    [_sectionIndexs removeAllObjects];
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [_sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionIndexs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = [_sectionIndexs[section] integerValue];
    NSArray *temp = _data[index];
    return temp.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellId = @"KDAddExpressCell_ID";
    KDAddExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[KDAddExpressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
    NSArray *temp = _data[index];
    KDAddExpressModel *model = (KDAddExpressModel *)temp[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    cell.favitBtnBlock=^{
        [weakSelf favitorSet:model  with:indexPath];
    };
    return cell;
}

-(void)favitorSet:(KDAddExpressModel *)model  with:(NSIndexPath *)indexPath{
    
    NSString* url;
    if(model.heart.integerValue == 0 ){
        url=kAddmywuliu;
    }else if (model.heart.integerValue == 1){
        url=kDelmywuliu;
    }
    __weak typeof(self) weakSelf = self;
    KDUserModel* userModel = [KDUserModelTool userModel];
    NSDictionary* headData=@{@"XX-Token":userModel.token,@"XX-Device-Type":kDeviceType};
    NSDictionary* dic=@{@"id":model.model_ID};
    [KDNetWorkManager GetHttpDataWithUrlStr:url Dic:dic headDic:headData SuccessBlock:^(id obj) {
    if([obj[@"code"] integerValue] == 1){
        weakSelf.currModel = model;
        if(model.heart.integerValue == 0 ){
            weakSelf.currModel.heart=@"1";
        }else if (model.heart.integerValue == 1){
            weakSelf.currModel.heart=@"0";
        }
    }
    [weakSelf.tableView reloadData];
    //[weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
} FailureBlock:^(id obj) {
    
}];
}


// sectionHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger index = [_sectionIndexs[section] integerValue];
    return _allIndexTitles[index];
}

// 这个方法是返回索引的数组, 我们需要根据之前获取到的两个数组来取到我们需要的
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:_sectionIndexs.count];
    // 遍历索引的下标数组, 然后根据下标取出_allIndexTitles对应的索引字符串
    for (NSNumber *number in _sectionIndexs) {
        NSInteger index = number.integerValue;
        [indexTitles addObject:_allIndexTitles[index]];
    }
    return indexTitles;
}
// 可以相应点击的某个索引, 也可以为索引指定其对应的特定的section, 默认是 section == index
// 返回点击索引列表上的索引时tableView应该滚动到那一个section去
// 这里我们的tableView的section和索引的个数相同, 所以直接返回索引的index即可
// 如果不相同, 则需要自己相应的返回自己需要的section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSLog(@"%@---%ld", title, index);
    // 显示正在点击的indexTitle ZJProgressHUD这个小框架是我们已经实现的
    //[ZJProgressHUD showStatus:title andAutoHideAfterTime:0.5];
    return index;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
    NSArray *temp = _data[index];
    KDAddExpressModel *model = (KDAddExpressModel *)temp[indexPath.row];
    KDExpressDetailVC* vc = [[KDExpressDetailVC alloc]init];
    vc.model =model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAdaptationWidth(68);
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (searchBar == self.searchBar) {
        [self presentViewController:self.searchController animated:YES completion:nil];
        return NO;
    }
    return YES;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar == _searchController.searchBar) {
//        ZJSearchResultController *resultController = (ZJSearchResultController *)_searchController.searchResultsController;
//        // 更新数据 并且刷新数据
//        resultController.data = [ZJContact searchText:searchText inDataArray:self.allData];
    }
}

// 这个方法在searchController 出现, 消失, 以及searchBar的text改变的时候都会被调用
// 我们只是需要在searchBar的text改变的时候才查询数据, 所以没有使用这个代理方法, 而是使用了searchBar的代理方法来处理
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //    NSLog(@"%@", searchController.searchBar.text);
    //    ZJSearchResultController *resultController = (ZJSearchResultController *)searchController.searchResultsController;
    //    resultController.data = [ZJContact searchText:searchController.searchBar.text inDataArray:_allData];
    //    [resultController.tableView reloadData];
    
}

// 这个代理方法在searchController消失的时候调用, 这里我们只是移除了searchController, 当然你可以进行其他的操作
- (void)didDismissSearchController:(UISearchController *)searchController {
    // 销毁
    self.searchController = nil;
}
- (UISearchController *)searchController {
    if (!_searchController) {
//        // ios8+才可用 否则使用 UISearchDisplayController
//        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:[ZJSearchResultController new]];
//        searchController.delegate = self;
//        //        searchController.searchResultsUpdater = self;
//        searchController.searchBar.delegate = self;
//        searchController.searchBar.placeholder = @"搜索";
//        _searchController = searchController;
    }
    return _searchController;
}

-(NSMutableArray* )allData {
    if(!_allData){
        _allData = [[NSMutableArray alloc]init];
        for (NSArray *resModelArr in _data) {// 获取所有的contact
            if (resModelArr.count != 0) {
                for (KDAddExpressModel *model in resModelArr) {
                    [_allData addObject:model];
                }
            }
        }
    }
    return _allData;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, kSearchBarHeight)];
        searchBar.delegate = self;
        searchBar.placeholder = @"搜索";
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight-NavibarH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        // 行高度
        tableView.rowHeight = 44.f;
        // sectionHeader 的高度
        tableView.sectionHeaderHeight = 28.f;
        // sectionIndexBar上的文字的颜色
        tableView.sectionIndexColor = [UIColor lightGrayColor];
        // 普通状态的sectionIndexBar的背景颜色
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        // 选中sectionIndexBar的时候的背景颜色
        //        tableView.sectionIndexTrackingBackgroundColor = [UIColor yellowColor];
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"增加快递"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
