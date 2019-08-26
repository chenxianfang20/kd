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

@property(nonatomic, strong)NSMutableArray *buttonArr;

@end

@implementation KDTitleView

-(NSMutableArray *)buttonArr{
    
    if (!_buttonArr) {
        
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

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
        self.index = 0;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    CGFloat margint = 18;
    CGFloat buttonW = 75;
    CGFloat buttonH = self.frame.size.height;
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(margint + (margint + buttonW)*i, 0, buttonW, buttonH);
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateSelected];
        [button setTitleColor:rgb(255, 255, 255, 0.72) forState:UIControlStateNormal];
        button.titleLabel.font = PingFangMedium(18);
        button.selected = (i == 0);
        [self addSubview:button];
        
        if (i == 0) {
            
            self.dotView.center = CGPointMake(button.center.x, self.height-self.dotView.height/2.0);
            button.titleLabel.font =  PingFangBold(18);
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(margint + (margint + buttonW)*self.titleArr.count, 0, 1, 16)];
    lineView.backgroundColor = rgb(255, 255, 255, 0.72);
    lineView.center = CGPointMake(lineView.center.x, self.height/2.0);
    [self addSubview:lineView];
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordButton setTitle:@"寄件记录" forState:UIControlStateNormal];
    [recordButton setTitleColor:rgb(223, 47, 49, 1) forState:UIControlStateNormal];
    recordButton.titleLabel.font = PingFangMedium(13);
    recordButton.backgroundColor = rgb(255, 255, 255, 0.72);
    recordButton.layer.cornerRadius = 9;
    [self addSubview:recordButton];
    [recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(lineView.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(68, 18));
    }];
    [recordButton addTarget:self action:@selector(recordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)recordButtonClick:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(lookExpressRecord)]) {
        [self.delegate lookExpressRecord];
    }
}

- (void)buttonClick:(UIButton *)button{
    
    for (UIButton *button in self.buttonArr) {
        
        button.selected = NO;
        
        [self covertButtonType:button];
    }
    
    button.selected = YES;
    [self covertButtonType:button];
    self.index = button.tag;
    self.dotView.center = CGPointMake(button.center.x, self.height-self.dotView.height/2.0);
}

- (void)covertButtonType:(UIButton *)button{
    
    if (button.selected) {
        button.titleLabel.font =  PingFangBold(18);
    }else{
        button.titleLabel.font = PingFangMedium(18);
    }
    
}

@end
