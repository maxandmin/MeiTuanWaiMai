//
//  MainViewController.h
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "ShoppingCartView.h"
#import "ThrowLineTool.h"
#import "GoodslistCell.h"
@interface MainViewController : UIViewController

@property(nonatomic,strong)UITableView *maintable;
//抛物线红点
@property (strong, nonatomic) UIImageView *redView;
//数据源
@property(nonatomic,strong) NSMutableArray *dataArray;
//订单数据
@property (nonatomic,strong) NSMutableArray *ordersArray;
//总数量
@property (nonatomic,assign) NSInteger totalOrders;

@property (nonatomic,strong) ShoppingCartView *shoppcartview;

@end
