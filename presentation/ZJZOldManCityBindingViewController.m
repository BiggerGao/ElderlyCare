//
//  ZJZOldManFamilierBindingViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/21.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "ZJZOldManCityBindingViewController.h"
#import "ZJZOldMan.h"
#import "SJAvatarBrowser.h"
#import "Color-Tool.h"

@interface ZJZOldManCityBindingViewController ()
@property (nonatomic, strong) ZJZOldMan *oldMan;
@end

@implementation ZJZOldManCityBindingViewController

- (instancetype)initWithTitle:(NSString *)title oldMan:(ZJZOldMan *)oldMan {
    self = [super init];
    if (!self) return nil;
    //  self.view.backgroundColor = [UIColor whiteColor]; 不能初始化view
    self.navigationItem.title = title;
    _oldMan = oldMan;
    return self;
}


- (void)viewDidLoad {
    [self injected];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)injected {
    UIView *nameView = ({
        UIView *view = [UIView new];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    
    [self.view addSubview:nameView];
    int padding = 15;
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(padding);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.height.equalTo(@50);
    }];
    
    UIImageView *avatarView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.image = [UIImage imageNamed:_oldMan.avatarName];
        [self setRoundImageView:imageView];
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatarImage:)]];
        imageView;
    });
    
    [nameView addSubview:avatarView];
    
    UILabel *nameLabel = ({
        UILabel *label = [self createLabelWithText:_oldMan.name textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
        label.textColor = ZJZColor(150, 150, 150, 1);
        label;
    });
    
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
    
    // 2居住城市
    // 设备ID
    UIView *cityView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ZJZColor(240, 240, 240, 1);
        view.layer.cornerRadius = 5.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [self.view addSubview:cityView];
    
    [cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        make.top.equalTo(nameView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    
    UILabel *cityLabel1 = [self createLabelWithText:@"城市" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    cityLabel1.textColor = [UIColor blackColor];
    [cityView addSubview:cityLabel1];
    
    UILabel *cityLabel2 = [self createLabelWithText:_oldMan.city textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    cityLabel2.textColor = ZJZColor(150, 150, 150, 1);
    [cityView addSubview:cityLabel2];
    
    [cityLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = cityView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@40);
    }];
    
    [cityLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = cityView;
        make.top.equalTo(superView.mas_top).offset(10);
        make.left.equalTo(cityLabel1.mas_right).offset(20);
        make.width.equalTo(@240);
    }];
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

- (UILabel*)createLabelWithText:(NSString*)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont*) font
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textAlignment = textAlignment;
    label.text = text;
    return label;
}

@end
