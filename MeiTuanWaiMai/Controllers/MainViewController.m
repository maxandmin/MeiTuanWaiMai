//
//  MainViewController.m
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//


#import "MainViewController.h"
#import "MainTableViewCell.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,ThrowLineToolDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    [ThrowLineTool sharedTool].delegate = self;
    [self MainTable];
    [self CustomModel];
}


- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray array];
    }
    return _ordersArray;
}
#pragma  mark - 初始化数据
-(void)CustomModel{
    
    NSDictionary *dic1 = @{@"id": @9323283,
                           @"name": @"马可波罗意面",
                           @"min_price": @12.0,
                           @"praise_num": @20,
                           @"picture":@"1.png",
                           @"month_saled":@12};
    
    NSDictionary *dic2 = @{@"id": @9323284,
                           @"name": @"鲜珍焗面",
                           @"min_price": @28.0,
                           @"praise_num": @6,
                           @"picture":@"2.png",
                           @"month_saled":@34};
    
    NSDictionary *dic3 = @{@"id": @9323285,
                           @"name": @"经典焗面",
                           @"min_price": @28.0,
                           @"praise_num": @8,
                           @"picture":@"3.png",
                           @"month_saled":@16};
    
    NSDictionary *dic4 = @{@"id": @26844943,
                           @"name": @"摩洛哥烤肉焗饭",
                           @"min_price": @32.0,
                           @"praise_num": @1,
                           @"picture":@"4.png",
                           @"month_saled":@56};
    
    NSDictionary *dic5 = @{@"id": @9323279,
                           @"name": @"莎莎鸡肉饭",
                           @"min_price": @29.0,
                           @"praise_num": @11,
                           @"picture":@"5.png",
                           @"month_saled":@11};
    
    NSDictionary *dic6 = @{@"id": @9323289,
                           @"name": @"曼哈顿海鲜巧达汤",
                           @"min_price": @22.0,
                           @"praise_num": @2,
                           @"picture":@"6.png",
                           @"month_saled":@5};
    
    NSDictionary *dic7 = @{@"id": @9323243,
                           @"name": @"意式香辣12寸传统",
                           @"min_price": @72.0,
                           @"praise_num": @0,
                           @"picture":@"7.png",
                           @"month_saled":@19};
    
    NSDictionary *dic8 = @{@"id": @9323220,
                           @"name": @"超级棒约翰9寸卷边",
                           @"min_price": @64.0,
                           @"praise_num": @28,
                           @"picture":@"8.png",
                           @"month_saled":@7};
    
    NSDictionary *dic9 = @{@"id": @9323280,
                           @"name": @"牛肉培根焗饭",
                           @"min_price": @30.0,
                           @"praise_num": @48,
                           @"picture":@"9.png",
                           @"month_saled":@0};
    
    NSDictionary *dic10 = @{@"id": @9323267,
                            @"name": @"胡椒薯格",
                            @"min_price": @16.0,
                            @"praise_num": @9,
                            @"picture":@"10.png",
                            @"month_saled":@136};
    
  self.dataArray = [@[[dic1 mutableCopy],[dic2 mutableCopy],[dic3 mutableCopy],[dic4 mutableCopy],[dic5 mutableCopy],[dic6 mutableCopy],[dic7 mutableCopy],[dic8 mutableCopy],[dic9 mutableCopy],[dic10 mutableCopy]] mutableCopy];
}

#pragma mark - 展示数据的Table
-(void)MainTable{
    self.maintable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    self.maintable.dataSource = self;
    self.maintable.delegate   = self;
    self.maintable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.maintable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.maintable ];
    [self.maintable registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"maincell"];
    
    
    self.shoppcartview  = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, CGRectGetWidth(self.view.bounds), 50) inView:self.view];
    [self.view addSubview:self.shoppcartview];
    self.shoppcartview.OrderList.tableView.delegate = self;
    self.shoppcartview.OrderList.tableView.dataSource = self;
    [self.shoppcartview.OrderList.tableView registerNib:[UINib nibWithNibName:@"GoodslistCell" bundle:nil] forCellReuseIdentifier:@"GoodslistCell"];
}

