//
//  KDLoginVC.h
//  Kuaidi
//
//  Created by ios01 on 2019/8/14.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootViewController.h"

typedef void(^LoginBlock)(void);

@interface KDLoginVC : RootViewController
@property (nonatomic,copy) LoginBlock  loginBlock;
@end


