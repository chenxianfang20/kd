//
//  KDAddressAdminVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAddressAdminVC.h"
#import "KDAddressAdminCell.h"
#import "KDAddressAdminModel.h"
@interface KDAddressAdminVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;
@end
@implementation KDAddressAdminVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
}


-(void)addChildViews{
    [self.view addSubview:self.tableview];
    
    //底部新增地址按钮
    UIView* addressBgView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kAdaptationWidth(90), kScreenWidth, kAdaptationWidth(90))];
    addressBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:addressBgView];
    
    //新增地址
    UIButton*  addressBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(339), kAdaptationWidth(54))];
    [addressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addressBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [addressBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    addressBtn.layer.cornerRadius=kAdaptationWidth(10);
    addressBtn.layer.masksToBounds=YES;
    [addressBtn addTarget:self action:@selector(addressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addressBgView addSubview:addressBtn];
    
    
    //临时数据
    KDAddressAdminModel* model = [[KDAddressAdminModel alloc]init];
    model.name=@"刘德华";
    model.phone=@"150 1358 1358";
    model.address=@"广东省 深圳市 龙岗区横岗街道大运软件小镇大运 软件小镇01栋";
    [self.dataSource addObject:model];
    [self.dataSource addObject:model];
    [self.tableview reloadData];
    
}
#pragma mark- tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"KDAddressAdminCell_ID";
    KDAddressAdminCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];;
    if (!cell) {
        cell = [[KDAddressAdminCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    KDAddressAdminModel* model=self.dataSource[indexPath.row];
    cell.model=model;
    
    //编辑
    cell.editBtnBlock=^{
        
    };
    //删除
    cell.deleteBtnBlock=^{
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAdaptationWidth(168);
}
//新增地址
-(void)addressBtnClick{
    
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
    [self.titleView setTitle:@"地址管理"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
