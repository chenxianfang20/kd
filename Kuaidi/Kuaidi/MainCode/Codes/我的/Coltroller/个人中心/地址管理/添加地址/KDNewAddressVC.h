//
//  KDNewAddressVC.h
//  Kuaidi
//
//  Created by cxf on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootViewController.h"

typedef void (^MyBlock)(void);

@interface KDNewAddressVC : RootViewController
@property (nonatomic,copy) MyBlock  myBlock;
@end


