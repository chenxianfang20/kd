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

+(KDGoodsInfoView *)goodsInfoView;

@end

NS_ASSUME_NONNULL_END
