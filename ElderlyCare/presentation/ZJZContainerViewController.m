//
//  ZJZContainerViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/17.
//
//

#import "ZJZContainerViewController.h"
#import "ZJZCenterViewController.h"
#import "ZJZLoginViewController.h"
#import "GlobalVariables.h"

@interface ZJZContainerViewController ()

@property (nonatomic, strong) ZJZCenterViewController *centerViewController;
@property (nonatomic, strong) ZJZLoginViewController *loginViewController;

@property (nonatomic, strong) UIViewController *currViewController;

@end

@implementation ZJZContainerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginViewController = [[ZJZLoginViewController alloc] init];
    [self addChildViewController:_loginViewController];
    
    [self.view addSubview:self.loginViewController.view];
    self.currViewController = _loginViewController;
    self.title = @"个人中心";
    self.navigationItem.title = _currViewController.title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadCenterViewController)
                                                 name:@"LoginNotification"
                                               object:nil];
}

- (void)loadCenterViewController{
    _centerViewController = [[ZJZCenterViewController alloc] init];
    [self addChildViewController:_centerViewController];
    
    [self transitionFromViewController:_loginViewController
                      toViewController:_centerViewController
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCurlUp
                            animations:nil
                            completion:^(BOOL finished) {
                                if (finished) {
                                    [_centerViewController didMoveToParentViewController:self];
                                    [_loginViewController willMoveToParentViewController:nil];
                                    [_loginViewController removeFromParentViewController];
                                    self.currViewController = _centerViewController;
                                    self.navigationItem.title = _currViewController.title;
                                } else {
                                    self.currViewController = _loginViewController;
                                }
                            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
