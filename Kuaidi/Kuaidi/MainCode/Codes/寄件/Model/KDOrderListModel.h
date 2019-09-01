//
//  KDOrderListModel.h
//  Kuaidi
//
//  Created by ljp on 2019/8/25.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDWuliuListModel;
@class KDOrderGoodsModel;
@interface KDOrderListModel : NSObject

@property(nonatomic, strong)NSNumber *id;

@property(nonatomic, strong)NSNumber *type;

@property(nonatomic, strong)NSNumber *user_id;

@property(nonatomic, copy)NSString *pay_money;

@property(nonatomic, strong)NSNumber *pay_time;

@property(nonatomic, strong)NSNumber *pay_status;

@property(nonatomic, copy)NSString *pay_orderno;

@property(nonatomic, copy)NSString *send_name;

@property(nonatomic, copy)NSString *send_mobile;

@property(nonatomic, copy)NSString *send_province_name;

@property(nonatomic, copy)NSString *send_city_name;

@property(nonatomic, copy)NSString *send_district_name;

@property(nonatomic, copy)NSString *send_address;

@property(nonatomic, copy)NSString *accept_name;

@property(nonatomic, copy)NSString *accept_mobile;

@property(nonatomic, copy)NSString *accept_province_name;

@property(nonatomic, copy)NSString *accept_city_name;

@property(nonatomic, copy)NSString *accept_district_name;

@property(nonatomic, copy)NSString *accept_address;

@property(nonatomic, copy)NSString *delivery_code;

@property(nonatomic, copy)NSString *delivery_name;

@property(nonatomic, copy)NSString *delivery_orderno;

@property(nonatomic, copy)NSString *delivery_time;

@property(nonatomic, copy)NSString *deliver_want_time;

@property(nonatomic, copy)NSString *delivery_fee;

@property(nonatomic, copy)NSString *user_remark;

@property(nonatomic, strong)NSNumber *status;

@property(nonatomic, copy)NSString *create_time;

@property(nonatomic, strong)NSNumber *update_time;

@property(nonatomic, copy)NSString *status_name;

@property(nonatomic, strong)KDWuliuListModel *kuaidi;

@property(nonatomic, strong)KDOrderGoodsModel *ordergoods;


@end

NS_ASSUME_NONNULL_END
