//
//  HCTNavigationController.m
//  mphoneLot
//
//  Created by ios01 on 2019/6/19.
//  Copyright © 2019年 ios01. All rights reserved.
//  自定义 NavigationController 

#import "HCTNavigationController.h"
#import "Settings.h"
//#import "HCTHttpsForZSTVC.h"
//#import "HCTHallVC.h"
@interface HCTNavigationController ()

@end

@implementation HCTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self,nil];
    
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    UIImage* img=[UIImage imageNamed:@"ding"];//[UIImage imageWithColor:kTopColor]
    // 设置导航条背景图片
    [navBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

@end

