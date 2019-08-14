
//
//  RootViewController.m
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/4/20.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = rgb(245, 245, 245, 1);
    self.titleView.type = TitleViewType_title;
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.navigationController.navigationBar.hidden = YES;
    
    if (!_nav) {
        _nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavibarH)];
        _nav.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_nav];
    }
    
    
    //背景图片
    if (!self.backgroungImgView) {
        self.backgroungImgView = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        self.backgroungImgView.frame = CGRectMake(0, 0, kScreenWidth, NavibarH);
        [_nav addSubview:self.backgroungImgView ];
    }
    
    
    //返回按钮
    if (_backButton == nil) {
        
        _backButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"图标-后退"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton.frame=CGRectMake(0 , NavibarH - 44, 50, 44);
        [_nav addSubview:_backButton];
    }
    
    if (_rightBtn == nil) {
        
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(kScreenWidth-50-5, NavibarH - 44, 50, 44);
        [_rightBtn setImage:[UIImage imageNamed:@"更多1"] forState:UIControlStateNormal];
        [self.nav addSubview:_rightBtn];
        _rightBtn.titleLabel.font = kAdaptationFont(8);
        [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _rightBtn.hidden = YES;
    
    //标题可能是文字
    if (!_titleView) {
        _titleView = [HCTTitleView titleView];
        [_nav addSubview:_titleView];
    }
    
}


/**
 *  返回
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  右侧第一个按钮点击事件
 */
-(void)rightClick:(UIButton*)button
{
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}

- (void)dealloc {
    NSLog(@"+++++dealloc+++++%@",NSStringFromClass([self class]));
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end


