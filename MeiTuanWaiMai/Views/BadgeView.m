//
//  BadgeView.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/5.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

+(BadgeView *)initWithString:(NSString *)string withTextColor:(UIColor *)textColor
{
    return [[self alloc] initWithString:string withTextColor:textColor];
}

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = frame.size.height /2;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.font = [UIFont systemFontOfSize:10.0f];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.text = string;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
        self.badgeValue = string;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string withTextColor:(UIColor *)textColor
{
    return [self initWithFrame:frame withString:string];
}

@end
