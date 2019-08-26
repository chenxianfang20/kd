//
//  KDWuliuListModel.h
//  Kuaidi
//
//  Created by ljp on 2019/8/25.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDWuliuListModel : NSObject
/**
 编号
 */
@property(nonatomic, strong)NSNumber *id;

/**
 物流编号
 */
@property(nonatomic, copy)NSString *logistics_code;

/**
 物流名称
 */
@property(nonatomic, copy)NSString *logistics_name;

/**
 物流电话
 */
@property(nonatomic, copy)NSString *logistics_mobile;

/**
 物流图标
 */
@property(nonatomic, copy)NSString *logistics_icon;

/**
 物流申请状态
 */
@property(nonatomic, strong)NSNumber *apply_status;

/**
 状态
 */
@property(nonatomic, strong)NSNumber *status;

@end

NS_ASSUME_NONNULL_END
