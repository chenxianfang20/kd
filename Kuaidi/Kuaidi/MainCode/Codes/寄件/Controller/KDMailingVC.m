//
//  KDMailingVC.m
//  Kuaidi
//
//  Created by ios01 on 2019/8/12.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDMailingVC.h"

@interface KDMailingVC ()

@end

@implementation KDMailingVC

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
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,0,kScreenWidth,180);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = bgView.frame;
    gl.startPoint = CGPointMake(0, 1);
    gl.endPoint = CGPointMake(0, 0);
    gl.colors = @[(__bridge id)rgb(250, 248, 248, 1.0).CGColor,(__bridge id)rgb(223, 47, 49, 1.0).CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [bgView.layer addSublayer:gl];
    [contentView addSubview:bgView];
}

@end
