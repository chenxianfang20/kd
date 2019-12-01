//
//  KDGoodsTypeInfoSelectView.m
//  Kuaidi
//
//  Created by ljp on 2019/8/17.
//  Copyright © 2019 ios01. All rights reserved.
//

#import "KDGoodsTypeInfoSelectView.h"
#import "KDGoodsListModel.h"

@interface KDGoodsTypeInfoSelectView()
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)NSMutableArray *buttonArr;

@property(nonatomic, strong)NSMutableArray *goodsArr;

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, copy)NSString *imageUrl;

@property(nonatomic, strong)UITextField *countLabel;

@property(nonatomic, strong)UIButton *subtractButton;

@property(nonatomic, strong)UIButton *addButton;

@property(nonatomic, strong)UIButton *addImageButton;

@property(nonatomic, copy)void(^confirmBlock)(NSInteger index, NSString *imageUrl, NSString *count);

@end

@implementation KDGoodsTypeInfoSelectView

+(void)showSelectViewWithGoodsArr:(NSMutableArray *)goodsArr
                           select:(NSInteger)index
                         imageUrl:(NSString *)imageUrl
                     confirmBlock:(void(^)(NSInteger index, NSString *imageUrl, NSString *count))confirmBlock{
    
    KDGoodsTypeInfoSelectView *view = [[KDGoodsTypeInfoSelectView alloc] initWithFrame:CGRectMake(18, 0, kScreenWidth - 36, 473) goodsArr:goodsArr select:index imageUrl:imageUrl];
    view.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    view.alpha = 0;
    view.confirmBlock = confirmBlock;
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = rgb(11, 11, 11, 0.72);
    view.bgView = bgView;
    bgView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(hidden)];
    [bgView addGestureRecognizer:tap];
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *currentVc = [view jsd_getCurrentViewController];
    [currentVc.view addSubview:bgView];
    [currentVc.view addSubview:view];
    
    [UIView animateWithDuration:.25 animations:^{
        
        view.alpha = 1.0;
        bgView.alpha = 1.0;
        
    }];
    
}

-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

