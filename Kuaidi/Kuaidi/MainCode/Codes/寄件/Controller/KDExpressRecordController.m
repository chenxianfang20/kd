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
    
    [self.backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.titleView.title = @"寄件记录";
    
}
@end
