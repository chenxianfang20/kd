//
//  KDMessageBoardView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDMessageBoardView.h"

@interface KDMessageBoardView()

@property(nonatomic, strong)UIView *bgView;

@end

@implementation KDMessageBoardView

+(void)showSelectViewWithConfirmBlock:(void(^)(NSString *customerMsg, NSString *traditionMsg))confirmBlock{
    
    KDMessageBoardView *view = [[KDMessageBoardView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, 328)];
    view.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    view.alpha = 0;
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = rgb(11, 11, 11, 0.72);
    view.bgView = bgView;
    bgView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(hidden)];
    [bgView addGestureRecognizer:tap];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:bgView];
    [window addSubview:view];
    
    [UIView animateWithDuration:.25 animations:^{
        
        view.alpha = 1.0;
        bgView.alpha = 1.0;
        
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1);
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"给快递员留言";
    titleLabel.textColor = rgb(92, 92, 92, 1);
    titleLabel.font = PingFangBold(18);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.centerX.equalTo(self).offset(0);
        make.height.mas_equalTo(17);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"图标-关闭-大"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(titleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [closeButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:rgb(255, 255, 255, 1.0) forState:UIControlStateNormal];
    confirmButton.titleLabel.font = PingFangBold(15);
    confirmButton.backgroundColor = rgb(223, 47, 49, 1.0);
    confirmButton.layer.cornerRadius = 24;
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-18);
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(48);
    }];
    
    
}


- (void)hidden{
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.alpha = 0.0;
        self.bgView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
@end
