//
//  KDExpressRecordCell.h
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KDOrderListModel;

@protocol KDExpressRecordCellDelegate <NSObject>

@optional
-(void)clickDetailButtonWithModel:(KDOrderListModel *)model;
-(void)clickOperateButtonWithModel:(KDOrderListModel *)model;

@end

@interface KDExpressRecordCell : UITableViewCell

@property(nonatomic, assign)id<KDExpressRecordCellDelegate> delegate;

@property(nonatomic, strong)KDOrderListModel *model;

@end

NS_ASSUME_NONNULL_END
