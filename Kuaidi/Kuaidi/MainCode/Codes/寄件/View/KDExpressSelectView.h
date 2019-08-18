//
//  KDExpressSelectView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/18.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDExpressSelectView : UITableView


+(void)showSelectViewWithConfirmBlock:(void(^)(NSString *expressType))confirmBlock;

@end

NS_ASSUME_NONNULL_END
