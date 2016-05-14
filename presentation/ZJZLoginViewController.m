//
//  ZJZLoginViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import "ZJZRegisterViewController.h"
#import "ZJZLoginViewController.h"
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>

#import "ZJZKeeperDAO.h"
#import "ZJZKeeper.h"
#import "ZFConst.h"
#import "Color-Tool.h"
#import "GlobalVariablesManager.h"

@interface ZJZLoginViewController ()

@property (nonatomic, strong) UITextField *telTxtField;
@property (nonatomic, strong) UITextField *passwordTxtField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *QQBtn;
@property (nonatomic, strong) UIButton *weixinBtn;
@property (nonatomic, strong) UIButton *xinlangBtn;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bgView;


@end

@implementation ZJZLoginViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UIImage *image = [UIImage imageNamed:@"imagebg"];
        _imageView.image = image;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登陆";

    [self.view addSubview:self.imageView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = item;
    
    [self createButtons];
    [self createImageViews];
    [self createTextFields];
    
    [self createLabel];
    
    // 读取账号
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
        NSLog(@"filePath:%@",[self getFilePath]);
        NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        ZJZKeeper *keeper = [unarchiver decodeObjectForKey:kKeeperKey];
        [unarchiver finishDecoding];
        
        _telTxtField.text = keeper.tel;
        _passwordTxtField.text = keeper.password;
    }
    
}


- (void)loginBtnClicked {
    // 空输入
    if ([_telTxtField.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入手机号"];
        return;
    }
    else if (_telTxtField.text.length <11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        return;
    }
    else if ([_passwordTxtField.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入密码"];
        return;
    }
    else if (_passwordTxtField.text.length <6)
    {
        [SVProgressHUD showInfoWithStatus:@"亲,密码长度至少六位"];
        return;
    }
    // 检查账号
    ZJZKeeperDAO *keeperDAO = [ZJZKeeperDAO sharedManager];
    keeperDAO.loginDelegate = self;
    ZJZKeeper *inputInfo = [[ZJZKeeper alloc] initWithTel:[_telTxtField text] password:[_passwordTxtField text]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [keeperDAO findKeeper:inputInfo];
}

#pragma mark - 点击事件
-(void)forgetPwd:(UIButton *)button
{
//    [self.navigationController pushViewController:[[forgetPassWardViewController alloc]init] animated:YES];
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerBtnClicked {
    [self.navigationController pushViewController:[[ZJZRegisterViewController alloc] init] animated:YES];
}


- (void)onClickQQ:(UIButton *)button
{
}

- (void)onClickWX:(UIButton *)button
{
}

- (void)onClickSina:(UIButton *)button
{
    
}

#pragma mark - create UI

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
    _bgView.layer.cornerRadius=3.0;
    _bgView.alpha=0.7;
    _bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    _telTxtField=[self createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    //user.text=@"13419693608";
    _telTxtField.keyboardType=UIKeyboardTypeNumberPad;
    _telTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _passwordTxtField=[self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    _passwordTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    _passwordTxtField.secureTextEntry=YES;
    
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, _bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [_bgView addSubview:_telTxtField];
    [_bgView addSubview:_passwordTxtField];
    
    [_bgView addSubview:userImageView];
    [_bgView addSubview:pwdImageView];
    [_bgView addSubview:line1];
}

-(void)createImageViews
{
    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    [self.view addSubview:line3];
    [self.view addSubview:line4];
}

-(void)createButtons
{
    UIButton *loginBtn=[self createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(loginBtnClicked)];
    loginBtn.backgroundColor = ZJZColor(213, 54, 65, 1);
    loginBtn.layer.cornerRadius=5.0f;
    
    UIButton *registerBtn=[self createButtonFrame:CGRectMake(5, 235, 70, 30) backImageName:nil title:@"快速注册" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registerBtnClicked)];
    registerBtn.tintColor = [UIColor whiteColor];
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(forgetPwd:)];
    forgotPwdBtn.tintColor = [UIColor whiteColor];
    
    //微信
    _weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
    //_weixinBtn.tag = UMSocialSnsTypeWechatSession;
    _weixinBtn.layer.cornerRadius=25;
    _weixinBtn=[self createButtonFrame:_weixinBtn.frame backImageName:@"ic_landing_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
    //qq
    _QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    _QQBtn.layer.cornerRadius=25;
    _QQBtn=[self createButtonFrame:_QQBtn.frame backImageName:@"ic_landing_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
    
    //新浪微博
    _xinlangBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    _xinlangBtn.layer.cornerRadius=25;
    _xinlangBtn=[self createButtonFrame:_xinlangBtn.frame backImageName:@"ic_landing_microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
    [self.view addSubview:_weixinBtn];
    [self.view addSubview:_QQBtn];
    [self.view addSubview:_xinlangBtn];
    [self.view addSubview:loginBtn];
    [self.view addSubview:registerBtn];
    [self.view addSubview:forgotPwdBtn];
}
-(void)createLabel
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
    label.text=@"第三方账号快速登录";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
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

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

#pragma mark - login delegate method
- (void)foundKeeper:(ZJZKeeper *)inputKeeper {
    // 登陆成功，跳转，保存账号
    ZJZKeeper *keeper = [[ZJZKeeper alloc] init];
    keeper.tel = _telTxtField.text;
    keeper.password = _passwordTxtField.text;
    [self savekeeperAccountWhenLogIn:keeper];
    
    [[GlobalVariablesManager sharedManager] setCurrKeeper:inputKeeper];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [self.delegate transferKeeperInfo:inputKeeper];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keeperIsNotExist {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [SVProgressHUD showInfoWithStatus:@"账号或密码错误"];
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

- (void)viewWillDisappear:(BOOL)animated {
    
}

@end
