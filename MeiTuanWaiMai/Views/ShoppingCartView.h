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
@property (nonatomic,strong) OverlayView *OverlayView;//遮罩图层
@property (nonatomic,strong) GoodsListView *OrderList;//选择的订单列表
@property (strong, nonatomic)  UIButton *shoppingCartBtn;

@property (strong, nonatomic)  UILabel *money;//价格

@property (strong, nonatomic)  UIButton *payButton;//选好了

@property (nonatomic,assign)   NSUInteger minFreeMoney;//最低起送价

@property (strong, nonatomic)  UILabel *line; //分割线

@property (nonatomic,strong)   UIView *parentView;//背景图层

@property (nonatomic,assign) NSInteger nTotal;//总价

@property (nonatomic,assign) BOOL open;

@property (nonatomic,assign) NSInteger badgeValue;

-(instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView;
-(void)dismissAnimated:(BOOL) animated;
-(void)setTotalMoney:(NSInteger)nTotal;
-(void)updateFrame:(GoodsListView *)orderListView;
@end
