//
//  ZJZDeviceIDViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/28.
//
//

#import "ZJZDeviceIDViewController.h"
#import "ZJZSettingOlderInfoViewController.h"

#import "Color-Tool.h"

@interface ZJZDeviceIDViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *deviceIDTxtField;
@end

@implementation ZJZDeviceIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ZJZColor(240, 240, 240, 1);
    self.navigationItem.title = @"绑定设备";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, self.view.bounds.size.width - 90, 30)];
    label.text = @"请输入设备ID";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, 50)];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgView];
    
    
    UILabel *deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 50, 25)];
    deviceLabel.text = @"设备ID";
    deviceLabel.textColor = [UIColor blackColor];
    deviceLabel.textAlignment = NSTextAlignmentLeft;
    deviceLabel.font = [UIFont systemFontOfSize:14];
    
    _deviceIDTxtField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"绑定设备ID"];
    _deviceIDTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *nextButton = [self createButtonFrame:CGRectMake(_bgView.frame.origin.x + 10, _bgView.frame.origin.y + _bgView.frame.size.height + 30, _bgView.frame.size.width - 20, 37) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(postDeviceID)];
    nextButton.backgroundColor = ZJZColor(213, 54, 65, 1);
    nextButton.layer.cornerRadius = 5.0f;
    [nextButton setTintColor:[UIColor whiteColor]];
    
    [_bgView addSubview:deviceLabel];
    [_bgView addSubview:self.deviceIDTxtField];
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

- (void)postDeviceID
{
    ZJZSettingOlderInfoViewController *settingOlderInfoViewController = [[ZJZSettingOlderInfoViewController alloc] init];
    settingOlderInfoViewController.oldMan.keeperID = _keeperID;
    settingOlderInfoViewController.oldMan.deviceID = _deviceIDTxtField.text;
    [self.navigationController pushViewController:settingOlderInfoViewController animated:YES];
}
@end
