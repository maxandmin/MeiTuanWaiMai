//
//  GoodslistCell.h
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/6.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface GoodslistCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Namelabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UIButton *minus;

@property (weak, nonatomic) IBOutlet UIButton *plus;

@property (nonatomic,copy) void (^operationBlock)(NSInteger number,BOOL plus);

@property (nonatomic,assign) NSInteger id;

@property (nonatomic,assign) NSInteger number;

-(void)ListModel:(OrderModel *)model;

@end
