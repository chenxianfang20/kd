//
//  KDExpressRecordController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressRecordController.h"
#import "HGSegmentedPageViewController.h"
#import "KDExpressRecordListController.h"

@interface KDExpressRecordController ()

@property (nonatomic, strong) HGSegmentedPageViewController *segmentedPageViewController;

@end

@implementation KDExpressRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self addChildViewController:self.segmentedPageViewController];
    [self.view addSubview:self.segmentedPageViewController.view];
    [self.segmentedPageViewController didMoveToParentViewController:self];
    [self.segmentedPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavibarH);
    }];
}

-(void)setNav{
    
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(11, 11, 11, 1.0);
    self.titleView.titleLable.text = @"寄件记录";
    self.titleView.titleLable.hidden = NO;
    
}

#pragma mark Getters
- (HGSegmentedPageViewController *)segmentedPageViewController {
    if (!_segmentedPageViewController) {
        NSMutableArray *controllers = [NSMutableArray array];
        NSArray *titles = @[@"全部", @"未完成", @"已完成", @"待寄出"];
        for (int i = 0; i < titles.count; i++) {
            
            KDExpressRecordListController *controller = [[KDExpressRecordListController alloc] init];
            [controllers addObject:controller];
        }
        
        
//        @property (nonatomic, strong) UIFont *titleNomalFont;
//
//        /// 选中时的字体大小
//        @property (nonatomic, strong) UIFont *titleSelectedFont;
//
//        /// 未选中时的字体颜色
//        @property (nonatomic, strong) UIColor *titleNormalColor;
//
//        /// 选中时的字体颜色
//        @property (nonatomic, strong) UIColor *titleSelectedColor;
        
        CGFloat W = 45;
        CGFloat leftRightMargint = 26;
        CGFloat margint = (self.view.width - leftRightMargint * 2 - titles.count * W)/(titles.count - 1);
        _segmentedPageViewController = [[HGSegmentedPageViewController alloc] init];
        _segmentedPageViewController.pageViewControllers = controllers;
        _segmentedPageViewController.categoryView.titles = titles;
        _segmentedPageViewController.categoryView.alignment = HGCategoryViewAlignmentLeft;
        _segmentedPageViewController.categoryView.originalIndex = 0;
        _segmentedPageViewController.categoryView.itemSpacing = margint;
        _segmentedPageViewController.categoryView.backgroundColor = [UIColor whiteColor];
        _segmentedPageViewController.categoryView.height = 45;
        _segmentedPageViewController.categoryView.underlineHeight = 2;
        _segmentedPageViewController.categoryView.itemWidth = W;
        _segmentedPageViewController.categoryView.leftAndRightMargin = leftRightMargint;
        _segmentedPageViewController.categoryView.topBorder.hidden = YES;
        _segmentedPageViewController.categoryView.bottomBorder.hidden = YES;
        _segmentedPageViewController.categoryView.titleNomalFont = PingFangMedium(15);
        _segmentedPageViewController.categoryView.titleSelectedFont = PingFangMedium(15);
        _segmentedPageViewController.categoryView.titleNormalColor = rgb(11, 11, 11, 1.0);
        _segmentedPageViewController.categoryView.titleSelectedColor = rgb(223, 47, 49, 1.0);
    }
    return _segmentedPageViewController;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
@end
