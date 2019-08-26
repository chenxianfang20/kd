//
//  KDNewAddressVC.m
//  Kuaidi
//
//  Created by cxf on 2019/8/19.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDNewAddressVC.h"
#import "CityChoose.h"
@interface KDNewAddressVC(){
    NSInteger i;
    UIButton* addressLibBtn;
}
@property (nonatomic,strong) UITextField* nameTF;
@property (nonatomic,strong) UITextField* phoneTF;
@property (nonatomic,strong) UILabel* myAreaLabel;;
@property (nonatomic,strong) UITextField* detailAddressTF;
@property (nonatomic, strong) CityChoose *cityChoose;    //** 城市选择

@property (nonatomic,strong) NSString *province_name;
@property (nonatomic,strong) NSString *city_name;
@property (nonatomic,strong) NSString *district_name;

@end
@implementation KDNewAddressVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self addChildViews];
    if(self.addressModel){
        [self AddressModel:self.addressModel andTitle:@"编辑地址"];
    }
}


-(void)addChildViews{
    UIView* topBgView =[[UIView alloc]initWithFrame:CGRectMake(kLeftX, NavibarH+8, kAdaptationWidth(339), kAdaptationWidth(224))];
    topBgView.backgroundColor=[UIColor whiteColor];
    topBgView.layer.cornerRadius=10.0f;
    topBgView.layer.masksToBounds=YES;
    [self.view addSubview:topBgView];
    
    //姓名
    UILabel* nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(18), kAdaptationWidth(60), kAdaptationWidth(18))];
    nameLabel.font=PingFangRegular(14);
    nameLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    nameLabel.text=@"收件人";
    [topBgView addSubview:nameLabel];
    self.nameTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(5), kAdaptationWidth(170), kAdaptationWidth(45))];
    self.nameTF.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    self.nameTF.font= PingFangRegular(14);
    self.nameTF.placeholder=@"请选择或者填写姓名";
    [self.nameTF setValue: PingFangRegular(14) forKeyPath:@"_placeholderLabel.font"];
    [topBgView addSubview:self.nameTF];
    //self.nameTF.clearButtonMode=UITextFieldViewModeAlways;
    //[self.nameTF addTarget:self action:@selector(phoneTFChanged:) forControlEvents:UIControlEventEditingChanged];
    self.nameTF.centerY =nameLabel.centerY;
    
    UIImageView* rightNameImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(303), kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(18))];
    rightNameImgView.image = [UIImage imageNamed:@"图标-通讯录"];
    [topBgView addSubview:rightNameImgView];
    rightNameImgView.centerY=nameLabel.centerY;
    
    //联系电话
    UILabel* phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(57), kAdaptationWidth(60), kAdaptationWidth(18))];
    phoneLabel.font=PingFangRegular(14);
    phoneLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    phoneLabel.text=@"联系电话";
    [topBgView addSubview:phoneLabel];
    self.phoneTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(44), kAdaptationWidth(170), kAdaptationWidth(45))];
    self.phoneTF.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    self.phoneTF.font= PingFangRegular(14);
    self.phoneTF.placeholder=@"请选择或者填写联系电话";
    self.phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    [self.phoneTF setValue: PingFangRegular(14) forKeyPath:@"_placeholderLabel.font"];
    [topBgView addSubview:self.phoneTF];
     [self.phoneTF addTarget:self action:@selector(phoneTFChanged:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.centerY =phoneLabel.centerY;
    
    //选择地区
    UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(95), kAdaptationWidth(60), kAdaptationWidth(18))];
    areaLabel.font=PingFangRegular(14);
    areaLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    areaLabel.text=@"选择地区";
    [topBgView addSubview:areaLabel];
    self.myAreaLabel=[[UILabel alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(5), kAdaptationWidth(170), kAdaptationWidth(45))];
    self.myAreaLabel.textColor=rgb(204, 204, 209, 1);
    self.myAreaLabel.font= PingFangRegular(14);
    self.myAreaLabel.text=@"请选择地区";
    [topBgView addSubview:self.myAreaLabel];
    self.myAreaLabel.numberOfLines=0;
    self.myAreaLabel.centerY =areaLabel.centerY;
    UIButton* areaBtn = [[UIButton alloc]initWithFrame:self.myAreaLabel.frame];
    [areaBtn addTarget:self action:@selector(areaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:areaBtn];
    
    UIImageView* rightAreaImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdaptationWidth(303), kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(18))];
    rightAreaImgView.image = [UIImage imageNamed:@"地址-图标-地址"];
    [topBgView addSubview:rightAreaImgView];
    rightAreaImgView.centerY=areaLabel.centerY;
    
    //详细地址
    UILabel* detailAddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(133), kAdaptationWidth(60), kAdaptationWidth(18))];
    detailAddressLabel.font=PingFangRegular(14);
    detailAddressLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    detailAddressLabel.text=@"详细地址";
    [topBgView addSubview:detailAddressLabel];
    self.detailAddressTF=[[UITextField alloc]initWithFrame:CGRectMake(kAdaptationWidth(90), kAdaptationWidth(133), kAdaptationWidth(170), kAdaptationWidth(45))];
    self.detailAddressTF.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    self.detailAddressTF.font= PingFangRegular(14);
    self.detailAddressTF.placeholder=@"请详细到门牌号";
    [self.detailAddressTF setValue: PingFangRegular(14) forKeyPath:@"_placeholderLabel.font"];
    [topBgView addSubview:self.detailAddressTF];
 
    self.detailAddressTF.centerY =detailAddressLabel.centerY;
    
    UILabel* sepLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(164), kAdaptationWidth(303), 1)];
    sepLabel.backgroundColor=[UIColor colorWithHex:@"#F1F1F1"];
    [topBgView addSubview:sepLabel];
    
    //保存到地址库
    UILabel* saveAddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(188), kAdaptationWidth(160), kAdaptationWidth(18))];
    saveAddressLabel.font=PingFangRegular(14);
    saveAddressLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    saveAddressLabel.text=@"保存到地址库";
    [topBgView addSubview:saveAddressLabel];
    
    addressLibBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(303), kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(18))];
    [addressLibBtn  setBackgroundImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
    [topBgView addSubview:addressLibBtn];
    addressLibBtn.selected = NO;
    addressLibBtn.centerY=saveAddressLabel.centerY;
    
    UIButton* saveAddressBtn =[[UIButton alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(188),kScreenWidth- kAdaptationWidth(18), kAdaptationWidth(25))];
    [topBgView addSubview:saveAddressBtn];
    [saveAddressBtn addTarget:self action:@selector(saveAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    saveAddressBtn.centerY=saveAddressLabel.centerY;
    
    //
    UIView* midBgView =[[UIView alloc]initWithFrame:CGRectMake(kLeftX, topBgView.bottom+12, kAdaptationWidth(339), kAdaptationWidth(132))];
    midBgView.backgroundColor=[UIColor whiteColor];
    midBgView.layer.cornerRadius=10.0f;
    midBgView.layer.masksToBounds=YES;
    [self.view addSubview:midBgView];
    
    //智能识别
    UILabel* zsLabel=[[UILabel alloc]initWithFrame:CGRectMake(kLeftX, kAdaptationWidth(21), kAdaptationWidth(160), kAdaptationWidth(18))];
    zsLabel.font=PingFangRegular(14);
    zsLabel.textColor=[UIColor colorWithHex:@"#5C5C5C"];
    zsLabel.text=@"智能识别";
    [midBgView addSubview:zsLabel];
    
    UIButton * albumBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(267), kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(18))];
    [albumBtn  setBackgroundImage:[UIImage imageNamed:@"地址-图标-照片"] forState:UIControlStateNormal];
    [midBgView addSubview:albumBtn];
    albumBtn.centerY=zsLabel.centerY;
    
    UIButton* voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(303), kAdaptationWidth(18), kAdaptationWidth(18), kAdaptationWidth(18))];
    [voiceBtn  setBackgroundImage:[UIImage imageNamed:@"地址-图标-语音"] forState:UIControlStateNormal];
    [midBgView addSubview:voiceBtn];
    voiceBtn.centerY=zsLabel.centerY;
    
    UILabel* noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, midBgView.bottom+ kAdaptationWidth(18), kScreenWidth, kAdaptationWidth(18))];
    noticeLabel.font=PingFangMedium(13) ;
    noticeLabel.textColor=[UIColor colorWithHex:@"#DF2F31"];
    noticeLabel.text=@"温馨提示：国际速运只需填写收件人的姓名，以及联系方式。";
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:noticeLabel];
    
    //保存信息按钮
    UIButton*  saveInfoBtn=[[UIButton alloc]initWithFrame:CGRectMake(kAdaptationWidth(18),kScreenHeight- kAdaptationWidth(74), kAdaptationWidth(339), kAdaptationWidth(54))];
    [saveInfoBtn setTitle:@"保存信息" forState:UIControlStateNormal];
    [saveInfoBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [saveInfoBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"#DF2F31"]] forState:UIControlStateNormal];
    saveInfoBtn.layer.cornerRadius=kAdaptationWidth(8);
    saveInfoBtn.layer.masksToBounds=YES;
    [saveInfoBtn addTarget:self action:@selector(saveInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:saveInfoBtn];
    
}

