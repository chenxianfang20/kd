//
//  KDOrderGoodsModel.h
//  Kuaidi
//
//  Created by cxf on 2019/9/1.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDOrderGoodsModel : NSObject
/**
 重量
 */
@property(nonatomic, strong)NSNumber* goods_weight ;

@property(nonatomic, strong)NSString* goods_type ;

@property(nonatomic, strong)NSString* goods_price ;
@end

NS_ASSUME_NONNULL_END
