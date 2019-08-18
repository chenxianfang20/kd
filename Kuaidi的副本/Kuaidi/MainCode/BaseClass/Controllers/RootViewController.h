//
//  RootViewController.h
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/4/20.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTTitleView.h"

@interface RootViewController : UIViewController

/**
 *  自定义顶部栏
 */
@property(nonatomic,strong)UIView *nav;

/**
 *  导航条返回按钮
 */
@property (strong,nonatomic)UIButton *backButton;

/**
 *  标题 或者文字 中奖
 */
@property (strong,nonatomic)HCTTitleView *titleView;

/**
 *  导航右侧第一个按钮
 */
@property (strong,nonatomic)UIButton *rightBtn;



/**
 *  导航条背景图片View
 */
@property (strong,nonatomic)UIImageView *backgroungImgView;

/**
 *  右侧点击事件
 */
-(void)rightClick:(UIButton*)button;
/*
*  右侧第二个按钮点击事件
*/
-(void)rightSecClick:(UIButton*)button;
/**
 *  返回
 */
-(void)back;

@end



