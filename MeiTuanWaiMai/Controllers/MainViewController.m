//
//  MainViewController.m
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//


#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "ViewModel.h"
#import "GoodsListView.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,ThrowLineToolDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    [ThrowLineTool sharedTool].delegate = self;
    [self MainTable];
    [self CustomModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdatemainUI:) name:@"updateUI" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  抛物线小红点
 *
 *  @return
 */
- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}
/**
 *  存放用户添加到购物车的商品数组
 *
 *  @return
 */
-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray new];
    }
    return _ordersArray;
}
#pragma  mark - 初始化数据
/**
 *  当前店铺商品数据
 */
-(void)CustomModel{

    [ViewModel GetShoppdata:^(NSMutableArray *array){
        self.dataArray = array;
    }];
    
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
    
    
}

#pragma mark - TableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"maincell" forIndexPath:indexPath];
        OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
        [cell setmaintablecell:model];
        __weak __typeof(&*cell)weakCell =cell;
        __block __typeof(self)bself = self;
        cell.plusBlock = ^(NSInteger nCount,BOOL animated)
        {
            /**
             *   给当前选中商品添加一个数量
             */
            NSMutableDictionary * dic = self.dataArray[indexPath.row];
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            
            /**
             *  通过坐标转换得到抛物线的起点和终点
             */
            CGRect parentRectA = [weakCell convertRect:weakCell.addBtn.frame toView:self.view];
            CGRect parentRectB = [self.shoppcartview convertRect:self.shoppcartview.shoppingCartBtn.frame toView:self.view];
            /**
             *  是否执行添加的动画
             */
            if (animated) {
            [bself.view addSubview:self.redView];
            [[ThrowLineTool sharedTool] throwObject:self.redView from:parentRectA.origin to:parentRectB.origin];
            bself.ordersArray = [ViewModel storeOrders:dic OrderData:self.ordersArray isAdded:YES];
            } else{
                bself.ordersArray = [ViewModel storeOrders:dic OrderData:self.ordersArray isAdded:NO];
            }
            
            bself.shoppcartview.OrderList.objects = self.ordersArray;
            [bself.shoppcartview updateFrame:self.shoppcartview.OrderList];
            [bself.shoppcartview.OrderList.tableView reloadData];
            bself.shoppcartview.badgeValue =  [ViewModel CountOthersWithorderData:self.ordersArray];
            double price = [ViewModel GetTotalPrice:bself.ordersArray];
            [bself.shoppcartview setTotalMoney:price];
            
        };
        
        return cell;
}

#pragma mark - 设置购物车动画
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

#pragma mark - 通知更新
-(void)UpdatemainUI:(NSNotification *)Notification{

    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: Notification.userInfo];
    //重新计算订单数组。
    self.ordersArray = [ViewModel storeOrders:dic[@"update"] OrderData:self.ordersArray isAdded:[dic[@"isAdd"] boolValue]];
    self.shoppcartview.OrderList.objects = self.ordersArray;
    //设置高度。
    [self.shoppcartview updateFrame:self.shoppcartview.OrderList];
    [self.shoppcartview.OrderList.tableView reloadData];
    //设置数量、价格
    self.shoppcartview.badgeValue =  [ViewModel CountOthersWithorderData:self.ordersArray];
    double price = [ViewModel GetTotalPrice:self.ordersArray];
    [self.shoppcartview setTotalMoney:price];
    //重新设置数据源
    self.dataArray = [ViewModel UpdateArray:self.dataArray atSelectDictionary:dic[@"update"]];
    [self.maintable reloadData];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"updateUI"];
}


@end
