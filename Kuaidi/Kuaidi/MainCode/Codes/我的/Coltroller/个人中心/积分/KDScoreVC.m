//
//  KDScoreVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/25.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDScoreVC.h"

@interface KDScoreVC ()
@property (nonatomic,strong) UIView *noticeView;
@end

@implementation KDScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self addChildViews];
    [self getScoreData];
}
-(void)addChildViews{
    //[self.view addSubview:self.tableview];
    
    [self.view addSubview:self.noticeView];
    
    self.noticeView.hidden = NO;
}
-(void)getScoreData{
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
    __weak typeof(self) weakSelf =self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kScoreIndex Dic:nil headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
           
        }
    } FailureBlock:^(id obj) {
        
    }];
}
-(UIView*)noticeView{
    if(!_noticeView){
        _noticeView=[[UIView alloc]initWithFrame:CGRectMake(0,NavibarH+ kAdaptationWidth(110), kScreenWidth, kAdaptationWidth(250))];
        UIImageView* bgImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kAdaptationWidth(180), kAdaptationWidth(180))];
        bgImgView.image=[UIImage imageNamed:@"图标-暂无积分"];
        [_noticeView addSubview:bgImgView];
        bgImgView.centerX=kScreenWidth/2.0;
        
        UILabel* noNoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, bgImgView.bottom+kAdaptationWidth(10), kScreenWidth, kAdaptationWidth(25))];
        noNoticeLabel.text=@"暂无积分记录";
        noNoticeLabel.font=PingFangBold(13);
        noNoticeLabel.textAlignment=NSTextAlignmentCenter;
        noNoticeLabel.textColor=rgb(136, 136, 136, 1);
        [_noticeView addSubview:noNoticeLabel];
        _noticeView.hidden=YES;
    }
    return _noticeView;
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"积分明细"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
}

@end
