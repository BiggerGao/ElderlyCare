//
//  ZJZCenterItem.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import "ZJZCenterItem.h"
#import "ZJZOldMan.h"
@implementation ZJZCenterItem

+ (instancetype)initWithTitle:(NSString *)title {
    ZJZCenterItem *item = [[ZJZCenterItem alloc] init];
    item.title = title;
    item.height = 44;
    item.type = UITableViewCellAccessoryDisclosureIndicator;
    return item;
}

+ (instancetype)initWithOldman:(ZJZOldMan *)oldman {
    ZJZCenterItem *item = [[ZJZCenterItem alloc] init];
    item.title = oldman.name;
    item.imageName = [UIImage imageNamed:oldman.avatarName];
    item.height = 44;
    item.type = UITableViewCellAccessoryDisclosureIndicator;
    return item;
}
@end
