//
//  GoodslistCell.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/6.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "GoodslistCell.h"

@implementation GoodslistCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)ListModel:(OrderModel *)model{

    self.Namelabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.min_price floatValue]];
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.orderCount];
}

- (IBAction)minusclick:(id)sender {
    self.number =[self.numberLabel.text intValue];
    self.number -=1;
    [self showNumber:self.number];
    self.operationBlock(self.number,NO);
}

- (IBAction)plusclick:(id)sender {
    self.number =[self.numberLabel.text intValue];
    self.number += 1;
    [self showNumber:self.number];
    self.operationBlock(self.number,YES);

}

-(void)showNumber:(NSUInteger)count
{
    self.numberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.number];
}

@end
