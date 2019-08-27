//
//  KDOrderDetailVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/26.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDOrderDetailVC.h"
#import "KDToContactedView.h"
@interface KDOrderDetailVC ()
//取件码背景
@property (nonatomic,strong) UIView *scanView;

@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,strong) UIView *midBgView;
@property (nonatomic,strong) UIView *bottomBgView;

@property (nonatomic,strong) UIScrollView *scrollowView;

//待联系
@property (nonatomic,strong) KDToContactedView *toContactedView;

@end

@implementation KDOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self addchildViews];
}
-(void)addchildViews{
    self.view.backgroundColor = rgb(236, 236, 236, 1);
    UIView* topRedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, 60)];
    topRedBgView.backgroundColor =[UIColor colorWithHex:@"#DF2F31"];
    [self.view addSubview:topRedBgView];
    __weak typeof(self)weakSelf=self;
    _scrollowView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight-NavibarH )];
     //weakSelf.scrollowView.delegate=self;
    _scrollowView.scrollEnabled=YES;
    [self.view addSubview:_scrollowView];
    
    //待联系
    _toContactedView=[[KDToContactedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavibarH)];
    
    _toContactedView.myIsShowInfoBlock=^(NSInteger isShow){
        if(isShow == 1){
           weakSelf.scrollowView.scrollEnabled=YES;
           weakSelf.scrollowView.contentSize=CGSizeMake(kScreenWidth, weakSelf.toContactedView.height);
        }else{
            weakSelf.scrollowView.scrollEnabled=NO;
            [weakSelf.scrollowView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    };
    [_scrollowView addSubview:_toContactedView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<0){
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor whiteColor];
    [self.titleView setTitle:@"订单详情"];
    //[self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]];
}
@end
