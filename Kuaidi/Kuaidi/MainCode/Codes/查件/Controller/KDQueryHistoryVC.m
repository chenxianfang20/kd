//
//  KDQueryHistoryVC.m
//  Kuaidi
//
//  Created by cxf on 2019/11/28.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDQueryHistoryVC.h"

@interface KDQueryHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *noticeView;
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property (nonatomic,assign) NSInteger pages;
@end

@implementation KDQueryHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pages= 0;
    [self setNav];
    [self addChildViews];
    [self getQueryHistoryData];
    [self.tableview reloadData];
}

-(void)addChildViews{
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.noticeView];
    
    self.noticeView.hidden = YES;
}
-(void)getQueryHistoryData{
    
    KDUserModel* model = [KDUserModelTool userModel];
    if(model.userId){
        NSDictionary * headdic = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
        
        NSDictionary * param = @{@"user_id":model.userId,@"page":[NSString stringWithFormat:@"%ld",self.pages],@"limit":@"10"};
        __weak typeof(self) weakSelf = self;
        [KDNetWorkManager GetHttpDataWithUrlStr:kKdniaoGethistory Dic:param headDic:headdic SuccessBlock:^(id obj) {
            if(weakSelf.pages == 0){
                [weakSelf.dataSource  removeAllObjects];
            }
            NSArray* arr =obj[@"data"];
            if(arr.count>0){
                for (NSDictionary*dic in arr) {
                    KDCheckHisoryModel*hisModel =   [KDCheckHisoryModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataSource addObject:hisModel];
                }
                weakSelf.pages++;
                self.tableview.mj_footer.state=MJRefreshStateIdle;
            }else{
                weakSelf.tableview.mj_footer.state=MJRefreshStateNoMoreData;
            }
            [weakSelf setupStateRefresh];
            [weakSelf.tableview reloadData];
        } FailureBlock:^(id obj) {
            
        }];
    }
}
-(void)setupStateRefresh{
    self.tableview.mj_footer.hidden=NO;
    if(self.dataSource.count == 0){
        _noticeView.hidden=NO;
    }else{
        _noticeView.hidden=YES;
        
    }
    if(self.dataSource.count < 6){
        self.tableview.mj_footer.hidden = YES;
    }else{
        self.tableview.mj_footer.hidden = NO;
    }
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
    static NSString *cellID = @"KDQueryHistoryCell_ID";
    KDQueryHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KDQueryHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 8, 0, 8)];
    }
    KDCheckHisoryModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  kAdaptationWidth(98);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDCheckHisoryModel*  kCheckHisoryModel = self.dataSource[indexPath.row];
    
    KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isNeedBackToLastFlag = YES;
    vc.scanString = kCheckHisoryModel.delivery_orderno;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView*)noticeView{
    if(!_noticeView){
        _noticeView=[[UIView alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(110), kScreenWidth, kAdaptationWidth(250))];
        UIImageView* bgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kAdaptationWidth(180), kAdaptationWidth(180))];
        bgImgView.image=[UIImage imageNamed:@"图标-暂无积分"];
        [_noticeView addSubview:bgImgView];
        bgImgView.centerX=kScreenWidth/2.0;
        
        UILabel* noNoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgImgView.bottom+kAdaptationWidth(10), kScreenWidth, kAdaptationWidth(25))];
        noNoticeLabel.text=@"暂无查件历史记录";
        noNoticeLabel.font=PingFangBold(13);
        noNoticeLabel.textAlignment=NSTextAlignmentCenter;
        noNoticeLabel.textColor=rgb(136, 136, 136, 1);
        [_noticeView addSubview:noNoticeLabel];
        _noticeView.hidden=YES;
    }
    return _noticeView;
}

/**
 *  懒加载
 */
-(NSMutableArray*)dataSource{
    if(!_dataSource){
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(10,NavibarH+10, kScreenWidth-20, kScreenHeight -NavibarH-20) style:UITableViewStylePlain];
        _tableview.backgroundColor=rgb(255, 255, 255, 1);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = rgb(236, 236, 236, 1);
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
        }
        _tableview.layer.cornerRadius = 8;
        _tableview.layer.masksToBounds = YES;
        _tableview.tableFooterView=[[UIView alloc]init];
        _tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(shanglaRefresh)];
        _tableview.mj_footer.hidden=YES;
        _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xialaRefersh)];
    }
    return _tableview;
}
//上拉刷新
-(void)shanglaRefresh{
    self.pages++;
    [self getQueryHistoryData];
    [self.tableview.mj_footer endRefreshing];
}
//下拉刷新
-(void)xialaRefersh{
    self.pages=0;
    [self getQueryHistoryData];
    [self.tableview.mj_header endRefreshing];
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"查件历史"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}

@end
