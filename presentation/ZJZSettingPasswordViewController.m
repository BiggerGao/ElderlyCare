//
//  ZJZSettingPasswordViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/23.
//
//

#import "ZJZSettingPasswordViewController.h"
#import "ZJZSettingPhotoViewController.h"
#import "Color-Tool.h"

@interface ZJZSettingPasswordViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *passwordTxtField;

@end

@implementation ZJZSettingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZJZColor(240, 240, 240, 1);
    self.navigationItem.title = @"注册2/3";

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, self.view.bounds.size.width - 90, 30)];
    label.text = @"请设置密码";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, 50)];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 50, 25)];
    pwdLabel.text = @"密码";
    pwdLabel.textColor = [UIColor blackColor];
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    pwdLabel.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:pwdLabel];
    
    _passwordTxtField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"6-20位字母或数字"];
    _passwordTxtField.secureTextEntry = true;
    [_bgView addSubview:_passwordTxtField];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(10, _bgView.frame.origin.y +_bgView.frame.size.height + 30, _bgView.frame.size.width, 37);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTintColor:[UIColor whiteColor]];
    nextButton.backgroundColor = ZJZColor(213, 54, 65, 1);
    nextButton.layer.cornerRadius = 5.0f;
    [nextButton addTarget:self action:@selector(postRegisterPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
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

- (void)postRegisterPassword {
    if (_passwordTxtField.text.length < 6) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码过短" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if(_passwordTxtField.text.length > 20) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码过长" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    _registerKeeper.password = _passwordTxtField.text;
    ZJZSettingPhotoViewController *settingPhotoViewController = [[ZJZSettingPhotoViewController alloc] init];
    settingPhotoViewController.registerKeeper = _registerKeeper;
    [self.navigationController pushViewController:settingPhotoViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
