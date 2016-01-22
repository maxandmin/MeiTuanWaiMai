//
//  ViewModel.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/19.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

+(void)GetShoppdata:(void(^)(NSMutableArray *array))shopDataBlock{
    
    /**
     *  在这个方法里面请求数据，处理回调
     */
    
    
    NSMutableArray *array = [NSMutableArray new];
    
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
    
    array = [@[[dic1 mutableCopy],[dic2 mutableCopy],[dic3 mutableCopy],[dic4 mutableCopy],[dic5 mutableCopy],[dic6 mutableCopy],[dic7 mutableCopy],[dic8 mutableCopy],[dic9 mutableCopy],[dic10 mutableCopy]] mutableCopy];
    
    shopDataBlock(array);
}

#pragma  mark - 计算价格
+(double)GetTotalPrice:(NSMutableArray *)dataArray{

    double nTotal = 0;
    for (NSDictionary *dic in dataArray) {
        
        if ([dic objectForKey:@"orderCount"] !=nil) {
            
            nTotal += [[dic objectForKey:@"orderCount"] integerValue] * [[dic objectForKey:@"min_price"] integerValue];
        }
    }
    return nTotal;
}

#pragma mark - 计算订单数据
+(NSMutableArray *)storeOrders:(NSMutableDictionary *)dictionary OrderData:(NSMutableArray *)orderArray isAdded:(BOOL)added{

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    //增加订单和减少订单
    if (added) {
        
        if (orderArray.count!=0) {
            
            BOOL flage = YES;
            for (NSMutableDictionary *dic in orderArray) {
                if (dic[@"id"] == dict[@"id"]){
                    
                    NSInteger count = [dict[@"orderCount"] integerValue];
                    [dic setValue:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"orderCount"];
                    flage = NO;
                    break;
                }
            }
            if(flage){
                [orderArray addObject:dict];
            }
            
        }else{
            
            [orderArray addObject:dict];
        }
 
    }else{
        
        for (int i=0; i<orderArray.count;i++) {
            
            NSMutableDictionary *dic = orderArray[i];
            
            if (dic[@"id"] == dict[@"id"]){
                
                if ([dict[@"orderCount"] integerValue]==0) {
                    [orderArray removeObjectAtIndex:i];
                    break;
                }
                
                if ([dic[@"orderCount"] integerValue] == 0){
                    [orderArray removeObjectAtIndex:i];
                }else{
                    [dic setValue:[NSString stringWithFormat:@"%@", dict[@"orderCount"]] forKey:@"orderCount"];
                }
                break;
            }
        }
    }
    return orderArray;
    
}

#pragma  mark - 计算数量
+(NSInteger) CountOthersWithorderData:(NSMutableArray *)ordersArray{
    
    NSInteger count = 0;
    for (int i = 0; i< ordersArray.count; i++)
    {
        NSMutableDictionary *dic = ordersArray[i];
        count += [dic[@"orderCount"] integerValue];
    }
    
    return count;
    
}


#pragma mark - 更新显示数据
+(NSMutableArray *)UpdateArray:(NSMutableArray *)dataArray atSelectDictionary:(NSMutableDictionary *)dictionary{

    
    for (NSMutableDictionary *dic in dataArray) {
        if (dic[@"id"] == dictionary[@"id"]){
            
            NSInteger count = [dictionary[@"orderCount"] integerValue];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"orderCount"];
            break;
        }
    }
    return dataArray;
}





@end
