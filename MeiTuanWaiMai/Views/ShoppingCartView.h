//
//  ShoppingCartView.h
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/5.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "BadgeView.h"
#import "GoodsListView.h"

@interface ShoppingCartView : UIView

@property (nonatomic,strong) BadgeView *badge;
@property (nonatomic,strong) OverlayView *OverlayView;
@property (nonatomic,strong) GoodsListView *OrderList;
@property (strong, nonatomic)  UIButton *shoppingCartBtn;

@property (strong, nonatomic)  UILabel *money;

@property (strong, nonatomic)  UIButton *payButton;

@property (nonatomic,assign) NSUInteger minFreeMoney;
@property (strong, nonatomic)  UILabel *line;

@property (nonatomic,strong) UIView *parentView;

@property (nonatomic,assign) NSInteger nTotal;//总价
@property (nonatomic,assign) BOOL open;

@property (nonatomic,assign) NSInteger badgeValue;

-(instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView;
-(void)dismissAnimated:(BOOL) animated;
-(void)setTotalMoney:(NSInteger)nTotal;
-(void)updateFrame:(UIView *)view;
@end
