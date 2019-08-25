//
//  KDExpressSelectView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDExpressSelectView.h"
#import "KDExpressSelectCell.h"
#import "KDWuliuListModel.h"

@interface KDExpressSelectView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)UIView *headerView;

@property(nonatomic, strong)UIView *footerView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *wuliuArr;

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, strong)UIButton *selectButton;

@property(nonatomic, copy)void(^confirmBlock)(NSInteger index);

@end

@implementation KDExpressSelectView

+(void)showSelectViewWithWuliuArr:(NSArray *)wuliuArr select:(NSInteger)index ConfirmBlock:(void(^)(NSInteger index))confirmBlock{
    
    KDExpressSelectView *view = [[KDExpressSelectView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, 459) WuliuArr:wuliuArr select:index];
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

-(UIView *)headerView{
    
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 159)];
        _headerView.backgroundColor = [UIColor clearColor];//rgb(255, 255, 255, 1);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_headerView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"快递选择";
        titleLabel.textColor = rgb(92, 92, 92, 1);
        titleLabel.font = PingFangBold(18);
        [_headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_headerView).offset(19);
            make.centerX.equalTo(self->_headerView).offset(0);
            make.height.mas_equalTo(17);
        }];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"图标-关闭-大"] forState:UIControlStateNormal];
        [_headerView addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_headerView).offset(-18);
            make.centerY.equalTo(titleLabel.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        [closeButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconImageV = [[UIImageView alloc] init];
        iconImageV.backgroundColor = [UIColor whiteColor];
        iconImageV.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
        iconImageV.layer.shadowOffset = CGSizeMake(0,0);
        iconImageV.layer.shadowOpacity = 1;
        iconImageV.layer.shadowRadius = 8;
        iconImageV.layer.borderWidth = 1;
        iconImageV.layer.borderColor = rgb(237, 237, 237, 1.0).CGColor;
        iconImageV.layer.cornerRadius = 24;
        [_headerView addSubview:iconImageV];
        [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_headerView).offset(18);
            make.top.equalTo(self->_headerView).offset(60);
            make.size.mas_equalTo(CGSizeMake(48, 48));
        }];
        KDWuliuListModel *model = self.wuliuArr.firstObject;
        [iconImageV sd_setImageWithURL:[NSURL URLWithString:model.logistics_icon]];
        
        UILabel *topTipLabel = [[UILabel alloc] init];
        topTipLabel.text = @"快递么优选上门取件";
        topTipLabel.textColor = rgb(11, 11, 11, 1.0);
        topTipLabel.font = PingFangBold(15);
        [_headerView addSubview:topTipLabel];
        [topTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_headerView).offset(66);
            make.left.equalTo(iconImageV.mas_right).offset(18);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *btmTipLabel = [[UILabel alloc] init];
        btmTipLabel.text = @"即刻响应、极速上门、官方定价";
        btmTipLabel.textColor = rgb(169, 169, 169, 1.0);
        btmTipLabel.font = PingFangMedium(13);
        [_headerView addSubview:btmTipLabel];
        [btmTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topTipLabel.mas_bottom).offset(9);
            make.left.equalTo(iconImageV.mas_right).offset(18);
            make.height.mas_equalTo(13);
        }];
        
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton = selectButton;
        [selectButton setImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateSelected];
        [_headerView addSubview:selectButton];
        [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_headerView).offset(-18);
            make.centerY.equalTo(iconImageV.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        selectButton.selected = self.index == -1;
//        [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        selectButton.userInteractionEnabled = NO;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"其他快递服务";
        label.font = PingFangBold(15);
        label.textColor = rgb(11, 11, 11, 1.0);
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_headerView).offset(18);
            make.bottom.equalTo(self->_headerView.mas_bottom).offset(0);
            make.height.mas_equalTo(15);
        }];
    }
    return _headerView;
}

-(UIView *)footerView{
    
    if (!_footerView) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 459 - 104, kScreenWidth - 36, 104)];
        _footerView.backgroundColor = [UIColor clearColor];
        //rgb(255, 255, 255, 1.0);
        
        UIView *shadowView = [[UIView alloc] init];
        shadowView.backgroundColor = rgb(255, 255, 255, 1.0);
        shadowView.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0,0);
        shadowView.layer.shadowOpacity = 1;
        shadowView.layer.shadowRadius = 24;
        shadowView.layer.cornerRadius = 12;
        [_footerView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_footerView).offset(20);
            make.left.right.bottom.equalTo(self->_footerView).offset(0);
        }];
        
        UIView *maskView = [[UIView alloc] init];
        maskView.backgroundColor =rgb(255, 255, 255, 1.0);
        [shadowView addSubview:maskView];
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(shadowView).offset(0);
            make.height.mas_equalTo(12);
        }];
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [confirmButton setTitleColor:rgb(255, 255, 255, 1.0) forState:UIControlStateNormal];
        confirmButton.titleLabel.font = PingFangBold(15);
        confirmButton.backgroundColor = rgb(223, 47, 49, 1.0);
        confirmButton.layer.cornerRadius = 24;
        [shadowView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(shadowView.mas_centerY).offset(0);
            make.left.equalTo(shadowView).offset(18);
            make.right.equalTo(shadowView).offset(-18);
            make.height.mas_equalTo(48);
        }];
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.height, kScreenWidth - 36, 459 - 104 - 159) style:UITableViewStylePlain];
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame WuliuArr:(NSArray *)wuliuArr select:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.wuliuArr = wuliuArr;
        self.index = index;
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.cornerRadius = 12;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 0)];
    [self addSubview:self.headerView];
    [self addSubview:self.tableView];
    [self addSubview:self.footerView];
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

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"KDExpressSelectCell";
    KDExpressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KDExpressSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KDWuliuListModel *model = self.wuliuArr[indexPath.row + 1];
    [cell.icoImageV sd_setImageWithURL:[NSURL URLWithString:model.logistics_icon]];
    cell.titleLabel.text = model.logistics_name;
    if (self.index == indexPath.row) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wuliuArr.count - 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectButton.selected = NO;
    self.index = indexPath.row;
    
}

- (void)tapClick{
    
    self.index = -1;
    self.selectButton.selected = YES;
    [self.tableView reloadData];
}


- (void)confirmButtonClick:(UIButton *)button{
    
    [self hidden];
    
    if (self.confirmBlock) {
        self.confirmBlock(self.index);
    }
}
@end
