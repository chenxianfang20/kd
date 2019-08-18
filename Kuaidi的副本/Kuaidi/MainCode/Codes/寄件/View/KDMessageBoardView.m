//
//  KDMessageBoardView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDMessageBoardView.h"
#import "CBGroupAndStreamView.h"

@interface KDMessageBoardView()

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)CBGroupAndStreamView *silde;

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
    
    UIView *messageView = [[UIView  alloc] init];
    messageView.layer.cornerRadius = 2;
    messageView.layer.borderWidth = 1;
    messageView.layer.borderColor = rgb(169, 169, 169, 1.0).CGColor;
    [self addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(25);
        make.left.equalTo(self.mas_left).offset(18);
        make.right.equalTo(self.mas_right).offset(-18);
        make.height.mas_equalTo(76);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.textColor = rgb(11, 11, 11, 1.0);
    textView.font = PingFangBold(14);
    textView.placeholder = @"例如：取件地址信息、什么时候来取件、如何联系等信息";
    textView.placeholderAttributes = @{NSFontAttributeName:PingFangMedium(14),
                                       NSForegroundColorAttributeName:rgb(206, 206, 206, 1.0)
                                       };
    textView.maxInputLength = 60;
    [messageView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageView).offset(0);
        make.left.equalTo(messageView).offset(5);
        make.right.equalTo(messageView).offset(-5);
        make.bottom.equalTo(messageView).offset(0);
    }];
    
    NSArray * titleArr = @[@"留言"];
    NSArray *contentArr = @[@[@"按照寄件地址来取件",@"缺少包装",@"需要爬楼梯",@"到了打电话",@"不方便接电话",@"物品体积大"]];
    
    CBGroupAndStreamView * silde = [[CBGroupAndStreamView alloc] initWithFrame:CGRectMake(18, 144, self.width - 36, 90)];
    silde.backgroundColor = [UIColor redColor];
    silde.isDefaultSel = NO;
    silde.isSingle = YES;
    silde.radius = 4;
    silde.norColor = rgb(169, 169, 169, 1.0);
    silde.selColor = rgb(223, 47, 49, 1.0);
    silde.contentNorColor = rgb(169, 169, 169, 1.0);
    silde.contentSelColor = rgb(223, 47, 49, 1.0);
    silde.isSelFillBgColor = NO;
    silde.titleLabHeight = 0;
    silde.maragin_x = 12;
    silde.maragin_y = 12;
    silde.font = PingFangMedium(13);
    silde.singleFlagArr = @[@0];
    [silde setContentView:contentArr titleArr:titleArr];
    [self addSubview:silde];
    self.silde = silde;
    silde.cb_confirmReturnValueBlock = ^(NSArray *valueArr, NSArray *groupIdArr) {
        NSLog(@"valueArr = %@ \ngroupIdArr = %@",valueArr,groupIdArr);
    };
    silde.cb_selectCurrentValueBlock = ^(NSString *value, NSInteger index, NSInteger groupId) {
        NSLog(@"value = %@----index = %ld------groupId = %ld",value,index,groupId);
    };
//    [silde mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(18);
//        make.right.equalTo(self).offset(-18);
//        make.top.equalTo(messageView.mas_bottom).offset(18);
//        make.bottom.equalTo(confirmButton.mas_top).offset(-18);
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    
}
- (void)hidden{
    
    [self endEditing:YES];
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.alpha = 0.0;
        self.bgView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
@end
