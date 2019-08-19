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

@interface KDCheckPieceVC ()<DKScanViewDelegate>

@property(nonatomic, strong)DKScanView *scanView;

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

#pragma mark -- DKScanViewDelegate
-(void)clickLookUpButton{
    
    KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)clickScanQrCodeButton{
    
    KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
