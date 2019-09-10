//
//  KDWuliuGuijiModel.h
//  Kuaidi
//
//  Created by ljp on 2019/9/1.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDWuliuListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDWuliuTraces : NSObject

@property(nonatomic, copy)NSString *AcceptStation;

@property(nonatomic, copy)NSString *AcceptTime;

@property(nonatomic, copy)NSString *remark;

@end


@interface KDWuliuGuijiModel : NSObject

@property(nonatomic, copy)NSString *LogisticCode;

@property(nonatomic, copy)NSString *ShipperCode;

@property(nonatomic, strong)NSArray *Traces;

@property(nonatomic, copy)NSString *State;

@property(nonatomic, copy)NSString *EBusinessID;

@property(nonatomic, strong)NSNumber *Success;

@property(nonatomic, copy)NSString *status_name;

@property(nonatomic, strong)KDWuliuListModel *logistic;


@end

NS_ASSUME_NONNULL_END
