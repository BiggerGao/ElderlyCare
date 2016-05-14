//
//  ZJZSettingOlderInfoViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/28.
//
//

#import "ZJZSettingOlderInfoViewController.h"
#import "ZJZPickerViewController.h"
#import "Color-Tool.h"

#define kSexTag 101
#define kAgeTag 102
#define kHeightTag 103
#define kWeightTag 104
#define kIllnessTag 105

@interface ZJZSettingOlderInfoViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *nameTxtField;
@property (nonatomic, strong) UITextField *relationalTxtField;
@property (nonatomic, strong) UIButton *sexButton;
@property (nonatomic, strong) UIButton *ageButton;
@property (nonatomic, strong) UIButton *heightButton;
@property (nonatomic, strong) UIButton *weightButton;
@property (nonatomic, strong) UIButton *illnessButton;

@property (nonatomic, assign) NSInteger currTag;
/** 体重 */
@property (nonatomic, strong) NSArray *weightArray;
/** 身高 */
@property (nonatomic, strong) NSArray *heightArray;
/** 年龄 */
@property (nonatomic, strong) NSArray *ageArray;
/** 性别 */
@property (nonatomic, strong) NSArray *sexArray;
/** 疾病 */
@property (nonatomic, strong) NSArray *illnessArray;
@end

@implementation ZJZSettingOlderInfoViewController

#pragma mark - 数据懒加载
- (NSArray*)weightArray {
    if (!_weightArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Weight" ofType:@"plist"];
        _weightArray = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _weightArray;
}

- (ZJZOldMan*)oldMan {
    if (!_oldMan) {
        _oldMan = [[ZJZOldMan alloc] init];
    }
    return _oldMan;
}
- (NSArray*)heightArray {
    if (!_heightArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Height" ofType:@"plist"];
        _heightArray = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _heightArray;
}

- (NSArray*)ageArray {
    if (!_ageArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Age" ofType:@"plist"];
        _ageArray = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _ageArray;
}

- (NSArray*)sexArray {
    if (!_sexArray) {
        _sexArray = [[NSArray alloc] initWithObjects:@"男", @"女", nil];
    }
    return _sexArray;
}

- (NSArray*)illnessArray {
    if (!_illnessArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"illness" ofType:@"plist"];
        _illnessArray = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _illnessArray;
}

#pragma mark - entry
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZJZColor(240, 240, 240, 1);
    self.navigationItem.title = @"完善老人信息";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, self.view.bounds.size.width - 90, 30)];
    label.text = @"请完善老人信息";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, 350)];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    UILabel *nameLabel = [self createLabelFrame:CGRectMake(20, 12, 50, 25) text:@"姓 名" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *sexLabel = [self createLabelFrame:CGRectMake(20, 62, 50, 25) text:@"性 别" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *ageLabel = [self createLabelFrame:CGRectMake(20, 112, 50, 25) text:@"年 龄" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *heightLabel = [self createLabelFrame:CGRectMake(20, 162, 50, 25) text:@"身 高" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *weightLabel = [self createLabelFrame:CGRectMake(20, 212, 50, 25) text:@"体 重" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *illnessLabel = [self createLabelFrame:CGRectMake(20, 262, 50, 25) text:@"患 病" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    UILabel *relationalTelLabel = [self createLabelFrame:CGRectMake(20, 312, 60, 25) text:@"亲属电话" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14]];
    [_bgView addSubview:nameLabel];
    [_bgView addSubview:sexLabel];
    [_bgView addSubview:ageLabel];
    [_bgView addSubview:heightLabel];
    [_bgView addSubview:weightLabel];
    [_bgView addSubview:illnessLabel];
    [_bgView addSubview:relationalTelLabel];
    
    for (int i = 1; i < 7; i++) {
        UIImageView *line = [self createImageViewFrame:CGRectMake(20, i * 50, _bgView.bounds.size.width-40, 1) imageName:nil color:ZJZColor(180, 180, 180, 0.3)];
        [_bgView addSubview:line];
    }
    
    _nameTxtField = [self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"老人姓名"];
    _nameTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_nameTxtField];
    
    _sexButton = [self createButtonFrame:CGRectMake(100, 60, 200, 30) backgroundColor:[UIColor clearColor] title:@"请选择性别" titleColor:[UIColor grayColor]  font:[UIFont systemFontOfSize:14] target:self action:@selector(pickerBtnClicked:)];
    _sexButton.tag = kSexTag;
    _sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_bgView addSubview:_sexButton];
    
    _ageButton = [self createButtonFrame:CGRectMake(100, 110, 200, 30) backgroundColor:[UIColor clearColor] title:@"请选择年龄" titleColor:[UIColor grayColor]  font:[UIFont systemFontOfSize:14] target:self action:@selector(pickerBtnClicked:)];
    _ageButton.tag = kAgeTag;
    _ageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_bgView addSubview:_ageButton];
    
    _heightButton = [self createButtonFrame:CGRectMake(100, 160, 200, 30) backgroundColor:[UIColor clearColor] title:@"未填写" titleColor:[UIColor grayColor]  font:[UIFont systemFontOfSize:14] target:self action:@selector(pickerBtnClicked:)];
    _heightButton.tag = kHeightTag;
    _heightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_bgView addSubview:_heightButton];
    
    _weightButton = [self createButtonFrame:CGRectMake(100, 210, 200, 30) backgroundColor:[UIColor clearColor] title:@"未填写" titleColor:[UIColor grayColor]  font:[UIFont systemFontOfSize:14] target:self action:@selector(pickerBtnClicked:)];
    _weightButton.tag = kWeightTag;
    _weightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_bgView addSubview:_weightButton];
    
    _illnessButton = [self createButtonFrame:CGRectMake(100, 260, 200, 30) backgroundColor:[UIColor clearColor] title:@"未填写" titleColor:[UIColor grayColor]  font:[UIFont systemFontOfSize:14] target:self action:@selector(pickerBtnClicked:)];
    _illnessButton.tag = kIllnessTag;
    _illnessButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_bgView addSubview:_illnessButton];
    
    _relationalTxtField = [self createTextFielfFrame:CGRectMake(100, 310, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"亲属联系电话"];
    _relationalTxtField.keyboardType = UIKeyboardTypePhonePad;
    _relationalTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_relationalTxtField];
    
    UIButton *nextButton = [self createButtonFrame:CGRectMake(_bgView.frame.origin.x + 10, _bgView.frame.origin.y + _bgView.frame.size.height + 30, _bgView.frame.size.width - 20, 37) backgroundColor:ZJZColor(213, 54, 65, 1) title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(nextBtnClicked)];
    nextButton.layer.cornerRadius = 5.0f;
    [nextButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:nextButton];
}

