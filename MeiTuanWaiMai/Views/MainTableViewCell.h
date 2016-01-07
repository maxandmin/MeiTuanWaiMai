//
//  MainTableViewCell.h
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodsimage;

@property (strong, nonatomic) IBOutlet UILabel *goodsname;
@property (strong, nonatomic) IBOutlet UILabel *goodsprice;

@property (strong, nonatomic) IBOutlet UIButton *subBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) IBOutlet UILabel *goodsNumber;

@property (assign, nonatomic) NSInteger orderId;

@property (assign, nonatomic) NSUInteger number;

//增加减少订单数量 需不需要动画效果
@property (copy, nonatomic) void (^plusBlock)(NSInteger count,BOOL animated);

-(void)setmaintablecell:(OrderModel *)model;

@end
