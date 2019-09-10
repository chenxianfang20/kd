//
//  KDCancellOrderController.m
//  Kuaidi
//
//  Created by ljp on 2019/9/8.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDCancellOrderController.h"

@interface KDCancellOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIScrollView *contentView;

@property(nonatomic, strong)UIView *headerView;

@property(nonatomic, strong)UIView *desView;

@property(nonatomic, strong)NSMutableArray *buttonArr;

@property(nonatomic, strong)NSArray *titleArr;

@property(nonatomic, assign)NSInteger index;

@end

@implementation KDCancellOrderController

-(NSMutableArray *)buttonArr{
    
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

-(NSArray *)titleArr{
    
    if (!_titleArr) {
        _titleArr = @[@"已有合作快递员",
                      @"需要指定快递公司",
                      @"费用太贵了",
                      @"需求有变，暂时不需要寄件",
                      @"填写错了/重复下单",
                      @"其他"];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(250, 248, 248, 1.0);
    
    [self setNav];
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view).offset(0);
    }];
    
    [self.contentView addSubview:self.headerView];
    
    [self.contentView addSubview:self.desView];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(18, self.desView.bottom + 129, self.view.width - 36, 54);
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = rgb(223, 47, 49, 1.0);
    commitButton.layer.cornerRadius = 12;
    [self.contentView addSubview:commitButton];
    [commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView.contentSize = CGSizeMake(self.view.width, commitButton.bottom);
}

-(void)setNav{
    
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(11, 11, 11, 1.0);
    self.titleView.titleLable.text = @"取消订单";
    self.titleView.titleLable.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark -- lazy
- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

-(UIView *)headerView{
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(18, 18, self.view.width - 36, 114)];
        _headerView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
        _headerView.layer.shadowOffset = CGSizeMake(0,0);
        _headerView.layer.shadowOpacity = 1;
        _headerView.layer.shadowRadius = 24;
        _headerView.layer.cornerRadius = 12;
        _headerView.backgroundColor = rgb(255, 255, 255, 1.0);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"您确定要取消本次订单吗？";
        titleLabel.textColor = rgb(11, 11, 11, 1.0);
        titleLabel.font = PingFangBold(18);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_headerView).offset(36);
            make.centerX.equalTo(self->_headerView).offset(0);
            make.height.mas_equalTo(17);
        }];
        
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.text = @"请告知我们取消的原因";
        subLabel.textColor = rgb(92, 92, 92, 1.0);
        subLabel.font = PingFangBold(14);
        subLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:subLabel];
        [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(11);
            make.centerX.equalTo(self->_headerView).offset(0);
            make.height.mas_equalTo(13);
        }];
    }
    return _headerView;
}

-(UIView *)desView{
    
    if (!_desView) {
        _desView = [[UIView alloc] initWithFrame:CGRectMake(18, self.headerView.bottom + 10, self.view.width - 36, 270)];
        _desView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
        _desView.layer.shadowOffset = CGSizeMake(0,0);
        _desView.layer.shadowOpacity = 1;
        _desView.layer.shadowRadius = 24;
        _desView.layer.cornerRadius = 12;
        _desView.backgroundColor = rgb(255, 255, 255, 1.0);
        
        for (NSInteger i = 0; i < self.titleArr.count; i ++) {
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = self.titleArr[i];
            titleLabel.textColor = rgb(92, 92, 92, 1.0);
            titleLabel.font = PingFangMedium(14);
            [_desView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self->_desView).offset(19);
                make.top.equalTo(self->_desView).offset(24 + (29 + 13) * i);
                make.height.mas_equalTo(13);
            }];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateSelected];
            button.selected = (i == 0);
            [_desView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(titleLabel.mas_centerY).offset(0);
                make.right.equalTo(self->_desView).offset(-18);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            [self.buttonArr addObject:button];
            
            self.index = 0;
            button.tag = i;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    return _desView;
}

- (void)buttonClick:(UIButton *)button{
    
    for (UIButton *button in self.buttonArr) {
        button.selected = NO;
    }
    button.selected = YES;
    self.index = button.tag;
}

- (void)commitButtonClick:(UIButton *)button{
    
    NSDictionary *params = @{
                             @"ordercode" : self.model.pay_orderno,
                             @"shipcode" : self.model.delivery_code,
                             @"user_remark" : self.titleArr[self.index]
                             };
    
    [KDNetWorkManager GetHttpDataWithUrlStr:kCancellOrder Dic:params headDic:nil SuccessBlock:^(id obj) {
        
        [SVProgressHUD dismiss];
        
        if([obj[@"code"] integerValue] == 1){
            
            if ([obj[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                NSNumber *ResultCode = obj[@"data"][@"ResultCode"];
                
                if (ResultCode.integerValue == 100) {
                    [ZJCustomHud showWithText:@"取消订单成功" WithDurations:2.0];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    NSString *Reason = @"取消订单失败";//obj[@"data"][@"Reason"];
                    [ZJCustomHud showWithText:Reason WithDurations:2.0];
                }
                
            }else{
                
               [ZJCustomHud showWithText:@"返回数据错误" WithDurations:2.0];
            }
            
        }else{
            
            NSString *msg = obj[@"msg"];
            [ZJCustomHud showWithText:msg WithDurations:2.0];
        }
        
    } FailureBlock:^(id obj) {
        [SVProgressHUD dismiss];
        [ZJCustomHud showWithText:@"网络错误" WithDurations:2.0];
    }];
}

@end
