//
//  KDGoodsTypeInfoSelectView.h
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDGoodsTypeInfoSelectView : UIView

+(void)showSelectViewWithGoodsArr:(NSMutableArray *)goodsArr
                           select:(NSInteger)index
                         imageUrl:(NSString *)imageUrl
                     confirmBlock:(void(^)(NSInteger index, NSString *imageUrl, NSString *count))confirmBlock;

@end

NS_ASSUME_NONNULL_END
