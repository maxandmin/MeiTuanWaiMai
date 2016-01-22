//
//  MainTableViewCell.m
//  MeiTuanWaiMai
//
//  Created by maxin on 15/12/30.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

/**
 *  重新绘制Cell线
 *
 */
-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx,0.25);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx,[UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(ctx,0,rect.size.height-0.25);
    CGContextAddLineToPoint(ctx,rect.size.width,rect.size.height-0.25);
    CGContextStrokePath(ctx);
    [super drawRect:rect];
}

- (void)awakeFromNib {
    
    self.number = 0;
    self.goodsimage.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsimage.layer.cornerRadius = 5;
    self.goodsimage.layer.masksToBounds = YES;
    [self.subBtn setHidden:YES];
    [self.goodsNumber setHidden:YES];
    [self bringSubviewToFront:self.goodsimage];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setmaintablecell:(OrderModel *)model{
    self.goodsimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.picture]];
    self.goodsname.text   = [NSString stringWithFormat:@"%@",model.name];
    self.goodsprice.text  = [NSString stringWithFormat:@"¥ %.2f",[model.min_price floatValue]];
    self.goodsNumber.text = [NSString stringWithFormat:@"%@",model.orderCount];
    if ([model.orderCount  intValue] > 0)
    {
        [self.subBtn setHidden:NO];
        [self.goodsNumber setHidden:NO];
    }
    else
    {
        [self.subBtn setHidden:YES];
        [self.goodsNumber setHidden:YES];
    }
}


- (IBAction)subButton:(id)sender {
    self.number =[self.goodsNumber.text intValue];
    self.number -=1;
    self.plusBlock(self.number,NO);
    [self showOrderNumbers:self.number];
}

- (IBAction)addButton:(id)sender {
    self.number =[self.goodsNumber.text intValue];
    self.number +=1;
    self.plusBlock(self.number,YES);
    [self showOrderNumbers:self.number];
    
}

-(void)showOrderNumbers:(NSUInteger)count
{
    self.goodsNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.number];
    if (self.number > 0)
    {
        [self.subBtn setHidden:NO];
        [self.goodsNumber setHidden:NO];
    }
    else
    {
        [self.subBtn setHidden:YES];
        [self.goodsNumber setHidden:YES];
    }
}




@end