#pragma mark - private method

#pragma mark - 按钮响应事件
- (void)pickerBtnClicked:(UIButton*)sender
{
    ZJZPickerViewController *pickerViewController = [[ZJZPickerViewController alloc] initWithNibName:@"ZJZPickerViewController" bundle:nil];
    switch (sender.tag) {
        
        case kSexTag:
            pickerViewController.dataList = self.sexArray;
            pickerViewController.delegate = self;
            pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:pickerViewController animated:YES completion:nil];
            _currTag = kSexTag;
            break;
        case kAgeTag:
            pickerViewController.dataList = self.ageArray;
            pickerViewController.delegate = self;
            pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:pickerViewController animated:YES completion:nil];
            _currTag = kAgeTag;
            break;
        case kHeightTag:
            pickerViewController.dataList = self.heightArray;
            pickerViewController.delegate = self;
            pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:pickerViewController animated:YES completion:nil];
            _currTag = kHeightTag;
            break;
        case kWeightTag:
            pickerViewController.dataList = self.weightArray;
            pickerViewController.delegate = self;
            pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:pickerViewController animated:YES completion:nil];
            _currTag = kWeightTag;
            break;
        case kIllnessTag:
            pickerViewController.dataList = self.illnessArray;
            pickerViewController.delegate = self;
            pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:pickerViewController animated:YES completion:nil];
            _currTag = kIllnessTag;
            break;
        default:
            break;
    }
    
}

- (void)getTextStr:(NSString *)text
{
    switch (_currTag) {
            
        case kSexTag: {
            [_sexButton setTitle:text forState:UIControlStateNormal];
            break;
        }
        case kAgeTag:{
            [_ageButton setTitle:[text stringByAppendingString:@"岁"] forState:UIControlStateNormal];
            break;
        }
        case kHeightTag:{
            [_heightButton setTitle:[text stringByAppendingString:@"cm"] forState:UIControlStateNormal];
            break;
        }
        case kWeightTag:{
            [_weightButton setTitle:[text stringByAppendingString:@"kg"] forState:UIControlStateNormal];
            break;
        }
        case kIllnessTag:{
            [_illnessButton setTitle:text forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }

}

- (void)nextBtnClicked
{
    _oldMan.name = _nameTxtField.text;
    _oldMan.sex = _sexButton.currentTitle;
    _oldMan.age = [_ageButton.currentTitle substringToIndex:2];
    _oldMan.height = [_heightButton.currentTitle substringToIndex:3];
    _oldMan.weight = [_weightButton.currentTitle stringByReplacingOccurrencesOfString:@"kg" withString:@""];
    _oldMan.illness = _illnessButton.currentTitle;
    _oldMan.relationship = _relationalTxtField.text;
}

#pragma mark - create UI
- (UILabel *)createLabelFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment) textAlignment font:(UIFont*) font
{
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.font=font;
    label.textColor=[UIColor grayColor];
    label.textAlignment = textAlignment;
    [label setText:text];
    return label;
}

- (UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.font=font;
    textField.textColor=[UIColor grayColor];
    textField.borderStyle=UITextBorderStyleNone;
    textField.placeholder=placeholder;
    return textField;
}

- (UIButton *)createButtonFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=frame;
    if (bgColor) {
        [btn setBackgroundColor:bgColor];
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

- (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
