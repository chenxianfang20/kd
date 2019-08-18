//
//  KDExpressRecordController.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressRecordController.h"

@interface KDExpressRecordController ()

@end

@implementation KDExpressRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
}

-(void)setNav{
    
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(11, 11, 11, 1.0);
    self.titleView.titleLable.text = @"寄件记录";
    self.titleView.titleLable.hidden = NO;
    
}
@end
