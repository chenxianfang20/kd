//
//  KDGoodsListModel.h
//  Kuaidi
//
//  Created by ljp on 2019/8/25.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDGoodsListModel : NSObject

@property(nonatomic, strong)NSNumber *id;

@property(nonatomic, copy)NSString *goods_name;

@property(nonatomic, strong)NSNumber *goods_weight;

@property(nonatomic, strong)NSNumber *status;

@end

NS_ASSUME_NONNULL_END
