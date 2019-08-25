//
//  KDExpressVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDExpressVC.h"
#import "KDExpressCell.h"
#import "KDExpressModel.h"
#import "KDAddExpressVC.h"
@interface KDExpressVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic,strong) UIView *noticeView;

@end
@implementation KDExpressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}


-(void)addChildViews{
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.noticeView];
    
    //底部新增快递按钮
    UIView* addMailingBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    addMailingBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:addMailingBgView];
    
    //新增地址
    UIButton*  addMailingBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [addMailingBtn setTitle:@"添加快递" forState:UIControlStateNormal];
    [addMailingBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [addMailingBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    addMailingBtn.layer.cornerRadius=kAdaptationWidth(10);
    addMailingBtn.layer.masksToBounds=YES;
    [addMailingBtn addTarget:self action:@selector(addMailingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addMailingBgView addSubview:addMailingBtn];
    
    
    

}
#pragma mark- tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"KDExpressCell_ID";
    KDExpressCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];;
    if (!cell) {
        cell = [[KDExpressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    KDExpressModel* model=self.dataSource[indexPath.row];
    cell.model=model;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAdaptationWidth(102);
}
//新增快递
-(void)addMailingBtnClick{
    
    KDAddExpressVC* vc= [[KDAddExpressVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getWuLiuList{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* dic = @{@"XX-Token":model.token,@"XX-Device-Type":@"iphone"};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kShowmywuliu Dic:nil headDic:dic SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            if(weakSelf.dataSource.count>0){
                [weakSelf.dataSource removeAllObjects];
            }
            NSArray*  resArr = obj[@"data"];
            if(resArr.count>0){
                for(NSDictionary * modelDic in  resArr){
                    KDExpressModel* model = [KDExpressModel ModelWithDict:modelDic];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getWuLiuList];
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,NavibarH, kScreenWidth, kScreenHeight -NavibarH-kAdaptationWidth(90)) style:UITableViewStylePlain];
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
-(UIView*)noticeView{
    if(!_noticeView){
        _noticeView=[[UIView alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(110), kScreenWidth, kAdaptationWidth(250))];
        UIImageView* bgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kAdaptationWidth(180), kAdaptationWidth(180))];
        bgImgView.image=[UIImage imageNamed:@"图标-暂无快递"];
        [_noticeView addSubview:bgImgView];
        bgImgView.centerX=kScreenWidth/2.0;
        
        UILabel* noNoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgImgView.bottom+kAdaptationWidth(10), kScreenWidth, kAdaptationWidth(25))];
        noNoticeLabel.text=@"暂无任何常用快递呢，去添加试试看吧～！";
        noNoticeLabel.font=PingFangBold(13);
        noNoticeLabel.textAlignment=NSTextAlignmentCenter;
        noNoticeLabel.textColor=rgb(136, 136, 136, 1);
        [_noticeView addSubview:noNoticeLabel];
        _noticeView.hidden=YES;
    }
    return _noticeView;
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"常用快递"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
