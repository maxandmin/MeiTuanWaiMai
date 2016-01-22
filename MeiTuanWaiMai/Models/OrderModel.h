//
//  OrderModel.h
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *min_price;
@property(nonatomic,copy)NSString *praise_num;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *month_saled;
@property(nonatomic,copy)NSString *orderCount;
-(instancetype)initWithDictionary:(NSDictionary *)dic;


@end
