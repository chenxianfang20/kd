//
//  KDTimeSelectView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDTimeSelectView.h"

@interface KDTimeSelectView()<PGPickerViewDelegate,PGPickerViewDataSource>

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)NSArray *dayTitles;

@property(nonatomic, strong)NSArray *times;

@property(nonatomic, copy)void(^confirmBlock)(NSString *day, NSString *time);

@property(nonatomic, copy)NSString *day;

@property(nonatomic, copy)NSString *time;

@end

@implementation KDTimeSelectView

+(void)showSelectViewWithConfirmBlock:(void(^)(NSString *day, NSString *time))confirmBlock{
    
    KDTimeSelectView *view = [[KDTimeSelectView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, 344)];
    view.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    view.alpha = 0;
    view.confirmBlock = confirmBlock;
    
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

-(NSArray *)dayTitles{
    
    if (!_dayTitles) {
        _dayTitles = @[@"今天",@"明天",@"后天"];
    }
    return _dayTitles;
}

-(NSArray *)times{
    if (!_times) {
        _times = @[@"09:00-12:00",@"12:00-14:00",@"14:00-17:00",@"19:00-21:00"];
    }
    return _times;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.day = self.dayTitles.firstObject;
        self.time = self.times.firstObject;
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
    titleLabel.text = @"期待上门时间";
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

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"实际上门时间，以与快递员协商后为准\n19:00-21:00上门，需额外加收2元夜间取件费";
    tipLabel.textColor = rgb(92, 92, 92, 1.0);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = PingFangMedium(14);
    tipLabel.numberOfLines = 0;
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(24);
        make.centerX.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(292, 40));
    }];
    
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
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    PGPickerView *pickerView = [[PGPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.lineBackgroundColor = [UIColor clearColor];
    pickerView.rowHeight = 30;
    [self addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(20);
        make.bottom.equalTo(confirmButton.mas_top).offset(-20);
        make.centerX.equalTo(self).offset(0);
        make.width.mas_equalTo(self.width);
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

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.dayTitles.count;
    }else{
         return self.times.count;
    }
   
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.width/2.0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.dayTitles[row];
    } else {
        return self.times[row];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        label.textColor = rgb(11, 11, 11, 1.0);
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0:
        {
            title =   self.dayTitles[row];
            label.font = PingFangBold(15);
            
        }
            break;
        case 1:
        {
            title =   self.times[row];
            label.font = PingFangBold(16);
        }
            break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
    
}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.day = self.dayTitles[row];
    }else{
        self.time = self.times[row];
    }
    
}

- (void)confirmButtonClick:(UIButton *)button{
    
    [self hidden];
    
    if (self.confirmBlock) {
        self.confirmBlock(self.day, self.time);
    }
}

@end
