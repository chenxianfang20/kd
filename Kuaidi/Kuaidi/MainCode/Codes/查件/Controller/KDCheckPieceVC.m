//
//  KDCheckPieceVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDCheckPieceVC.h"
#import "DKScanView.h"
#import "KDExpressSendInfoController.h"
#import "KDScanQRViewController.h"
#import "KDCheckHistoryView.h"
#import "KDCheckHisoryModel.h"

@interface KDCheckPieceVC ()<DKScanViewDelegate>

@property(nonatomic, strong)DKScanView *scanView;



@property (nonatomic,strong) UIView *checkHistoryView;
@property (nonatomic,strong) UIButton *checkMoreBtn;

@property (nonatomic,strong) NSMutableArray *queryHistoryArrM;
@end

@implementation KDCheckPieceVC

-(DKScanView *)scanView{
    
    if (!_scanView) {
        _scanView = [DKScanView scanView];
        _scanView.delegate = self;
    }
    return _scanView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self createSubViews];
}

-(void)setNav{
    
    self.backgroungImgView.image = [UIImage imageWithColor:rgb(223, 47, 49, 1)];
    self.backButton.hidden = YES;
    
}

- (void)createSubViews{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,NavibarH, kScreenWidth, kScreenRealHeight)];
    contentView.backgroundColor = rgb(250, 248, 248, 1);
    [self.view addSubview:contentView];
    
    [contentView addSubview:[self bgView]];
    
    [contentView addSubview:self.scanView];
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(18);
        make.right.equalTo(contentView).offset(-18);
        make.top.equalTo(contentView).offset(0);
        make.height.mas_equalTo(156);
    }];
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.view addSubview:self.checkHistoryView];
    [self getQueryHistoryData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.checkHistoryView removeFromSuperview];
    self.checkHistoryView = nil;
    [self.queryHistoryArrM removeAllObjects];
}

-(void)getQueryHistoryData{
    
    KDUserModel* model = [KDUserModelTool userModel];
    if(model.userId){
        NSDictionary * headdic = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
        
        NSDictionary * param = @{@"user_id":model.userId,@"page":@"0",@"limit":@"10"};
        __weak typeof(self) weakSelf = self;
        [KDNetWorkManager GetHttpDataWithUrlStr:kKdniaoGethistory Dic:param headDic:headdic SuccessBlock:^(id obj) {
            
            for (NSDictionary*dic in obj[@"data"]) {
                KDCheckHisoryModel*hisModel =   [KDCheckHisoryModel mj_objectWithKeyValues:dic];
                [weakSelf.queryHistoryArrM addObject:hisModel];
                
            }
          
            dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf updateCheckHistoryView];
            });
           
        } FailureBlock:^(id obj) {
            
        }];
    }
    
   
}


-(void)updateCheckHistoryView{
    
     __weak typeof(self) weakSelf = self;
    
    NSInteger count = weakSelf.queryHistoryArrM.count>=3?3:weakSelf.queryHistoryArrM.count;
    for(NSInteger i =0;i<count ;i++){
        KDCheckHistoryView* v = [[KDCheckHistoryView alloc]initWithFrame:CGRectMake(0, 36+i*kAdaptationWidth(96), self.checkHistoryView.width, kAdaptationWidth(96) )];
        KDCheckHisoryModel*  model = weakSelf.queryHistoryArrM[i];

        v.model = model;
        [self.checkHistoryView addSubview:v];
        
        v.clickBlock = ^(KDCheckHisoryModel* kCheckHisoryModel){
            KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.scanString = kCheckHisoryModel.delivery_orderno;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        
    }
    if(weakSelf.queryHistoryArrM.count == 0){
         [_checkMoreBtn setTitle:@"暂无查件历史" forState:UIControlStateNormal];
    }
    self.checkHistoryView.height = self.checkHistoryView.height + count *90+5;
    self.checkMoreBtn.bottom = self.checkHistoryView.height;
    [self.checkMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.checkMoreBtn.imageView.bounds.size.width*1.1, 0, self.checkMoreBtn.imageView.bounds.size.width)];
    [self.checkMoreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.checkMoreBtn.titleLabel.bounds.size.width*1.1, 0, -self.checkMoreBtn.titleLabel.bounds.size.width)];
    
}
- (UIView *)bgView{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,0,kScreenWidth,180);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = bgView.frame;
    gl.startPoint = CGPointMake(0, 1);
    gl.endPoint = CGPointMake(0, 0);
    gl.colors = @[(__bridge id)rgb(250, 248, 248, 1.0).CGColor,(__bridge id)rgb(223, 47, 49, 1.0).CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [bgView.layer addSublayer:gl];
    return bgView;
}
-(UIView*)checkHistoryView{
    if(!_checkHistoryView){
        _checkHistoryView = [[UIView alloc]initWithFrame:CGRectMake(18, NavibarH+165, kScreenWidth-36, 120)];
        _checkHistoryView.layer.cornerRadius = 10;
        _checkHistoryView.layer.masksToBounds= YES;
        _checkHistoryView.backgroundColor = [UIColor whiteColor];
        
        //查询历史
        UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,8, 200, 30)];
        titleLabel.text=@"查询历史";
        titleLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
        titleLabel.font =PingFangBold(15);
        [_checkHistoryView addSubview:titleLabel];
        
        UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+8, _checkHistoryView.width, 2)];
        sepLabel.backgroundColor=[UIColor colorWithHex:@"#F1F1F1"];
        [_checkHistoryView addSubview:sepLabel];
        
        self.checkMoreBtn.frame = CGRectMake(0, sepLabel.bottom+5, _checkHistoryView.width, 40);
        [_checkHistoryView addSubview:self.checkMoreBtn];
        
        _checkHistoryView.height = self.checkMoreBtn.bottom;
    }
    return _checkHistoryView;
}

-(UIButton*)checkMoreBtn{
    if(!_checkMoreBtn){
        _checkMoreBtn=[[UIButton alloc]init];
        _checkMoreBtn.titleLabel.font = PingFangRegular(14);
        [_checkMoreBtn setTitleColor:[UIColor colorWithHex:@"#5C5C5C"] forState:UIControlStateNormal];
        [_checkMoreBtn setTitle:@"查看更多查件历史" forState:UIControlStateNormal];
        [_checkMoreBtn addTarget:self action:@selector(checkMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _checkMoreBtn;
}
//点击查询历史
-(void)checkMoreBtnClick{
    KDQueryHistoryVC* vc = [[KDQueryHistoryVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- DKScanViewDelegate
-(void)clickLookUpButton{
    
    if (self.scanView.textField.text.length == 0) {
        [ZJCustomHud showWithText:@"请输入快递单号" WithDurations:2.0];
        return;
    }
    
    KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.scanString = self.scanView.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)clickScanQrCodeButton{
    
    KDScanQRViewController *vc = [[KDScanQRViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}
-(NSMutableArray*)queryHistoryArrM{
    if(!_queryHistoryArrM){
        _queryHistoryArrM = [[NSMutableArray alloc]init];
    }
    return _queryHistoryArrM;
}
@end
