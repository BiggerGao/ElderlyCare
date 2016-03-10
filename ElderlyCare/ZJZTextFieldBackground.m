//
//  ZJZTextFieldBackground.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/9.
//
//

#import "ZJZTextFieldBackground.h"

@implementation ZJZTextFieldBackground

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.2);
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 5, 50);
    CGContextAddLineToPoint(context, self.frame.size.width-5, 50);
    
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
}
@end
