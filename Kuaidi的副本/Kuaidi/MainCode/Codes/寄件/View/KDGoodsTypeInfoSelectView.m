//
//  KDGoodsTypeInfoSelectView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsTypeInfoSelectView.h"

@interface KDGoodsTypeInfoSelectView()

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic, strong)NSMutableArray *buttonArr;

@end

@implementation KDGoodsTypeInfoSelectView

+(void)showSelectViewWithConfirmBlock:(void(^)(NSString *goodsType, NSInteger weight, UIImage *image))confirmBlock{
    
    KDGoodsTypeInfoSelectView *view = [[KDGoodsTypeInfoSelectView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, 473)];
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

-(NSArray *)titles{
    
    if (!_titles) {
        _titles = @[@"文件",@"食品",@"蛋糕",@"药品",
                    @"生鲜",@"鲜花",@"数码",@"服装鞋帽",
                    @"汽车配件",@"证照",@"珠宝",@"其他"];
    }
    return _titles;
}

-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1);
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"物品信息";
    titleLabel.textColor = rgb(92, 92, 92, 1);
    titleLabel.font = PingFangBold(18);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.centerX.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(75, 17));
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"图标-关闭-大"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-21);
        make.centerY.equalTo(titleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [closeButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *goodsTitleLabel = [[UILabel alloc] init];
    goodsTitleLabel.text = @"物品类型（必填）";
    goodsTitleLabel.textColor = rgb(11, 11, 11, 1);
    goodsTitleLabel.font = PingFangBold(15);
    [self addSubview:goodsTitleLabel];
    [goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(titleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *notSendTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notSendTipBtn setTitle:@"什么不能寄？" forState:UIControlStateNormal];
    [notSendTipBtn setTitleColor:rgb(49, 191, 189, 1) forState:UIControlStateNormal];
    notSendTipBtn.titleLabel.font = PingFangBold(14);
    [self addSubview:notSendTipBtn];
    [notSendTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(goodsTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(85, 14));
    }];
    
    NSInteger row = 4;
    CGFloat buttonW = 66;
    CGFloat buttonH = 30;
    CGFloat matgintW = (self.width - 36 - row * buttonW)/(row - 1);
    CGFloat matgintH = 12;
    for (NSInteger i = 0; i < self.titles.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = PingFangMedium(13);
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 4;
        button.selected = (i == 0);
        [self selectButtonConvert:button];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsTitleLabel.mas_bottom).offset(18 + (matgintH + buttonH) * (i/row));
            make.left.equalTo(self).offset(18 + (buttonW + matgintW) * (i%row));
            make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
        }];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
    }
    
    UILabel *weightTitleLabel = [[UILabel alloc] init];
    weightTitleLabel.text = @"物品重量（必填）";
    weightTitleLabel.textColor = rgb(11, 11, 11, 1);
    weightTitleLabel.font = PingFangBold(15);
    [self addSubview:weightTitleLabel];
    [weightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(goodsTitleLabel.mas_bottom).offset(161);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    UILabel *pictrueTitleLabel = [[UILabel alloc] init];
    pictrueTitleLabel.text = @"物品拍照（选填）";
    pictrueTitleLabel.textColor = rgb(11, 11, 11, 1);
    pictrueTitleLabel.font = PingFangBold(15);
    [self addSubview:pictrueTitleLabel];
    [pictrueTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(weightTitleLabel.mas_bottom).offset(29);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.text = @"公斤";
    unitLabel.textColor = rgb(92, 92, 92, 1);
    unitLabel.font = PingFangBold(15);
    [self addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
    }];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"图标-增加-不可点击"] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"图标-增加-可以点击"] forState:UIControlStateSelected];
    [self addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-61);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.text = @"30";
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.textColor = rgb(11, 11, 11, 1);
    countLabel.font = PingFangBold(20);
    [self addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addButton.mas_left).offset(0);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 24));
    }];
    
    UIButton *subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractButton setImage:[UIImage imageNamed:@"图标-减少-不可点击"] forState:UIControlStateNormal];
    [subtractButton setImage:[UIImage imageNamed:@"图标-减少-可以点击"] forState:UIControlStateSelected];
    [self addSubview:subtractButton];
    [subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countLabel.mas_left).offset(0);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    UIButton *addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImageButton setImage:[UIImage imageNamed:@"图标-上传照片"] forState:UIControlStateNormal];
    [self addSubview:addImageButton];
    [addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(pictrueTitleLabel.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"照片可以帮助快递小哥判断物品的大小以及选择合适的运输工具。";
    tipLabel.textColor = rgb(169, 169, 169, 1);
    tipLabel.numberOfLines = 0;
    tipLabel.font = PingFangMedium(13);
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addImageButton.mas_right).offset(19);
        make.right.equalTo(self).offset(-22);
        make.centerY.equalTo(addImageButton.mas_centerY).offset(0);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = rgb(223, 47, 49, 1);
    confirmButton.layer.cornerRadius = 24;
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateNormal];
    confirmButton.titleLabel.font = PingFangBold(15);
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.bottom.equalTo(self).offset(-18);
        make.height.mas_equalTo(48);
    }];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button{
    
    for (UIButton *button in self.buttonArr) {
        button.selected = NO;
        [self selectButtonConvert:button];
    }
    button.selected = YES;
    [self selectButtonConvert:button];
}

- (void)confirmButtonClick:(UIButton *)button{
    
    [self hidden];
    
}

-(void)selectButtonConvert:(UIButton *)button{
    
    if (button.selected) {
        button.layer.borderColor = rgb(223, 47, 49, 1).CGColor;
        [button setTitleColor:rgb(223, 47, 49, 1) forState:UIControlStateNormal];
    }else{
        button.layer.borderColor = rgb(169, 169, 169, 1).CGColor;
        [button setTitleColor:rgb(169, 169, 169, 1) forState:UIControlStateNormal];
    }
    
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