-(instancetype)initWithFrame:(CGRect)frame goodsArr:(NSMutableArray *)goodsArr select:(NSInteger)index imageUrl:(NSString *)imageUrl{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goodsArr = goodsArr;
        
        self.index = index;
        
        self.imageUrl = imageUrl;
        
        if (self.index < 0 ) {
            self.index = 0;
        }
        
        [self createSubViews];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapClick{
    [self endEditing:YES];
    if (self.countLabel.text.length == 0) {
        self.countLabel.text = @"1";
    }
}

- (void)createSubViews{
    
    self.backgroundColor = rgb(255, 255, 255, 1);
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = rgb(11, 11, 11, 0.1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 24;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"物品信息";
    titleLabel.textColor = rgb(92, 92, 92, 1);
    titleLabel.font = PingFangBold(18);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.centerX.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(75, 17));
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"图标-关闭-大"] forState:UIControlStateNormal];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-21);
        make.centerY.equalTo(titleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [closeButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *goodsTitleLabel = [[UILabel alloc] init];
    goodsTitleLabel.text = @"物品类型（必填）";
    goodsTitleLabel.textColor = rgb(11, 11, 11, 1);
    goodsTitleLabel.font = PingFangBold(15);
    [self addSubview:goodsTitleLabel];
    [goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(titleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *notSendTipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notSendTipBtn setTitle:@"什么不能寄？" forState:UIControlStateNormal];
    [notSendTipBtn setTitleColor:rgb(49, 191, 189, 1) forState:UIControlStateNormal];
    notSendTipBtn.titleLabel.font = PingFangBold(14);
    notSendTipBtn.hidden = YES;
    [self addSubview:notSendTipBtn];
    [notSendTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(goodsTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(85, 14));
    }];
    
    NSInteger row = 4;
    CGFloat buttonW = 66;
    CGFloat buttonH = 30;
    CGFloat matgintW = (self.width - 36 - row * buttonW)/(row - 1);
    CGFloat matgintH = 12;
    for (NSInteger i = 0; i < self.goodsArr.count; i ++) {
        
        KDGoodsListModel *model = self.goodsArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.goods_name forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = PingFangMedium(13);
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 4;
        button.selected = (i == self.index);
        [self selectButtonConvert:button];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsTitleLabel.mas_bottom).offset(18 + (matgintH + buttonH) * (i/row));
            make.left.equalTo(self).offset(18 + (buttonW + matgintW) * (i%row));
            make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
        }];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
    }
    
    UILabel *weightTitleLabel = [[UILabel alloc] init];
    weightTitleLabel.text = @"物品重量（必填）";
    weightTitleLabel.textColor = rgb(11, 11, 11, 1);
    weightTitleLabel.font = PingFangBold(15);
    [self addSubview:weightTitleLabel];
    [weightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(goodsTitleLabel.mas_bottom).offset(161);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    UILabel *pictrueTitleLabel = [[UILabel alloc] init];
    pictrueTitleLabel.text = @"物品拍照（选填）";
    pictrueTitleLabel.textColor = rgb(11, 11, 11, 1);
    pictrueTitleLabel.font = PingFangBold(15);
    [self addSubview:pictrueTitleLabel];
    [pictrueTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(weightTitleLabel.mas_bottom).offset(29);
        make.size.mas_equalTo(CGSizeMake(120, 15));
    }];
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.text = @"公斤";
    unitLabel.textColor = rgb(92, 92, 92, 1);
    unitLabel.font = PingFangBold(15);
    [self addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-18);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
    }];
    
    KDGoodsListModel *model = self.goodsArr[self.index];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton = addButton;
    addButton.selected = model.goods_weight.integerValue < 30;
    [addButton setImage:[UIImage imageNamed:@"图标-增加-不可点击"] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"图标-增加-可以点击"] forState:UIControlStateSelected];
    [self addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-61);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITextField *countLabel = [[UITextField alloc] init];
    self.countLabel = countLabel;
    countLabel.text = model.goods_weight.stringValue;
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.keyboardType = UIKeyboardTypeNumberPad;
    countLabel.layer.borderWidth = 1;
    countLabel.layer.borderColor = rgb(240, 240, 240, 1.0).CGColor;
    countLabel.layer.cornerRadius = 3;
    countLabel.textColor = rgb(11, 11, 11, 1);
    countLabel.font = PingFangBold(20);
    [self addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addButton.mas_left).offset(-3);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(42, 24));
    }];
    
    UIButton *subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subtractButton = subtractButton;
    subtractButton.selected = model.goods_weight.integerValue > 1;
    [subtractButton setImage:[UIImage imageNamed:@"图标-减少-不可点击"] forState:UIControlStateNormal];
    [subtractButton setImage:[UIImage imageNamed:@"图标-减少-可以点击"] forState:UIControlStateSelected];
    [self addSubview:subtractButton];
    [subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countLabel.mas_left).offset(-3);
        make.centerY.equalTo(weightTitleLabel.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [subtractButton addTarget:self action:@selector(subtractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addImageButton = addImageButton;
    [addImageButton setImage:[UIImage imageNamed:@"图标-上传照片"] forState:UIControlStateNormal];
    [self addSubview:addImageButton];
    [addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(pictrueTitleLabel.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    if (self.imageUrl) {
        [addImageButton.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"图标-上传照片"]];
    }
    [addImageButton addTarget:self action:@selector(uploadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"照片可以帮助快递小哥判断物品的大小以及选择合适的运输工具。";
    tipLabel.textColor = rgb(169, 169, 169, 1);
    tipLabel.numberOfLines = 0;
    tipLabel.font = PingFangMedium(13);
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addImageButton.mas_right).offset(19);
        make.right.equalTo(self).offset(-22);
        make.centerY.equalTo(addImageButton.mas_centerY).offset(0);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = rgb(223, 47, 49, 1);
    confirmButton.layer.cornerRadius = 24;
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:rgb(255, 255, 255, 1) forState:UIControlStateNormal];
    confirmButton.titleLabel.font = PingFangBold(15);
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.bottom.equalTo(self).offset(-18);
        make.height.mas_equalTo(48);
    }];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button{
    self.index = button.tag;
    for (UIButton *button in self.buttonArr) {
        button.selected = NO;
        [self selectButtonConvert:button];
    }
    button.selected = YES;
    [self selectButtonConvert:button];
}

- (void)confirmButtonClick:(UIButton *)button{
    
    [self hidden];
    
    if (self.confirmBlock) {
        self.confirmBlock(self.index, self.imageUrl, self.countLabel.text);
    }
    
}

-(void)selectButtonConvert:(UIButton *)button{
    
    if (button.selected) {
        button.layer.borderColor = rgb(223, 47, 49, 1).CGColor;
        [button setTitleColor:rgb(223, 47, 49, 1) forState:UIControlStateNormal];
    }else{
        button.layer.borderColor = rgb(169, 169, 169, 1).CGColor;
        [button setTitleColor:rgb(169, 169, 169, 1) forState:UIControlStateNormal];
    }
    
}

- (void)hidden{
    
    [self endEditing:YES];
    
    if (self.countLabel.text.length == 0) {
        self.countLabel.text = @"1";
    }
    
    [UIView animateWithDuration:.25 animations:^{
        
        self.alpha = 0.0;
        self.bgView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

- (void)addButtonClick:(UIButton *)button{
    
    NSInteger count = self.countLabel.text.integerValue;
    if (count >= 30) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count + 1];
    button.selected = count + 1 < 30;
    self.subtractButton.selected = count + 1 > 1;
    
}

- (void)subtractButtonClick:(UIButton *)button{
    
    NSInteger count = self.countLabel.text.integerValue;
    if (count <= 1) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count - 1];
    button.selected = count - 1 > 1;
    self.addButton.selected = count - 1 < 30;
}

//选择头像
#pragma mark - TZImagePickerController
- (void)uploadButtonAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择圈子头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.navigationBar.barTintColor = rgb(33, 33, 33, 1.0);
        //COLOR_WITH_HEX(0x333333);
        UIViewController *currentVc = [self jsd_getCurrentViewController];
        [currentVc presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"现场拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.navigationBar.barTintColor = rgb(33, 33, 33, 1.0);
            //COLOR_WITH_HEX(0x333333);
            UIViewController *currentVc = [self jsd_getCurrentViewController];
            [currentVc presentViewController:picker animated:YES completion:nil];
            
        }else{
            
            [ZJCustomHud showWithText:@"摄像头不可用！" WithDurations:2.0];
            [alertController dismissViewControllerAnimated:YES completion:nil];
            
        }
        
        
    }];
    
    UIAlertAction *cancelActionS = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:photoAction];
    
    [alertController addAction:takeAction];
    
    [alertController addAction:cancelActionS];
    
    UIViewController *currentVc = [self jsd_getCurrentViewController];
    
    [currentVc presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSData *data = UIImageJPEGRepresentation(avatarImage, 1.0f);
    
    NSUInteger maxLength = 200000;
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(avatarImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(avatarImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        
        [avatarImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        avatarImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(avatarImage, 1);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *fileNameStr = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
    DKNetFileParam *param = [[DKNetFileParam alloc] init];
    param.data = data;
    param.fileName = fileNameStr;
    param.name = @"file";
    param.mimeType = @"audio/mpeg";
    
//    UIViewController *currentVc = [self jsd_getCurrentViewController];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"上传中...",@"HUD loading title");
    
    [KDNetWorkManager uploadFileWithUrlStr:uploadOrderImageUrl params:@{@"file":fileNameStr} uploadProgress:^(NSProgress *uploadProgress) {
        
        dispatch_async_main_safe(^{
            CGFloat progress = uploadProgress.completedUnitCount/@(uploadProgress.totalUnitCount).floatValue;
            hud.progress = progress;
        })
        
    } successBlock:^(NSDictionary *dataDic) {
        [hud hideAnimated:YES];
        //上传成功获取URL显示图片
        NSNumber *code = dataDic[@"code"];
        if (code.intValue == 1) {
            NSString *urlStr = dataDic[@"data"][@"url"];
            self.imageUrl = [NSString stringWithFormat:@"%@%@",kBaseUrl,urlStr];
            [self.addImageButton setImage:avatarImage forState:UIControlStateNormal];
        }else{
            NSString *errMsg = dataDic[@"msg"];
            [ZJCustomHud showWithText:errMsg WithDurations:2.0];
        }
        
    } failureBlock:^(NSError *error) {
        [hud hideAnimated:YES];
        [ZJCustomHud showWithText:@"网络错误，请重新上传！" WithDurations:2.0];
    } uploadParam:param];
}

- (UIViewController *)jsd_getCurrentViewController{
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

- (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

@end
