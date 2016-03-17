//
//  ZJZCenterItem.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import "ZJZCenterItem.h"

@implementation ZJZCenterItem

+ (instancetype)initWithTitle:(NSString *)title {
    ZJZCenterItem *item = [[ZJZCenterItem alloc] init];
    item.title = title;
    item.height = 44;
    item.type = UITableViewCellAccessoryDisclosureIndicator;
    return item;
}
@end
