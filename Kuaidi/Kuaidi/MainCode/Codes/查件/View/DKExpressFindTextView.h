//
//  DKExpressFindTextView.h
//  Kuaidi
//
//  Created by ljp on 2019/9/8.
//  Copyright © 2019 ios01. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KDWuliuGuijiModel;
@protocol DKExpressFindTextViewDelegate <NSObject>

@optional
- (void)searchExpressInfoWithNum:(NSString *)num;

@end

@interface DKExpressFindTextView : UIView

@property(nonatomic, assign)id<DKExpressFindTextViewDelegate> delegate;

@property(nonatomic, strong)KDWuliuGuijiModel *model;

+(DKExpressFindTextView *)expressFindTextView;

@end

NS_ASSUME_NONNULL_END
