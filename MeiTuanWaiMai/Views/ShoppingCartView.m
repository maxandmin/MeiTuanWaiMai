//
//  ShoppingCartView.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/5.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "ShoppingCartView.h"
#import "BadgeView.h"

@implementation ShoppingCartView

-(instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.parentView = parentView;
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{

    self.minFreeMoney = 20;
    
    self.line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    self.line.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.line.layer.borderWidth = 0.25;
    [self addSubview:self.line];
    
    //购物金额提示框
    self.money = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, self.bounds.size.width, 30)];
    [self.money setTextColor:[UIColor grayColor]];
    [self.money setText:@"购物车空空如也~"];
    [self.money setFont:[UIFont systemFontOfSize:13.0]];
    [self addSubview:self.money];
    
    
    //结账按钮
    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payButton.frame = CGRectMake(self.bounds.size.width - 100, 5, 90,35);
    [self.payButton addTarget:self action:@selector(payclick:) forControlEvents:UIControlEventTouchUpInside];
    self.payButton.layer.cornerRadius = 5;
    self.payButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.payButton.backgroundColor = [UIColor lightGrayColor];
    [self.payButton setTitle:[NSString stringWithFormat:@"还差￥%ld",self.minFreeMoney] forState:UIControlStateNormal];
    self.payButton.enabled = NO;
    [self addSubview:self.payButton];
    
    
    //购物车
    self.shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shoppingCartBtn setUserInteractionEnabled:NO];
    [self.shoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    self.shoppingCartBtn.frame = CGRectMake(10, -10, 50,50);
    [self.shoppingCartBtn addTarget:self action:@selector(shoppCartClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shoppingCartBtn];
    
    
    self.badge = [[BadgeView alloc] initWithFrame:CGRectMake(self.shoppingCartBtn.frame.size.width - 18, 5, 18, 18) withString:nil];
    [self.shoppingCartBtn addSubview:self.badge];
     self.badge.hidden = YES;
    
    int maxHeight = self.parentView.frame.size.height - 250;
    self.OrderList = [[GoodsListView alloc] initWithFrame:CGRectMake(0,self.parentView.bounds.size.height - maxHeight, self.bounds.size.width, maxHeight) withObjects:nil  canReorder:YES];
    
    self.OverlayView = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    self.OverlayView.ShoppingCartView = self;
    [self.OverlayView addSubview:self];
    [self.parentView addSubview:self.OverlayView];
    self.OverlayView.alpha = 0.0;
    self.open = NO;
}

-(void)setBadgeValue:(NSInteger)badgeValue{

    _badgeValue = badgeValue;
    self.badge.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)badgeValue];
    if (badgeValue>0) {
        self.badge.hidden = NO;
    }
    else{
        self.badge.hidden = YES;
    }
   
}

#pragma mark 结算
- (void)payclick:(id)sender {
    NSLog(@"%@", self.OrderList.objects);
    
}

#pragma  mark 点击购物车
- (void)shoppCartClick:(id)sender {
    if (!self.badgeValue>0) {
        [self.shoppingCartBtn setUserInteractionEnabled:NO];
        return;
    }
    [self updateFrame:self.OrderList];
    [self.OverlayView addSubview:self.OrderList];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.shoppingCartBtn.center;
        CGPoint labelPoint = self.money.center;
        
        point.y -= (self.OrderList.frame.size.height + 50);
        labelPoint.x -= 60;
        self.OverlayView.alpha = 1.0;
        
        [self.shoppingCartBtn setCenter:point];
        [self.money setCenter:labelPoint];
    } completion:^(BOOL finished) {
        
        self.open = YES;
    }];

}

-(void)updateFrame:(UIView *)view
{
    
    GoodsListView *orderListView = (GoodsListView *)view;
    if(orderListView.objects.count ==0){
        [self dismissAnimated:YES];
        return;
    }
    float height = 0;
    height = [orderListView.objects count] * 50;
    int maxHeight = self.parentView.frame.size.height - 250;
    if (height >= maxHeight) {
        height = maxHeight;
    }
    float orignY = self.OrderList.frame.origin.y;
    
    self.OrderList.frame = CGRectMake(self.OrderList.frame.origin.x, self.parentView.bounds.size.height - height - 50, self.OrderList.frame.size.width, height);
    float currentY = self.OrderList.frame.origin.y;
    
    if (self.open) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.shoppingCartBtn.center;
            point.y -= orignY - currentY;
            [self.shoppingCartBtn setCenter:point];
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
   
}

#pragma mark - dismiss
-(void)dismissAnimated:(BOOL)animated
{
    
    [self.shoppingCartBtn bringSubviewToFront:self.OverlayView];
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.shoppingCartBtn.center;
        CGPoint labelPoint = self.money.center;
        
        point.y += (self.OrderList.frame.size.height + 50);
        labelPoint.x += 60;
        _OverlayView.alpha = 0.0;
        
        [self.shoppingCartBtn setCenter:point];
        [self.money setCenter:labelPoint];
        
        
    } completion:^(BOOL finished) {
        
        self.open = NO;
    }];
}

-(void)setTotalMoney:(NSInteger)nTotal
{
    self.nTotal = nTotal;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSString *amount = [formatter stringFromNumber:[NSNumber numberWithInteger:nTotal]];
    if(self.nTotal > 0)
    {
        self.money.font = [UIFont systemFontOfSize:20.0f];
        self.money.textColor = [UIColor redColor];
        self.money.text = [NSString stringWithFormat:@"共￥%@",amount];
        NSInteger value = self.minFreeMoney - self.nTotal;
        if (value > 0) {
            
            self.payButton.enabled = NO;
            [self.payButton setTitle:[NSString stringWithFormat:@"还差￥%ld",(long)value] forState:UIControlStateNormal];
            [self.payButton setBackgroundColor:[UIColor grayColor]];
        }
        else
        {
            self.payButton.enabled = YES;
            [self.payButton setTitle:@"选好了" forState:UIControlStateNormal];
            [self.payButton setBackgroundColor:[UIColor redColor]];
        }
        [self.shoppingCartBtn setUserInteractionEnabled:YES];
    }
    else
    {
        [self.money setTextColor:[UIColor grayColor]];
        [self.money setText:@"购物车空空如也~"];
        [self.money setFont:[UIFont systemFontOfSize:13.0]];
        
        self.payButton.enabled = NO;
        [self.payButton setTitle:[NSString stringWithFormat:@"还差￥%ld",self.minFreeMoney] forState:UIControlStateNormal];
        [self.payButton setBackgroundColor:[UIColor grayColor]];
        
        [self.shoppingCartBtn setUserInteractionEnabled:NO];
    }
    
}



@end
