//
//  HCTTabbarController.m
//  mphoneLot
//
//  Created by ios01 on 2019/6/19.
//  Copyright © 2019年 ios01. All rights reserved.
//  自定义 UITabBarController 作为root

#import "HCTTabbarController.h"
#import "KDMailingVC.h"
#import "KDCheckPieceVC.h"
#import "KDMineVC.h"
#import "HCTNavigationController.h"
#import "UIImage+Image.h"

@interface HCTTabbarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong)UIViewController *currectVC; //当前正在显示的控制器
@end

@implementation HCTTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置透明
    self.tabBar.translucent = NO;
    
    //添加子控制器
    [self addChildViewController];
    
    self.delegate = self;

}


+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrsNor[NSForegroundColorAttributeName]=rgb(178, 178, 178, 1);
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
    //item.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    item.titlePositionAdjustment=UIOffsetMake(0, is_iPhoneX?4:-2);
}
//添加子控制器
-(void)addChildViewController{
   
    //寄件
    KDMailingVC* mailingVC=[[KDMailingVC alloc]init];
    HCTNavigationController* mailingNC=[[HCTNavigationController alloc]initWithRootViewController:mailingVC];
    
    mailingNC.tabBarItem.title = @"寄件";
    mailingNC.tabBarItem.image = [UIImage imageOriginalWithName:@"图标-寄件-未选"];
    // 快速生成一个没有渲染图片
    mailingNC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"图标-寄件-选中"];
    [self addChildViewController:mailingNC];
    
    //查件
    KDCheckPieceVC* checkPieceVC=[[KDCheckPieceVC alloc]init];
    HCTNavigationController* checkPieceNC=[[HCTNavigationController alloc]initWithRootViewController:checkPieceVC];
    
    checkPieceNC.tabBarItem.title=@"查件";
    checkPieceNC.tabBarItem.image = [UIImage imageOriginalWithName:@"图标-查件-未选"];
    // 快速生成一个没有渲染图片
    checkPieceNC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"图标-查件-选中"];
    [self addChildViewController:checkPieceNC];
    
    //我的
    KDMineVC* mineVC=[[KDMineVC alloc]init];
    HCTNavigationController* mineNC=[[HCTNavigationController alloc]initWithRootViewController:mineVC];
    mineNC.tabBarItem.title=@"我的";
    mineNC.tabBarItem.image = [UIImage imageOriginalWithName:@"图标-我的-未选"];
    // 快速生成一个没有渲染图片
    mineNC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"图标-我的-选中"];
    [self addChildViewController:mineNC];
    self.currectVC = mailingVC; //初始化当前正在展示的VC
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    self.currectVC = [viewController.viewControllers firstObject];
    if ([self.currectVC isKindOfClass:[KDMailingVC class]]) {
        NSLog(@"寄件");
    }else if ([self.currectVC isKindOfClass:[KDCheckPieceVC class]]){
        NSLog(@"查件");
    }
    else if ([self.currectVC isKindOfClass:[KDMineVC class]]){
        NSLog(@"我的");
    }
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.selectedIndex != index) {
       [self animationWithIndex:index];
    }
}
// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    self.selectedIndex = index;
}
#pragma mark
-(void)receviceNoti:(NSNotification *)noti
{
    
}




@end

