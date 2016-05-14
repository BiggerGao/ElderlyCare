//
//  ZJZAddOldManViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/28.
//
//

#import "ZJZAddOldManViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "Color-Tool.h"
#import "ZJZKeeper.h"

@interface ZJZAddOldManViewController ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *telTxtField;
@property (nonatomic, strong) UITextField *verificationCodeTxtField;

@property (nonatomic, assign) NSInteger *timeCount;
@property (nonatomic, strong) NSString *SMSID;

@end

@implementation ZJZAddOldManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZJZColor(240, 240, 240, 1);
    self.navigationItem.title = @"身份验证";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, self.view.bounds.size.width - 90, 30)];
    label.text = @"请输入看护人电话号码";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, 100)];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgView];
    
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 50, 25)];
    telLabel.text = @"手机号";
    telLabel.textColor = [UIColor blackColor];
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 62, 50, 25)];
    codeLabel.text = @"验证码";
    codeLabel.textColor = [UIColor blackColor];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    codeLabel.font = [UIFont systemFontOfSize:14];
    
    _telTxtField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"注册手机号"];
    _telTxtField.keyboardType = UIKeyboardTypePhonePad;
    _telTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _verificationCodeTxtField = [self createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"4位数字"];
    _verificationCodeTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *getCodeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    getCodeButton.frame = CGRectMake(_bgView.frame.size.width-100-20, 60, 100, 30);
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton setTintColor:[UIColor whiteColor]];
    [getCodeButton setTitleColor:ZJZColor(213, 54, 65, 1) forState:UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line = [self createImageViewFrame:CGRectMake(20, 50, _bgView.bounds.size.width-40, 1) imageName:nil color:ZJZColor(180, 180, 180, 0.3)];
    
    UIButton *registerButton = [self createButtonFrame:CGRectMake(_bgView.frame.origin.x + 10, _bgView.frame.origin.y + _bgView.frame.size.height + 30, _bgView.frame.size.width - 20, 37) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(postRegisterTel)];
    registerButton.backgroundColor = ZJZColor(213, 54, 65, 1);
    registerButton.layer.cornerRadius = 5.0f;
    [registerButton setTintColor:[UIColor whiteColor]];
    
    [_bgView addSubview:telLabel];
    [_bgView addSubview:codeLabel];
    
    
    [_bgView addSubview:_telTxtField];
    [_bgView addSubview:_verificationCodeTxtField];
    [_bgView addSubview:line];
    
    [_bgView addSubview:getCodeButton];
    [self.view addSubview:registerButton];
}

-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.font=font;
    textField.textColor=[UIColor grayColor];
    textField.borderStyle=UITextBorderStyleNone;
    textField.placeholder=placeholder;
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    if (color) {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=frame;
    if (imageName) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font=font;
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

#pragma mark - 手机验证码
- (void)getCode {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:_telTxtField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error) {
                                     if (!error) {
                                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"请查看验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                         [alertView show];
                                     } else {
                                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无效的电话" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                         [alertView show];
                                     }
                                 }];
}

- (void)postRegisterTel {
    if ([[_telTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [SMSSDK commitVerificationCode:_verificationCodeTxtField.text
                       phoneNumber:_telTxtField.text
                              zone:@"86"
                            result:^(NSError *error) {
                                if (!error) {
//                                    ZJZSettingPasswordViewController *settingPasswordViewController = [[ZJZSettingPasswordViewController alloc] init];
                                    ZJZKeeper *registerKeeper = [[ZJZKeeper alloc] init];
                                    registerKeeper.tel = _telTxtField.text;
//                                    settingPasswordViewController.registerKeeper = registerKeeper;
//                                    [self.navigationController pushViewController:settingPasswordViewController animated:YES];
                                } else {
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alertView show];
                                }
                            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
