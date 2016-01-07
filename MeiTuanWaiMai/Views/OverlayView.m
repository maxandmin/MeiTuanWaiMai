//
//  OverlayView.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/5.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "OverlayView.h"
#import "ShoppingCartView.h"
@implementation OverlayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if (view == self) {
        [self.ShoppingCartView dismissAnimated:YES];
    }
}

@end
