//
//  ExpertSystemViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "ZJZDiscoveryViewController.h"
#import "Color-Tool.h"
#import "ZJZChooseWeatherController.h"

@interface ZJZDiscoveryViewController ()
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation ZJZDiscoveryViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
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

- (void)injected {
    
    UIView *superView = _contentView;
    UIView *lastView = nil;
    // 专家系统
    UIImageView *expertView = ({
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view_expert"]];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = 8.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:expertView];
    
    [expertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(15);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        
        make.height.equalTo(@150);
    }];
    lastView = expertView;

    // 出行系统
    UIImageView *weatherView = ({
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view_weather"]];
        view.layer.cornerRadius = 8.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view.layer.masksToBounds = YES;
        view;
    });
    [_contentView addSubview:weatherView];
    weatherView.userInteractionEnabled = YES;
    [weatherView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToWeather:)]];
    [weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(15);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(expertView.height);
    }];
    
    lastView = weatherView;

    // 看护文章推荐系统
    UIImageView *articleView = ({
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view_article"]];
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor greenColor];
        view.layer.cornerRadius = 8.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:articleView];
    
    [articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(15);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(expertView.height);
    }];
    lastView = articleView;
    
    // 敬请期待
    UIImageView *waitingView = ({
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view_waiting"]];
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor greenColor];
        view.layer.cornerRadius = 8.0f;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [ZJZColor(220, 220, 220, 1) CGColor];
        view;
    });
    [_contentView addSubview:waitingView];
    
    [waitingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(15);
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(expertView.height);
    }];
    lastView = waitingView;
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.bottom);
    }];
}

- (void)pushToWeather:(UITapGestureRecognizer*)gestureRecognizer {
    
    ZJZChooseWeatherController *chooseController = [[ZJZChooseWeatherController alloc] init];
    [self.navigationController pushViewController:chooseController animated:YES];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
