//
//  DKExpressSendInfoCell.h
//  Kuaidi
//
//  Created by ljp on 2019/8/20.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KDWuliuGuijiModel;
@interface DKExpressSendInfoCell : UITableViewCell

@property(nonatomic, assign)NSInteger row;
@property(nonatomic, assign)NSInteger total;
@property(nonatomic, strong)KDWuliuGuijiModel *model;

@end

NS_ASSUME_NONNULL_END
