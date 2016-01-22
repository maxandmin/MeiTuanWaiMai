//
//  OrderModel.m
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel


-(instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        
         [self setValue:dic[@"id"] forKey:@"orderid"];
         [self setValue:dic[@"name"] forKey:@"name"];
         [self setValue:dic[@"min_price"] forKey:@"min_price"];
         [self setValue:dic[@"praise_num"] forKey:@"praise_num"];
         [self setValue:dic[@"picture"] forKey:@"picture"];
         [self setValue:dic[@"month_saled"] forKey:@"month_saled"];
         [self setValue:dic[@"orderCount"] forKey:@"orderCount"];
    }
    
    return self;
}



@end
