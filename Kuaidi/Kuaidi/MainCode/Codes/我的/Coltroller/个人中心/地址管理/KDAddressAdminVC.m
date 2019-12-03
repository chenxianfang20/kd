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
#import "KDNewAddressVC.h"
@interface KDAddressAdminVC()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataSource;
@property (nonatomic,strong) UIView *noticeView;

@end
@implementation KDAddressAdminVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
    
    [self getAddressList];
}


-(void)addChildViews{
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.noticeView];
    
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
    __weak typeof(self)weakSelf = self;
    //编辑
    cell.editBtnBlock=^{
        
        [weakSelf editAddress:model];
    };
    //删除
    cell.deleteBtnBlock=^{
        [weakSelf deleteAddressWithID:model];
    };
    //设置为默认地址
    cell.defaultBtnBlock=^{
        [weakSelf defaultAddressWithID:model];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectAddressBlock) {
        KDAddressAdminModel* model=self.dataSource[indexPath.row];
        self.selectAddressBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAdaptationWidth(168);
}
//新增地址
-(void)addressBtnClick{
    KDNewAddressVC *vc=[[KDNewAddressVC alloc]init];
    __weak typeof(self) weakSelf = self;
    vc.myBlock=^{
        if(weakSelf.dataSource.count>0){
            [weakSelf.dataSource removeAllObjects];
        }
        [weakSelf getAddressList];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//
-(void)deleteAddressWithID:(KDAddressAdminModel*) addressAdminModel{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    NSDictionary* dic = @{@"id":addressAdminModel.addressID};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kDeleteAddress Dic:dic headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            [weakSelf.dataSource removeObject:addressAdminModel];
            [weakSelf.tableview reloadData];
            [ZJCustomHud showWithSuccess:@"删除成功"];
            if(weakSelf.dataSource.count == 0){
                weakSelf.noticeView.hidden=NO;
            }else{
                weakSelf.noticeView.hidden=YES;
            }
        }
    } FailureBlock:^(id obj) {
        
    }];
}
-(void)editAddress:(KDAddressAdminModel*) addressAdminModel{
    KDNewAddressVC *vc=[[KDNewAddressVC alloc]init];
    vc.addressModel=addressAdminModel;
    //[vc getAddressModel:addressAdminModel andTitle:@"编辑地址"];
    __weak typeof(self) weakSelf = self;
    vc.myBlock=^{
        if(weakSelf.dataSource.count>0){
            [weakSelf.dataSource removeAllObjects];
        }
        [weakSelf getAddressList];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)defaultAddressWithID:(KDAddressAdminModel*) addressAdminModel{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    NSDictionary* dic = @{@"id":addressAdminModel.addressID};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kSetDefaultAddress Dic:dic headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            [weakSelf.dataSource removeAllObjects];
            [weakSelf getAddressList];
            [weakSelf.view  showToastWithText:@"设置为默认地址" time:1];
        }
    } FailureBlock:^(id obj) {
        
    }];
}

-(void)getAddressList{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* dic = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    __weak typeof(self) weakSelf =self;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [KDNetWorkManager GetHttpDataWithUrlStr:kAddressList Dic:nil headDic:dic SuccessBlock:^(id obj) {
        [SVProgressHUD dismiss];
        if([obj[@"code"] integerValue] == 1){
            NSArray*  resArr = obj[@"data"];
            if(resArr.count>0){
                for(NSDictionary * modelDic in  resArr){
                    KDAddressAdminModel* model = [KDAddressAdminModel ModelWithDict:modelDic];
                    [weakSelf.dataSource addObject:model];
                }
                [weakSelf.tableview reloadData];
            }
            if(weakSelf.dataSource.count == 0){
                weakSelf.noticeView.hidden=NO;
            }else{
                weakSelf.noticeView.hidden=YES;
            }
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
-(UIView*)noticeView{
    if(!_noticeView){
        _noticeView=[[UIView alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(110), kScreenWidth, kAdaptationWidth(250))];
        UIImageView* bgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kAdaptationWidth(180), kAdaptationWidth(180))];
        bgImgView.image=[UIImage imageNamed:@"图标-没有地址"];
        [_noticeView addSubview:bgImgView];
        bgImgView.centerX=kScreenWidth/2.0;
        
        UILabel* noNoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgImgView.bottom+kAdaptationWidth(10), kScreenWidth, kAdaptationWidth(25))];
        noNoticeLabel.text=@"还没有添加过地址，点击新增地址添加吧～！";
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
    [self.titleView setTitle:@"地址管理"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}
@end
