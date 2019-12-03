//
//  KDGoodsInfoView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsInfoView.h"
#import "KDGoodsInfoFooterView.h"
#import "KDGoodsInfoCell.h"

@interface KDGoodsInfoView()<UITableViewDelegate,UITableViewDataSource,KDGoodsInfoFooterViewDelegate>

@property(nonatomic, strong)KDGoodsInfoFooterView *footerView;

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic, strong)NSArray *holders;

@end

@implementation KDGoodsInfoView

-(NSArray *)titles{
    
    if (!_titles) {
        _titles = @[@"物品信息",@"快递选择",@"期待上门时间",@"给快递员留言"];
    }
    return _titles;
}

-(NSArray *)holders{
    
    if (!_holders) {
        _holders = @[@"请选择类型、重量",@"必填",@"必填",@"必填"];
    }
    return _holders;
}

+(KDGoodsInfoView *)goodsInfoView{
    
    KDGoodsInfoView *goodsInfoView = [[KDGoodsInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 252) style:UITableViewStylePlain];
    
    return goodsInfoView;
    
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1.0);
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    self.layer.cornerRadius = 12;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 12)];
    self.tableHeaderView.backgroundColor = rgb(255, 255, 255, 1);
    self.footerView = [KDGoodsInfoFooterView goodsInfoFooterView];
    self.footerView.delegate = self;
    self.tableFooterView = self.footerView;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"KDGoodsInfoCell";
    KDGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KDGoodsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.textField.placeholder = self.holders[indexPath.row];
    if (indexPath.row == 0) {
        self.goodsTypeTF = cell.textField;
    }else if (indexPath.row == 1){
        self.expressTypeTF = cell.textField;
    }else if (indexPath.row == 2){
        self.timeTF = cell.textField;
    }else if (indexPath.row == 3){
        self.messageTF = cell.textField;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43.25;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.goodsInfoViewDelegate respondsToSelector:@selector(selectCellIndexPath:)]) {
        [self.goodsInfoViewDelegate selectCellIndexPath:indexPath];
    }
    
}

#pragma mark -- KDGoodsInfoFooterViewDelegate
-(void)clickConfirmButton{
    
    if ([self.goodsInfoViewDelegate respondsToSelector:@selector(clickConfirmButton)]) {
        [self.goodsInfoViewDelegate clickConfirmButton];
    }
    
}

- (void)clickCancellOrder{
    if ([self.goodsInfoViewDelegate respondsToSelector:@selector(clickCancellOrder)]) {
        [self.goodsInfoViewDelegate clickCancellOrder];
    }
}

- (void)setIsOrderButtonSelect:(BOOL)isOrderButtonSelect{
    self.footerView.isOrderButtonSelect = isOrderButtonSelect;
}

-(void)setMoney:(CGFloat)money{
    _money = money;
    self.footerView.money = money;
}
@end
