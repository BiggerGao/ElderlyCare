//
//  ZJZOldManProfileViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/1.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "ZJZOldManProfileViewController.h"
#import "ZJZOldMan.h"
#import "SJAvatarBrowser.h"
#import "Color-Tool.h"

//动画时间
#define kAnimationDuration 0.1
//view高度
#define kViewHeight 56

@interface ZJZOldManProfileViewController ()
@property (nonatomic, copy)ZJZOldMan *oldMan;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *flagView;
@end

@implementation ZJZOldManProfileViewController

- (instancetype)initWithTitle:(NSString *)title oldMan:(ZJZOldMan *)oldMan {
    self = [super init];
    if (!self) return nil;
//  self.view.backgroundColor = [UIColor whiteColor]; 不能初始化view
    self.navigationItem.title = title;
    _oldMan = oldMan;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)injected
{
    
    [self generateContent];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = UIScrollView.new;
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = UIView.new;
    self.contentView = contentView;
    
    contentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];

    [self injected];
}

- (void)generateContent {
    // nameView
    UIView *nameView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 2.5f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:nameView];
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(superView.mas_top).offset(15);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    avatarView.image = [UIImage imageNamed:_oldMan.avatarName];
    [self setRoundImageView:avatarView];
    
    avatarView.userInteractionEnabled = YES;
    [avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatarImage:)]];
    [nameView addSubview:avatarView];
    [self.view addSubview:avatarView];
    
    UILabel *nameLabel = [self createLabelWithText:_oldMan.name textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    nameLabel.textColor = ZJZColor(150, 150, 150, 1);
    [nameView addSubview:nameLabel];
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = nameView;
        make.top.equalTo(superView).offset(5);
        make.left.equalTo(superView.mas_left).offset(5);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = nameView;
        make.top.equalTo(superView).offset(10);
        make.left.equalTo(avatarView.mas_right).offset(20);
        make.width.equalTo(@40);
    }];
    
    // genderView
    UIView *genderView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:genderView];
    
    [genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(nameView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *genderLabel1 = [self createLabelWithText:@"性别" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    genderLabel1.textColor = [UIColor blackColor];
    [genderView addSubview:genderLabel1];
    UILabel *genderLabel2 = nil;
    if ([_oldMan.sex isEqualToString:@"man"]) {
        genderLabel2 = [self createLabelWithText:@"男" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    } else {
        genderLabel2 = [self createLabelWithText:@"女" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    }
    
    genderLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [genderView addSubview:genderLabel2];
    
    [genderLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = genderView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [genderLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = genderView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(genderLabel1.mas_right).offset(20);
        make.width.equalTo(@40);
    }];
    
    // ageView
    UIView *ageView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    
    [_contentView addSubview:ageView];
    
    [ageView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(genderView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *ageLabel1 = [self createLabelWithText:@"年龄" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    ageLabel1.textColor = [UIColor blackColor];
    [ageView addSubview:ageLabel1];
    UILabel *ageLabel2 = [self createLabelWithText:_oldMan.age textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    ageLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [ageView addSubview:ageLabel2];
    
    [ageLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = ageView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [ageLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = ageView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(ageLabel1.mas_right).offset(20);
        make.width.equalTo(@40);
    }];
    
    // 疾病
    UIView *illnessView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:illnessView];
    
    [illnessView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(ageView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *illnessLabel1 = [self createLabelWithText:@"患病" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    illnessLabel1.textColor = [UIColor blackColor];
    [illnessView addSubview:illnessLabel1];
    UILabel *illnessLabel2 = [self createLabelWithText:[self getIllnessStr:_oldMan.illness] textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    illnessLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [illnessView addSubview:illnessLabel2];
    
    [illnessLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = illnessView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [illnessLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = illnessView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(illnessLabel1.mas_right).offset(20);
        make.width.equalTo(@240);
    }];

    // 设备ID
    UIView *deviceView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:deviceView];
    
    [deviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(illnessView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *deviceLabel1 = [self createLabelWithText:@"设备" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    deviceLabel1.textColor = [UIColor blackColor];
    [deviceView addSubview:deviceLabel1];
    UILabel *deviceLabel2 = [self createLabelWithText:_oldMan.deviceID textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    deviceLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [deviceView addSubview:deviceLabel2];
    
    [deviceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = deviceView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [deviceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = deviceView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(illnessLabel1.mas_right).offset(20);
        make.width.equalTo(@240);
    }];

    /// 亲属联系方式
    UIView *relationView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:relationView];
    
    [relationView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(deviceView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
    // 关系
    UILabel *relationLabel1 = [self createLabelWithText:@"老人亲属" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    relationLabel1.textColor = [UIColor blackColor];
    [relationView addSubview:relationLabel1];
    UILabel *relationLabel2 = [self createLabelWithText:_oldMan.relationship textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    relationLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [relationView addSubview:relationLabel2];
    
    
    [relationLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = relationView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@80);
    }];
    
    [relationLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = relationView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(relationLabel1.mas_right).offset(20);
        make.width.equalTo(@140);
    }];
    
    // 联系电话
    UILabel *telLabel1 = [self createLabelWithText:@"联系方式" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    telLabel1.textColor = [UIColor blackColor];
    [relationView addSubview:telLabel1];
    UILabel *telLabel2 = [self createLabelWithText:_oldMan.emergencyTel textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    telLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [relationView addSubview:telLabel2];
    
    UIImage *telImage = [UIImage imageNamed:@"telephone"];
    
    UIImageView *telImageView = [[UIImageView alloc] initWithImage:telImage];
    telImageView.userInteractionEnabled = YES;
    [telImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTelNumber:)]];
    [relationView addSubview:telImageView];
    [self.view addSubview:telImageView];
    
    [telLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = relationView;
        make.top.equalTo(superView.mas_top).offset(60);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@80);
    }];
    [telLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = relationView;
        make.top.equalTo(superView.mas_top).offset(60);
        make.left.equalTo(telLabel1.mas_right).offset(20);
        make.width.equalTo(@140);
    }];
    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = relationView;
        make.top.equalTo(superView.mas_top).offset(60);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    /// bodyView
    UIView *bodyView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:bodyView];
    
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(relationView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@150);
    }];
    // 身高
    UILabel *heightLabel1 = [self createLabelWithText:@"身高" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    heightLabel1.textColor = [UIColor blackColor];
    [bodyView addSubview:heightLabel1];
    UILabel *heightLabel2 = [self createLabelWithText:[_oldMan.height stringByAppendingString:@"cm"] textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    heightLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [bodyView addSubview:heightLabel2];
    
    [heightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [heightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(heightLabel1.mas_right).offset(20);
        make.width.equalTo(@140);
    }];

    // 体重
    UILabel *weightLabel1 = [self createLabelWithText:@"体重" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    weightLabel1.textColor = [UIColor blackColor];
    [bodyView addSubview:weightLabel1];
    UILabel *weightLabel2 = [self createLabelWithText:[_oldMan.weight stringByAppendingString:@"kg"] textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    weightLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [bodyView addSubview:weightLabel2];
    
    [weightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(60);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [weightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(60);
        make.left.equalTo(weightLabel1.mas_right).offset(20);
        make.width.equalTo(@140);
    }];
    
    // BMI
    NSDictionary *BMIDict = [self calculateBMIWithHeight:_oldMan.height weight:_oldMan.weight];
    NSString *BMIValue = [[BMIDict allKeys] firstObject];
    UILabel *BMILabel1 = [self createLabelWithText:@"BMI" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    BMILabel1.textColor = [UIColor blackColor];
    [bodyView addSubview:BMILabel1];
    
    UILabel *BMILabel2 = [self createLabelWithText:BMIValue textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    BMILabel2.textColor = ZJZColor(150, 150, 150, 1);
    [bodyView addSubview:BMILabel2];
    
    UILabel *BMILabel3 = [self createLabelWithText:BMIDict[BMIValue] textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:20]];
    BMILabel3.textColor = BMIDict[BMIDict[BMIValue]];
    [bodyView addSubview:BMILabel3];
    
    [BMILabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(110);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [BMILabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(110);
        make.left.equalTo(BMILabel1.mas_right).offset(20);
        make.width.equalTo(@140);
    }];
    
    [BMILabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = bodyView;
        make.top.equalTo(superView.mas_top).offset(110);
        make.right.equalTo(superView.mas_right).offset(-20);
        make.width.equalTo(@100);
    }];
    
    // 备注
    UIView *remarksView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    
    remarksView.tag = 1000;
    [_contentView addSubview:remarksView];
    
    [remarksView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = _contentView;
        make.top.equalTo(bodyView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@120);
    }];
    
    UILabel *remarksLeft = [self createLabelWithText:@"备注" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    remarksLeft.textColor = [UIColor blackColor];
    [remarksView addSubview:remarksLeft];
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.backgroundColor = ZJZColor(240, 240, 240, 1);
    _textView.contentInset = UIEdgeInsetsMake(-11, -6, 0, 0);
    _textView.scrollEnabled = NO;
    
    [remarksView addSubview:_textView];
    [remarksLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = remarksView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = remarksView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
        make.left.equalTo(remarksLeft.mas_right).offset(20);
        make.right.equalTo(superView.mas_right).offset(-10);
    }];

    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(remarksView.bottom);
    }];
}


#pragma mark - 私有方法
- (UILabel*)createLabelWithText:(NSString*)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont*) font
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}

- (void)setRoundImageView:(UIImageView*)imageView
{
    NSLog(@"%ld", (long)imageView.tag);
    CGFloat radius = CGRectGetHeight([imageView bounds]) / 2;
    NSLog(@"%f", radius);
    //圆角的半径
    imageView.layer.cornerRadius = CGRectGetHeight([imageView bounds]) / 2;
    //是否显示圆角以外的部分
    imageView.layer.masksToBounds = YES;
    //边框宽度
    imageView.layer.borderWidth = 2.5;
    //边框颜色
    imageView.layer.borderColor = [ZJZColor(240, 240, 240, 1) CGColor];
}

- (void)showAvatarImage:(UITapGestureRecognizer*)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}

- (void)showTelNumber:(UITapGestureRecognizer*)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:_oldMan.emergencyTel, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}


- (NSString*)getIllnessStr:(NSString *)illnessStr {
    NSString* convert = nil;
    if ([illnessStr isEqualToString:@"heart disease"]) {
        convert = @"心脏疾病";
    } else if ([illnessStr isEqualToString:@"heart attack"]) {
        convert = @"心脏病";
    }
    return convert;
}

- (NSDictionary*)calculateBMIWithHeight:(NSString*)heightStr weight:(NSString*)weightStr {
    float height = [heightStr floatValue];
    float weight = [weightStr floatValue];
    
    float BMI = weight * 10000 / (height * height)  ;
    NSString *BMIStr = [NSString stringWithFormat:@"%.2f",BMI];
    NSString *BMIvalue = nil;
    UIColor *BMIColor = nil;
    if (BMI < 18.5) {
        BMIvalue = @"偏瘦";
        BMIColor = ZJZColor(255, 193, 37, 1);
    } else if (BMI < 24) {
        BMIvalue = @"正常";
        BMIColor = ZJZColor(67, 205, 128, 1);
    } else if (BMI < 27) {
        BMIvalue = @"过重";
        BMIColor = ZJZColor(255, 64, 64, 1);
    } else if (BMI < 30) {
        BMIvalue = @"轻度肥胖";
        BMIColor = ZJZColor(255, 64, 64, 1);
    } else if (BMI < 35) {
        BMIvalue = @"中度肥胖";
        BMIColor = ZJZColor(255, 48, 48, 1);
    } else {
        BMIvalue = @"重度肥胖";
        BMIColor = ZJZColor(255, 0, 0, 1);
    }
    NSDictionary *ret = @{BMIStr: BMIvalue, BMIvalue: BMIColor};
    return ret;
}


- (IBAction)viewTouchDown:(id)sender {
    [self.view endEditing:YES];
}

// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification
{
    NSValue *value = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.size.height = self.scrollView.bounds.size.height - keyboardSize.height;
    self.scrollView.frame = scrollViewFrame;
    [UIView commitAnimations];
}
//键盘消失时
-(void)keyboardDidHidden:(NSNotification *)notification
{
    NSValue *value = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect scrollViewFrame = self.scrollView.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    scrollViewFrame.size.height = self.scrollView.bounds.size.height + keyboardSize.height;
    self.scrollView.frame = scrollViewFrame;
    [UIView commitAnimations];
}
#pragma mark - actionsheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        return;
    }
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", _oldMan.emergencyTel];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}

#pragma mark - TextViewDelegate
-(void)textViewDidChange:(UITextView *)textView {
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}
#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

@end
