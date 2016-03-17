//
//  ZJZLoginViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import "ZJZRegisterViewController.h"
#import "ZJZLoginViewController.h"
#import "ZJZTextFieldBackground.h"
#import "ZJZKeeperBL.h"
#import "ZJZKeeper.h"
#import "ZFConst.h"
#import "GlobalVariables.h"

@interface ZJZLoginViewController ()

@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) ZJZTextFieldBackground *background;

@end

@implementation ZJZLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:216/255.0f green:209/255.0f blue:192/255.0f alpha:1]];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.title = @"请登录";
    
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
    [_registerButton addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkKeeperAccount:)
                                                 name:@"FindkeeperInfoNoti"
                                               object:nil];

    // 读取账号
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
        NSLog(@"filePAth:%@",[self getFilePath]);
        NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        ZJZKeeper *keeper = [unarchiver decodeObjectForKey:kKeeperKey];
        [unarchiver finishDecoding];
        
        _account.text = keeper.account;
        _password.text = keeper.password;
    }
    
}

- (void)registerBtnClicked {
    [self.navigationController pushViewController:[[ZJZRegisterViewController alloc] init]
                                         animated:YES];
}

- (void)loginBtnClicked {
    // 空输入
    if ([[_account text] isEqualToString:@""] || [[_password text] isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账号或密码不能为空"
                                                            message:@"账号或密码不能为空"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    // 检查账号
    ZJZKeeperBL *keeperBL = [[ZJZKeeperBL alloc] init];
    ZJZKeeper *inputInfo = [[ZJZKeeper alloc] initWithAccount:[_account text] password:[_password text]];
    
    [keeperBL findKeeper:inputInfo];
}

- (void)checkKeeperAccount:(NSNotification*)noti {
    NSArray *keepers = [noti object];
    if (keepers.count == 0 || !keepers) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账号或密码错误"
                                                            message:@"账号或密码错误"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

        return;
    }

    // 登陆成功，跳转，保存账号
    ZJZKeeper *keeper = [[ZJZKeeper alloc] init];
    keeper.account = _account.text;
    keeper.password = _password.text;
    [self savekeeperAccountWhenLogIn:keeper];
    // 保存当前用户(看护人)
    [GlobalVariables setCurrKeeper:keeper];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotification" object:keeper];
}

#pragma mark - 保存用户账号
- (void)savekeeperAccountWhenLogIn:(ZJZKeeper *)keeper{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:keeper forKey:kKeeperKey];
    
    [archiver finishEncoding];
    NSLog(@"%@", [self getFilePath]);
    [data writeToFile:[self getFilePath] atomically:YES];
}

- (NSString *)getFilePath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [array[0] stringByAppendingPathComponent:kFileName];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
