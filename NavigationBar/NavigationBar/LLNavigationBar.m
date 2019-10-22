//
//  LLNavigationBar.m
//  NavigationBar
//
//  Created by LL on 2019/10/22.
//  Copyright © 2019 LL. All rights reserved.
//

#import "LLNavigationBar.h"

@implementation LLNavigationBar

+ (void)load {
    NSLog(@"==Load==");
}

+ (void)initialize
{
    if (self == [LLNavigationBar class]) {
        NSLog(@"==initialize==");
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"==init==:%@==%@", NSStringFromCGRect(self.frame),self.subviews);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"==initWithCoder==:%@==%@", NSStringFromCGRect(self.frame),self.subviews);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"==initWithFrame==:%@==%@", NSStringFromCGRect(self.frame),self.subviews);
    }
    return self;
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    NSLog(@"didMoveToWindow:%@==%@", NSStringFromCGRect(self.frame),self.subviews);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
