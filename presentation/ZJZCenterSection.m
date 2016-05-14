//
//  ZJZCenterSection.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import "ZJZCenterSection.h"
#import "ZJZCenterItem.h"

@implementation ZJZCenterSection

+ (instancetype)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    ZJZCenterSection *section = [[ZJZCenterSection alloc] init];
    section.headerTitle = headerTitle;
    section.footerTitle = footerTitle;
    return section;
}

-(void)addItem:(ZJZCenterItem*)item
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    [_items addObject:item];
}

-(void)addItemWithTitle:(NSString*)title
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    ZJZCenterItem *item = [ZJZCenterItem initWithTitle:title];
    [_items addObject:item];
}

-(void)addItemWithTitle:(NSString*)title Image:(UIImage*)image
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    ZJZCenterItem *item = [ZJZCenterItem initWithTitle:title];
    item.imageName = image;
    [_items addObject:item];
}

@end
