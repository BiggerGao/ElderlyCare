//
//  ZJZLoginViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import "ZJZLoginViewController.h"
#import "ZJZTextFieldBackground.h"
#import "ZJZUserInfoBL.h"
#import "ZJZUserInfo.h"
#import "ZFConst.h"

@interface ZJZLoginViewController ()

@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) ZJZTextFieldBackground *background;

@end

@implementation ZJZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _background = [[ZJZTextFieldBackground alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 100)];
    [_background setBackgroundColor:ZFColor(245, 245, 245, 1)];
    [[_background layer] setCornerRadius:5.0];
    [[_background layer] setMasksToBounds:YES];
    [self.view addSubview:_background];
    
    _account = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 50)];
    _account.layer.cornerRadius = 5.0;
    _account.backgroundColor=[UIColor clearColor];
    _account.placeholder=[NSString stringWithFormat:@"账号:"];
    [_background addSubview:_account];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-40, 50)];
    _password.layer.cornerRadius = 5.0;
    _password.backgroundColor=[UIColor clearColor];
    _password.placeholder=[NSString stringWithFormat:@"密码:"];
    _password.secureTextEntry = YES;
    [_background addSubview:_password];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 220, (self.view.frame.size.width-60)/2, 50)];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:ZFColor(0, 191, 255, 1)];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 5.0;
    [_loginButton addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_registerButton setFrame:CGRectMake(30+(self.view.frame.size.width-60)/2, 220, (self.view.frame.size.width-40)/2, 50)];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:ZFColor(255, 185, 15, 1)];  // 205 149 12
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _registerButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_registerButton];

}

- (void) loginBtnClicked {
    if ([[_account text] isEqualToString:@""] || [[_password text] isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账号或密码不能为空"
                                                            message:@"账号或密码不能为空"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    ZJZUserInfoBL *infoBL = [ZJZUserInfoBL new];
    [infoBL findAllUsers];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkUserAccount:)
                                                 name:@"AllUsersInfoNoti"
                                               object:nil];
    
}

- (void)checkUserAccount:(NSNotification*)noti {
    NSArray *users = [noti object];
    for (ZJZUserInfo *user in users) {
        if ([user.account isEqualToString:[_account text]])
        {
            if ([user.password isEqualToString:[_password text]])
            {
                [self.view removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotification" object:[_account text]];
                return;
            }
            else
            {
                break;
            }
        }
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账号或密码错误"
                                                        message:@"账号或密码错误"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) registerBtnClicked {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
