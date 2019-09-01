//
//  KDScoreVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDScoreVC.h"
#import "KDScoreCell.h"
#import "KDScoreModel.h"
@interface KDScoreVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *noticeView;
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;
@end

@implementation KDScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self addChildViews];
    [self getScoreData];
    
//    KDScoreModel* model = [[KDScoreModel alloc]init];
//    model.titleStr=@"礼品-幸运摇奖机";
//    model.timeStr=@"2019/07/26 00:00";
//    model.score=@"+129";
//
//    [self.dataSource addObject:model];
//    [self.dataSource addObject:model];
//    [self.dataSource addObject:model];
//    [self.dataSource addObject:model];
//    [self.dataSource addObject:model];
    
//    [self.tableview reloadData];
}
-(void)addChildViews{
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.noticeView];
    
    self.noticeView.hidden = NO;
}
-(void)getScoreData{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kScoreIndex Dic:nil headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            if(weakSelf.dataSource.count>0){
                [weakSelf.dataSource removeAllObjects];
            }
            NSArray*  resArr = obj[@"data"];
            if(resArr.count>0){
                for(NSDictionary * modelDic in  resArr){
                    KDScoreModel* model = [KDScoreModel ModelWithDict:modelDic];
                    [weakSelf.dataSource addObject:model];
                }
            }
            [weakSelf.tableview reloadData];
            if(weakSelf.dataSource.count == 0){
                weakSelf.noticeView.hidden=NO;
            }else{
                weakSelf.noticeView.hidden=YES;
            }
        }
    } FailureBlock:^(id obj) {
        
    }];
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
    static NSString *cellID = @"KDScoreCell_ID";
    KDScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KDScoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    KDScoreModel* model = self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  kAdaptationWidth(96);
}
-(UIView*)noticeView{
    if(!_noticeView){
        _noticeView=[[UIView alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(110), kScreenWidth, kAdaptationWidth(250))];
        UIImageView* bgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kAdaptationWidth(180), kAdaptationWidth(180))];
        bgImgView.image=[UIImage imageNamed:@"图标-暂无积分"];
        [_noticeView addSubview:bgImgView];
        bgImgView.centerX=kScreenWidth/2.0;
        
        UILabel* noNoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgImgView.bottom+kAdaptationWidth(10), kScreenWidth, kAdaptationWidth(25))];
        noNoticeLabel.text=@"暂无积分记录";
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,NavibarH, kScreenWidth, kScreenHeight -NavibarH) style:UITableViewStylePlain];
        _tableview.backgroundColor=rgb(245, 245, 245, 1);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11){
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
        }
    }
    return _tableview;
}

-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"积分明细"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}

@end
