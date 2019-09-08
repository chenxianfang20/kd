//
//  KDScanQRViewController.m
//  Kuaidi
//
//  Created by ljp on 2019/9/1.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDScanQRViewController.h"
#import "WSLScanView.h"
#import "WSLNativeScanTool.h"
#import "KDExpressSendInfoController.h"

@interface KDScanQRViewController ()

@property (nonatomic, strong)  WSLNativeScanTool * scanTool;
@property (nonatomic, strong)  WSLScanView * scanView;

@end

@implementation KDScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self createSubViews];
}

-(void)setNav{
    
    [self.backButton setImage:[UIImage imageNamed:@"图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image = [UIImage imageWithColor:rgb(223, 47, 49, 1)];
    self.titleView.titleLable.font = PingFangBold(20);
    self.titleView.titleLable.textColor = rgb(255, 255, 255, 1.0);
    self.titleView.titleLable.text = @"二维码/条码";
    self.titleView.titleLable.hidden = NO;
    
}

- (void)createSubViews{
    
    //输出流视图
    UIView *preview  = [[UIView alloc] initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight - NavibarH)];
    [self.view addSubview:preview];
    
    __weak typeof(self) weakSelf = self;
    
    //构建扫描样式视图
    _scanView = [[WSLScanView alloc] initWithFrame:CGRectMake(0, NavibarH, kScreenWidth, kScreenHeight - NavibarH)];
    _scanView.scanRetangleRect = CGRectMake(60, 120, (self.view.frame.size.width - 2 * 60),  (self.view.frame.size.width - 2 * 60));
    _scanView.colorAngle = [UIColor greenColor];
    _scanView.photoframeAngleW = 20;
    _scanView.photoframeAngleH = 20;
    _scanView.photoframeLineW = 2;
    _scanView.isNeedShowRetangle = YES;
    _scanView.colorRetangleLine = [UIColor whiteColor];
    _scanView.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _scanView.animationImage = [UIImage imageNamed:@"scanLine"];
    _scanView.flashSwitchBlock = ^(BOOL open) {
        [weakSelf.scanTool openFlashSwitch:open];
    };
    [self.view addSubview:_scanView];
    
    //初始化扫描工具
    _scanTool = [[WSLNativeScanTool alloc] initWithPreview:preview andScanFrame:_scanView.scanRetangleRect];
    _scanTool.scanFinishedBlock = ^(NSString *scanString) {
//        NSLog(@"扫描结果 %@",scanString);
        [weakSelf.scanView handlingResultsOfScan];
        
        KDExpressSendInfoController *vc = [[KDExpressSendInfoController alloc] init];
        vc.scanString = scanString;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        [weakSelf.scanTool sessionStopRunning];
        [weakSelf.scanTool openFlashSwitch:NO];
    };
    _scanTool.monitorLightBlock = ^(float brightness) {
//        NSLog(@"环境光感 ： %f",brightness);
        if (brightness < 0) {
            // 环境太暗，显示闪光灯开关按钮
            [weakSelf.scanView showFlashSwitch:YES];
        }else if(brightness > 0){
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(!weakSelf.scanTool.flashOpen){
                [weakSelf.scanView showFlashSwitch:NO];
            }
        }
    };
    
    [_scanTool sessionStartRunning];
    [_scanView startScanAnimation];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_scanView startScanAnimation];
    [_scanTool sessionStartRunning];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_scanView stopScanAnimation];
    [_scanView finishedHandle];
    [_scanView showFlashSwitch:NO];
    [_scanTool sessionStopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
