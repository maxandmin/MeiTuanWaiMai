//
//  ThrowLineTool.m
//  CoreAnimationTest
//
//  Created by yh on 15/11/13.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "ThrowLineTool.h"

static ThrowLineTool *s_sharedInstance = nil;
@implementation ThrowLineTool

+ (ThrowLineTool *)sharedTool
{
    if (!s_sharedInstance) {
        s_sharedInstance = [[[self class] alloc] init];
    }
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
{
    self.showingView = obj;
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start.x, start.y)];
    [path addQuadCurveToPoint:CGPointMake(end.x+25,  end.y+25) controlPoint:CGPointMake(start.x - 180, start.y - 200)];
    [self groupAnimation:path];
}


#pragma mark - 组合动画
-(void)groupAnimation:(UIBezierPath *)path
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self.showingView.layer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish)]) {
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
    self.showingView = nil;
}




@end