-(void)areaBtnClick{
    [self.view endEditing:YES];
    self.cityChoose = [[CityChoose alloc] init];
    __weak typeof(self) weakSelf = self;
    self.cityChoose.config = ^(NSString *province, NSString *city, NSString *town){
        weakSelf.myAreaLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town];
        weakSelf.province_name=province;
        weakSelf.city_name=city;
        weakSelf.district_name=town;
        weakSelf.myAreaLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    };
    [self.view addSubview:self.cityChoose];
}
-(void)saveInfoBtnClick{
    if(self.nameTF.text.length == 0){
        [self.view showToastWithText:@"请输入收件人姓名" time:1];
        return;
    }
    if(self.phoneTF.text.length == 0){
        [self.view showToastWithText:@"请输入11位手机号" time:1];
        return;
    }
    if([self.myAreaLabel.text isEqualToString:@"请选择地区"]){
        [self.view showToastWithText:@"请选择地区" time:1];
        return;
    }
    if(self.detailAddressTF.text.length == 0){
        [self.view showToastWithText:@"请输入详细地址" time:1];
        return;
    }
    NSString *phoneFieldStr =[self.phoneTF.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    if(![NSString isValidatePhoneNum:phoneFieldStr]){
        [self.view showToastWithText:@"手机号不合法" time:1];
        return;
    }
    KDUserModel* model = [KDUserModelTool userModel];
    NSDictionary* headData = @{@"XX-Token":model.token,@"XX-Device-Type":kDeviceType};
   
    __weak typeof(self) weakSelf =self;
    NSString* defaultFlag ;
    if( addressLibBtn.selected == NO){
        defaultFlag=@"0";
    }else if (addressLibBtn.selected == YES){
        defaultFlag=@"1";
    }
    
    NSString* url;
    NSString* noticeStr;
    NSDictionary* dic;
    if([self.myTitle isEqualToString:@"编辑地址"]){
        url=kUpdateAddress;
        noticeStr=@"编辑地址成功";
        dic= @{@"name":self.nameTF.text,@"mobile":phoneFieldStr,@"province_name":self.province_name,@"city_name":self.city_name,@"district_name":self.district_name,@"address":self.detailAddressTF.text,@"default":defaultFlag,@"id":self.addressModel.addressID};
    }else{
        url=kAddAddress;
        noticeStr=@"新增地址成功";
        dic= @{@"name":self.nameTF.text,@"mobile":phoneFieldStr,@"province_name":self.province_name,@"city_name":self.city_name,@"district_name":self.district_name,@"address":self.detailAddressTF.text,@"default":defaultFlag};
    }
    [KDNetWorkManager GetHttpDataWithUrlStr:url Dic:dic headDic:headData SuccessBlock:^(id obj) {
        if([obj[@"code"] integerValue] == 1){
            if(weakSelf.myBlock){
                weakSelf.myBlock();
            }
            [ZJCustomHud showWithSuccess:noticeStr];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } FailureBlock:^(id obj) {
        
    }];
    
    
}
-(void)phoneTFChanged:(UITextField*)textField{
    if (textField == self.phoneTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
            }
            i = textField.text.length;
            
        }else if (textField.text.length < i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}

-(void)saveAddressBtnClick{
    if(addressLibBtn.selected == YES){
        [addressLibBtn setBackgroundImage:[UIImage imageNamed:@"图标-未选"] forState:UIControlStateNormal];
        addressLibBtn.selected = NO;
    }else if(addressLibBtn.selected == NO){
        [addressLibBtn setBackgroundImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateNormal];
         addressLibBtn.selected = YES;
    }
}
-(void)AddressModel:(KDAddressAdminModel *)addressModel andTitle:(NSString*)title{
    self.myTitle=title;
    self.addressModel = addressModel;
    self.nameTF.text=addressModel.name;
    self.phoneTF.text=addressModel.mobile;
    self.province_name=addressModel.province_name;
    self.city_name=addressModel.city_name;
    self.district_name=addressModel.district_name;
    self.detailAddressTF.text=addressModel.address;
    self.myAreaLabel.text = [NSString stringWithFormat:@"%@ %@ %@",addressModel.province_name,addressModel.city_name,addressModel.district_name];
    [self.titleView setTitle:title];
    self.myAreaLabel.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    if(addressModel.isDefault.integerValue == 1){
        [addressLibBtn setBackgroundImage:[UIImage imageNamed:@"图标-选定"] forState:UIControlStateNormal];
        addressLibBtn.selected = YES;
    }
}

-(void)setNav{
    self.titleView.type = TitleViewType_title;
    self.titleView.titleLable.textColor=[UIColor colorWithHex:@"#0B0B0B"];
    [self.titleView setTitle:@"添加地址"];
    [self.backButton setImage:[UIImage imageNamed:@"注册-图标-后退"] forState:UIControlStateNormal];
    self.backgroungImgView.image=[UIImage imageWithColor:rgb(245, 245, 245, 1)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
