//
//  KDGoodsInfoView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsInfoView.h"
#import "KDGoodsInfoFooterView.h"

@interface KDGoodsInfoView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)KDGoodsInfoFooterView *footerView;

@end

@implementation KDGoodsInfoView

+(KDGoodsInfoView *)goodsInfoView{
    
    KDGoodsInfoView *goodsInfoView = [[KDGoodsInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 36, 250) style:UITableViewStylePlain];
    
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
    self.layer.shadowColor = rgb(11, 11, 11, 1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    self.layer.cornerRadius = 12;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    self.tableHeaderView.backgroundColor = rgb(255, 255, 255, 1);
    self.footerView = [KDGoodsInfoFooterView goodsInfoFooterView];
    self.tableFooterView = self.footerView;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor redColor];//rgb(255, 255, 255, 1);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43.25;
}

@end