#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 0;
    if ([tableView isEqual:self.maintable]) {
        count = [self.dataArray count];
    }
    else {
        count = [self.ordersArray count];
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.maintable]) {
        return 60;
    }else
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.maintable]) {
    
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"maincell" forIndexPath:indexPath];
        OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
        [cell setmaintablecell:model];
        
        __weak __typeof(&*cell)weakCell =cell;
        cell.plusBlock = ^(NSInteger nCount,BOOL animated)
        {
            NSMutableDictionary * dic = self.dataArray[indexPath.row];
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            
            //通过坐标转换得到抛物线的起点和终点
            CGRect parentRectA = [weakCell convertRect:weakCell.addBtn.frame toView:self.view];
            CGRect parentRectB = [self.shoppcartview convertRect:self.shoppcartview.shoppingCartBtn.frame toView:self.view];
            if (animated) {
            [self.view addSubview:self.redView];
            [[ThrowLineTool sharedTool] throwObject:self.redView from:parentRectA.origin to:parentRectB.origin];
                ++self.totalOrders ;
                [self storeOrders:dic isAdded:YES];
            }
            else
            {
                --self.totalOrders;
                 [self storeOrders:dic isAdded:NO];
            }
            self.shoppcartview.badgeValue = self.totalOrders;
            [self setTotalMoney];
            
        };
        
        return cell;
    }else{
        
        GoodslistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodslistCell" forIndexPath:indexPath];
        OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.ordersArray objectAtIndex:indexPath.row]];
        [cell ListModel:model];
        cell.operationBlock=^(NSInteger number,BOOL flage){
            
            NSMutableDictionary * dic = self.ordersArray[indexPath.row];
            
            //更新订单列表中的数量
            [dic setObject:[NSNumber numberWithInteger:number] forKey:@"orderCount"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            [self storeOrders:dict isAdded:flage];
            
            self.totalOrders = flage ? ++self.totalOrders : --self.totalOrders;
            
            self.shoppcartview.badgeValue = self.totalOrders;
            //刷新tableView
            [self.maintable reloadData];
            [self setTotalMoney];
        };
        
        return cell;
        
    }
    return nil;
}

- (void)animationDidFinish
{
    
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
           self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

#pragma  mark 计算价格
-(void)setTotalMoney
{
    NSInteger nTotal = 0;
    for (NSDictionary *dic in self.ordersArray) {
        
        if ([dic objectForKey:@"orderCount"] !=nil) {
            
            nTotal += [[dic objectForKey:@"orderCount"] integerValue] * [[dic objectForKey:@"min_price"] integerValue];
        }
    }
    [self.shoppcartview setTotalMoney:nTotal];
    
}

#pragma mark - 计算订单数据
-(void)storeOrders:(NSMutableDictionary *)dictionary isAdded:(BOOL)added{

    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    //增加订单和减少订单
    if (added) {
        for (NSMutableDictionary *dic in self.ordersArray) {
            if (dic[@"id"] == dict[@"id"]){
                
                NSInteger count = [self CountOthersWithfoodID:dict[@"id"]];
                [dic setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
                self.shoppcartview.OrderList.objects = self.ordersArray;
                [self.shoppcartview.OrderList.tableView reloadData];
                
                return;
            }
        }
         NSInteger  count = [dictionary[@"orderCount"] integerValue];
        [dictionary setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
        [self.ordersArray addObject:dictionary];
        
        self.shoppcartview.OrderList.objects = self.ordersArray;
        [self.shoppcartview.OrderList.tableView reloadData];
        [self.shoppcartview updateFrame:self.shoppcartview.OrderList];
    
    }else{
        for (int i=0; i<self.ordersArray.count;i++) {
            NSMutableDictionary *dic = self.ordersArray[i];
            if (dic[@"id"] == dict[@"id"]){
                
                if ([dic[@"orderCount"] integerValue] == 0){
                    [self.ordersArray removeObjectAtIndex:i];
                }else{
                    NSInteger count = [self CountOthersWithfoodID:dict[@"id"]];
                    [dic setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
                }
            }
        }
        self.shoppcartview.OrderList.objects = self.ordersArray;
        [self.shoppcartview.OrderList.tableView reloadData];
        [self.shoppcartview updateFrame:self.shoppcartview.OrderList];

    }
}

//计算个数
-(NSInteger)CountOthersWithfoodID:(NSString *)foodID
{
    NSInteger count = 0;
    for (int i = 0; i< self.ordersArray.count; i++) {
       NSMutableDictionary *dic = self.ordersArray[i];
        if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                count += [dic[@"orderCount"] integerValue];
        }
    }
    
    return count;
}

@end
