//
//  HCTTitleView.h
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/4/24.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import "RootCustomView.h"


typedef void (^eventBlock)();
typedef enum : NSUInteger {
    TitleViewType_title,
    TitleViewType_image, //可点
    TitleViewType_titleAndImage //可点
}TitleViewType;

@interface HCTTitleView : RootCustomView

@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,assign)TitleViewType type;


/**
 *  只有类型为图片的时候
 */
@property (nonatomic,copy)eventBlock block;

-(void)setTitle:(NSString *)title;
-(void)setImgName:(NSString *)imgName;
-(void)setImageTitle:(NSString *)title;

+(instancetype)titleView;

@end


@interface TitleImageView : UIButton

@property (nonatomic,copy)NSString *title;

@end
