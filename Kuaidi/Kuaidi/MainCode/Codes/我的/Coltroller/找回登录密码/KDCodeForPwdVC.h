//
//  KDCodeForPwdVC.h
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDCodeForPwdVC : RootViewController
@property (nonatomic,strong) NSString *phoneStr;
@property(nonatomic,assign)NSInteger timeCount;
@property (nonatomic,strong) NSTimer* timer ;
@end

NS_ASSUME_NONNULL_END
