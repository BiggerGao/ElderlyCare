//
//  ZJZOldManDetailViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/4/29.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "ZJZOldManDetailViewController.h"

@interface ZJZOldManDetailViewController()
@property (nonatomic, strong) Class viewClass;
@end

@implementation ZJZOldManDetailViewController
- (instancetype)initWithTitle:(NSString *)title viewClass:(Class)viewClass {
    if (self = [super init]) {
        self.title = title;
        self.viewClass = viewClass;
    }
    return self;
}

- (void)loadView {
    self.view = self.viewClass.new;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
