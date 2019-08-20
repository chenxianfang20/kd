//
//  KDAboutAsVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/18.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDAboutAsVC.h"
@interface KDAboutAsVC()

@property (nonatomic,strong) UILabel* infoLabel;
@property (nonatomic,strong) UIView*  infoBgView;

@end
@implementation KDAboutAsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    
    [self addChildViews];
    
    [self getData];
    
}

-(void)addChildViews{
    self.view.backgroundColor=[UIColor colorWithHex:@"#FAF8F8"];
    UIImageView* topBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptationWidth(268))];
    topBgImgView.image = [UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]];
    [self.view addSubview:topBgImgView];
    [self.view sendSubviewToBack:topBgImgView];
    
    UIImageView* iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(128), NavibarH+kAdaptationWidth(14), kAdaptationWidth(120), kAdaptationWidth(41))];
    iconImgView.image = [UIImage imageNamed:@"关于-图片"];
    [self.view addSubview:iconImgView];
    
     _infoBgView= [[UIView alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), NavibarH+kAdaptationWidth(82), kAdaptationWidth(339), kAdaptationWidth(502))];
    _infoBgView.backgroundColor=[UIColor whiteColor];
    _infoBgView.layer.cornerRadius=10.0f;
    _infoBgView.layer.masksToBounds=YES;
    [self.view addSubview:_infoBgView];
    
    
    _infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(18), kAdaptationWidth(24), kAdaptationWidth(295), kAdaptationWidth(502))];
    _infoLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    _infoLabel.font =[UIFont fontWithName:@"PingFang SC" size: 14];
    _infoLabel.numberOfLines=0;
    [_infoBgView addSubview:_infoLabel];
    
}
-(void)setNav{
    self.titleView.type = TitleViewType_title;
    [self.titleView setTitle:@"关于我们"];
    self.nav.backgroundColor = [UIColor clearColor];
    self.backgroungImgView.hidden=YES;
}
-(void)getData{
    __weak typeof(self)weakSelf = self;
    [KDNetWorkManager GetHttpDataWithUrlStr:kArticles Dic:nil SuccessBlock:^(id obj) {
        NSLog(@"ttt===%@",obj);
        weakSelf.infoLabel.text =obj[@"data"][@"post_content"];
        [weakSelf.infoLabel sizeToFit];
        weakSelf.infoBgView.height =weakSelf.infoLabel.height+48;
        
    } FailureBlock:^(id obj) {
        
    }];
}
@end
