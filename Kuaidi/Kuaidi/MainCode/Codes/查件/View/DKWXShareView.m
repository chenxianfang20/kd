//
//  DKWXShareView.m
//  Kuaidi
//
//  Created by ljp on 2019/10/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "DKWXShareView.h"

@interface DKWXShareView()

@property(nonatomic, copy)void(^handleBlock)(NSInteger type);

@property(nonatomic, strong)UIView *maskBgView;

@end

@implementation DKWXShareView

+(void)shareViewShowWithHandleBlock:(void(^)(NSInteger type))handleBlock{
    
    DKWXShareView *shareView = [[DKWXShareView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200)];
    shareView.handleBlock = handleBlock;
    shareView.backgroundColor = rgb(255, 255, 255, 1.0);
    
    UIView *maskBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskBgView.backgroundColor = rgb(0, 0, 0, 0.3);
    shareView.maskBgView = maskBgView;
    maskBgView.alpha = 0.0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:maskBgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(hidden)];
    [maskBgView addGestureRecognizer:tap];
    
    [window addSubview:shareView];
    
    [UIView animateWithDuration:.25 animations:^{
        shareView.frame = CGRectMake(0, ScreenHeight - 120, ScreenWidth, 200);
        maskBgView.alpha = 1.0;
    }];
}

-(void)hidden{
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 120);
        self.maskBgView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.maskBgView removeFromSuperview];
        [self removeFromSuperview];
        
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
    
    NSArray *iconArr = @[@"微信",@"朋友圈"];
    for (NSInteger i = 0; i < iconArr.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
        
        if (i == 0) {
            button.frame = CGRectMake(self.width/4 - 22.5, 25, 45, 45);
        }else if (i == 1) {
            button.frame = CGRectMake(self.width * 3/4 - 22.5, 25, 45, 45);
        }
        
        [self addSubview:button];
        button.tag = i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = iconArr[i];
        titleLabel.textColor = rgb(66, 66, 66, 1.0);
        titleLabel.font = PingFangMedium(15);
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).offset(3);
            make.centerX.equalTo(button.mas_centerX).offset(0);
        }];
    }
    
}

- (void)buttonClick:(UIButton *)button{
    
    [self hidden];
    
    if (self.handleBlock) {
        self.handleBlock(button.tag);
    }
    
}

@end
