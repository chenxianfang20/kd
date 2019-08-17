//
//  KDTitleView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/15.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDTitleView.h"

@interface KDTitleView()

@property(nonatomic, strong)NSArray *titleArr;

@property(nonatomic, strong)UIView *dotView;

@end

@implementation KDTitleView

-(NSArray *)titleArr{
    
    if (!_titleArr) {
        _titleArr = @[@"普通寄件",@"同城急送",@"国际速运"];
    }
    return _titleArr;
}

-(UIView *)dotView{
    
    if (!_dotView) {
        _dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
        _dotView.layer.cornerRadius = 2;
        _dotView.layer.masksToBounds = YES;
        _dotView.backgroundColor = rgb(255, 266, 255, 1.0);
        [self addSubview:self.dotView];
    }
    return _dotView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    CGFloat margint = 18;
    CGFloat buttonW = 70;
    CGFloat buttonH = self.frame.size.height;
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(margint + (margint + buttonW)*i, 0, buttonW, buttonH);
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateSelected];
        [button setTitleColor:rgb(255, 255, 255, 0.72) forState:UIControlStateNormal];
        button.titleLabel.font =  [UIFont fontWithName:@"PingFang-SC-Bold" size: 18];
        button.selected = (i == 0);
        [self addSubview:button];
        
        if (i == 0) {
            
            self.dotView.center = CGPointMake(button.center.x, self.height-self.dotView.height/2.0);
        }
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(margint + (margint + buttonW)*self.titleArr.count, 0, 1, 16)];
    lineView.backgroundColor = rgb(255, 255, 255, 0.72);
    lineView.center = CGPointMake(lineView.center.x, self.height/2.0);
    [self addSubview:lineView];
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordButton setTitle:@"寄件记录" forState:UIControlStateNormal];
    [recordButton setTitleColor:rgb(223, 47, 49, 1) forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 13];
    recordButton.backgroundColor = rgb(255, 255, 255, 0.72);
    recordButton.layer.cornerRadius = 9;
    [self addSubview:recordButton];
    [recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(lineView.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(68, 18));
    }];
}

@end
