//
//  GoodsListView.h
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/6.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *objects;

@property (nonatomic,strong) UITableView *tableView;

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;

-(instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;



@end
