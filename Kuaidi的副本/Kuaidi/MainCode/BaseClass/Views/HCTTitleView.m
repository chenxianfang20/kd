
//
//  HCTTitleView.m
//  HCT_Lottery
//
//  Created by iOS_01 on 2017/4/24.
//  Copyright © 2017年 HCT. All rights reserved.
//

#import "HCTTitleView.h"

@interface HCTTitleView()


@property (nonatomic,strong)UIButton *imageBtn;;
@property (nonatomic,strong)TitleImageView *titleImgView;

@end
@implementation HCTTitleView

-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _titleLable.font = kAdaptationBoldFont(18);
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
-(UIButton *)imageBtn
{
    if (!_imageBtn) {
        _imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(134), 20, kAdaptationWidth(10), kAdaptationWidth(5))];
        [_imageBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [_imageBtn setBackgroundImage:[UIImage imageNamed:@"顶部展开"] forState:UIControlStateNormal];
        _imageBtn.centerY=self.height/2.0;
    }
    return _imageBtn;
}

-(TitleImageView *)titleImgView
{
    if (!_titleImgView) {
        _titleImgView = [[TitleImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [_titleImgView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleImgView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = TitleViewType_title;
        
        [self addSubview:self.titleLable];
        [self addSubview:self.imageBtn];
        [self addSubview:self.titleImgView];
        _titleLable.hidden = YES;
        _imageBtn.hidden = YES;
        _titleImgView.hidden = YES;
        
        
    }
    return self;
}

-(void)click
{
    if (self.block) {
        self.block();
    }
}

-(void)setType:(TitleViewType)type
{
    _type = type;
    if (type == TitleViewType_title) {
        _titleLable.hidden = NO;
        _imageBtn.hidden = YES;
        _titleImgView.hidden = YES;
    }else if (type == TitleViewType_image){
        _titleLable.hidden = YES;
        _imageBtn.hidden = NO;
        _titleImgView.hidden = YES;
    }else if (type == TitleViewType_titleAndImage){
        _titleLable.hidden = YES;
        _imageBtn.hidden = NO;
        _titleImgView.hidden = NO;
    }
}

-(void)setTitle:(NSString *)title
{
    _titleLable.text = title;
}
-(void)setImgName:(NSString *)imgName
{
    [_imageBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}
-(void)setImageTitle:(NSString *)title
{
    _titleImgView.title = title;
}

+(instancetype)titleView
{
    return [[HCTTitleView alloc]initWithFrame:CGRectMake((kScreenWidth -kAdaptationWidth(200))/2 ,NavibarH - 44, kAdaptationWidth(200), 44)];
}

@end

@interface TitleImageView()

@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIImageView *rightImg;

@end
@implementation TitleImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = kAdaptationBoldFont(9);
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor whiteColor];
        _rightImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部栏下拉按钮"]];
        
        [self addSubview:_titleLable];
        [self addSubview:_rightImg];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLable.text = title;
    CGFloat imgAndSpaceWidth = kAdaptationWidth(10) + kAdaptationWidth(2);
    CGSize size = [title boundingRectWithSize:CGSizeMake(self.width - imgAndSpaceWidth, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :kAdaptationBoldFont(9)} context:nil].size;
    CGFloat totleWidth = size.width + imgAndSpaceWidth;
    _titleLable.frame = CGRectMake((self.width - totleWidth)/2, (self.height - size.height)/2 , size.width, size.height);
    _rightImg.frame = CGRectMake(_titleLable.right + kAdaptationWidth(2), _titleLable.bottom - kAdaptationWidth(9) , kAdaptationWidth(10), kAdaptationWidth(9));
}
@end
