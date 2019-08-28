//
//  KDToContactedView.h
//  Kuaidi
//
//  Created by cxf on 2019/8/27.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "RootCustomView.h"

typedef void(^MyIsShowInfoBlock)(NSInteger);

@interface KDToContactedView : RootCustomView
@property (nonatomic,strong) UIButton *showInfoBtn;
@property (nonatomic,strong) UIView *bottomBgView;
@property (nonatomic,strong) MyIsShowInfoBlock myIsShowInfoBlock;

@end


