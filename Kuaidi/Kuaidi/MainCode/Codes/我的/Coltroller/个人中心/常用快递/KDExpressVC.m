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
@interface KDExpressVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;

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
    
    
    [self getWuLiuList];
//    //临时数据
//    KDExpressModel* model = [[KDExpressModel alloc]init];
//    model.mailingName=@"顺风快递";
//    model.phone=@"4008-890-008";
//    model.headImgDddress=@"我的-图标-顺丰";
//    [self.dataSource addObject:model];
//    [self.dataSource addObject:model];
//    [self.tableview reloadData];
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
//新增地址
-(void)addMailingBtnClick{
    
}

-(void)getWuLiuList{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* dic = @{@"XX-Token":model.token,@"XX-Device-Type":@"iphone"};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kWuLiu Dic:nil headDic:dic SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
//            NSArray*  resArr = obj[@"data"];
//            if(resArr.count>0){
//                for(NSDictionary * modelDic in  resArr){
//                    KDAddressAdminModel* model = [KDAddressAdminModel ModelWithDict:modelDic];
//                    [weakSelf.dataSource addObject:model];
//                }
//                [weakSelf.tableview reloadData];
//            }
        }
    } FailureBlock:^(id obj) {
        
    }];
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
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"常用快递"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
