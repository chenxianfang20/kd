//
//  KDGoodsInfoView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KDGoodsInfoViewDelegate <NSObject>

@optional
-(void)selectCellIndexPath:(NSIndexPath *)indexPath;
-(void)clickConfirmButton;
@end

@interface KDGoodsInfoView : UITableView

@property(nonatomic,assign)id<KDGoodsInfoViewDelegate> goodsInfoViewDelegate;

@property(nonatomic, strong)UITextField *goodsTypeTF;

@property(nonatomic, strong)UITextField *expressTypeTF;

@property(nonatomic, strong)UITextField *timeTF;

@property(nonatomic, strong)UITextField *messageTF;

@property(nonatomic, assign)BOOL isOrderButtonSelect;

@property(nonatomic, assign)CGFloat money;

+(KDGoodsInfoView *)goodsInfoView;

@end

NS_ASSUME_NONNULL_END
