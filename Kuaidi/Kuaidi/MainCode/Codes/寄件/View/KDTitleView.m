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
        button.frame = CGRectMake((margint + buttonW)*i, 0, buttonW, buttonH);
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateSelected];
        [button setTitleColor:rgb(255, 255, 255, 0.72) forState:UIControlStateNormal];
        button.titleLabel.font =  [UIFont fontWithName:@"PingFang-SC-Bold" size: 18];
        button.selected = (i == 0);
        [self addSubview:button];
        
        if (i == 0) {
            self.dotView.frame = CGRectMake(0, self.frame.size.height - self.dotView.frame.size.height, self.dotView.frame.size.width, self.dotView.frame.size.height);
            self.dotView.center = CGPointMake(buttonW/2.0, self.dotView.center.y);
            [self addSubview:self.dotView];
        }
    }
}

@end
