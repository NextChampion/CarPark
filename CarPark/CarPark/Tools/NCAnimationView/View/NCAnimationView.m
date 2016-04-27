//
//  CXAnimationView.m
//  CXAnimationButton
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NCAnimationView.h"
#import <QuartzCore/QuartzCore.h>

#define NearRadios 65.0f // 动画执行过程中,弹动效果收缩的最小半径
#define EndRadios 75.0f   // 动画结束以后 最终展开的效果
#define FarRadios 85.0f // 动画执行时候,弹动效果的最远半径
#define StartPoint CGPointMake([UIScreen mainScreen].bounds.size.width - 50,[UIScreen mainScreen].bounds.size.height - 50) // 视图位置屏幕中的位置
#define TimeOffSet 0.01f // 动画执行时间


@interface NCAnimationView ()<NCAnimationViewItemDelegate>
@property (nonatomic, strong) NCAnimationViewItem *addButton;
@property (nonatomic, assign) int flag;
@property (nonatomic, strong) NSTimer *timer;

//@property (nonatomic, strong) NSArray *viewArray;
- (void)expand;
- (void)close;
- (CAAnimationGroup *)blowupAnimationAtPoint:(CGPoint)point;
- (CAAnimationGroup *)shrinkAnimationAtPoint:(CGPoint)point;
@end


@implementation NCAnimationView
@synthesize viewArray = _viewArray;
@synthesize expanding = _expanding;


- (NSArray *)viewArray{
    if (!_viewArray) {
        _viewArray = [[NSArray alloc] init];
    }
    return _viewArray;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame viewArray:(NSArray<NCAnimationViewItem *> *)array{
    self = [super initWithFrame:frame];
    if (self) {
//        self = [[NCAnimationView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        _viewArray = array;
        
        // 添加子视图

        for (int i = 0 ; i < _viewArray.count; i++) {
            NCAnimationViewItem *item = [_viewArray objectAtIndex:i];
            item.tag = 1000 + i;
            item.startPoint = StartPoint;
            // 添加子视图的方向为左上方
            item.endPoint = CGPointMake(StartPoint.x + EndRadios * sinf(i * -M_PI_2 / (_viewArray.count - 1)), StartPoint.y - EndRadios * cosf(i * -M_PI_2 / (_viewArray.count - 1)));
            item.neighbouringPoint = CGPointMake(StartPoint.x + NearRadios * sinf(i * -M_PI_2 / (_viewArray.count - 1)), StartPoint.y - NearRadios * cosf(i * -M_PI_2 / (_viewArray.count - 1)));
            item.farPoint = CGPointMake(StartPoint.x + FarRadios * sinf(i * -M_PI_2 / (_viewArray.count - 1)), StartPoint.y - FarRadios * cosf(i * -M_PI_2 / (_viewArray.count - 1)));
            item.center = item.startPoint;
            item.delegate = self;
            [self addSubview:item];
        }
        
        // 添加加号button
        _addButton = [NCAnimationViewItem itemWithImage:[UIImage imageNamed:@"bg_addbutton.png"] highlightedImage:[UIImage imageNamed:@"bg_addbutton_highlighted.png"] ContentImage:[UIImage imageNamed:@"icon-plus.png"] highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
        _addButton.delegate = self;
        _addButton.center = StartPoint;
        [self addSubview:_addButton];
    }
    return self;
}
+ (instancetype)viewWithFrame:(CGRect)frame viewArray:(NSArray<NCAnimationViewItem *> *)array{
    return [[self alloc] initWithFrame:frame viewArray:array];
}

#pragma mark - UIView's methods
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    // 如果展开了  可以点击任意地方
    if (YES == _expanding) {
        return YES;
    }else{ // 否则 只有加号按钮可以点击
        return CGRectContainsPoint(_addButton.frame, point);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.expanding = !self.expanding;
}

#pragma mark - NCAnimationViewDelegate
- (void)itemTouchesBegan:(NCAnimationViewItem *)item{
    if (item == _addButton) {
        self.expanding = !self.isExpanding;
    }
}

- (void)itemTouchesEnd:(NCAnimationViewItem *)item{
    
    // 如果是加号按钮 直接返回
    if (item == _addButton) {
        return;
    }
    //
    CAAnimationGroup *blowup = [self blowupAnimationAtPoint:item.center];
    [item.layer addAnimation:blowup forKey:@"blowup"];
    item.center = item.startPoint;
    
    for (int i = 0; i < _viewArray.count; i++) {
        NCAnimationViewItem *otherItem = [_viewArray objectAtIndex:i];
        CAAnimationGroup *shrink = [self shrinkAnimationAtPoint:otherItem.center];
        if (otherItem.tag == item.tag) {
            continue;
        }
        [otherItem.layer addAnimation:shrink forKey:@"shrink"];
        otherItem.center = otherItem.startPoint;
    }
    
    _expanding = NO;
    
    // 旋转加号按钮
    float angle = self.isExpanding ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.1f animations:^{
        _addButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    if ([_delegate respondsToSelector:@selector(animationView:didSelectedIndex:)]) {
        [_delegate animationView:self didSelectedIndex:item.tag - 1000];
    }
}

#pragma mark - instance moethods
- (void)setViewArray:(NSArray *)viewArray{
    if (viewArray == _viewArray) {
        return;
    }
    _viewArray = viewArray;
    
    // 移除子视图
    for (UIView *view in self.subviews) {
        if (view.tag >= 1000) {
            [view removeFromSuperview];
        }
    }
    
    // 添加加号按钮
    for (int i = 0 ; i < _viewArray.count; i++) {
        NCAnimationViewItem *item = [_viewArray objectAtIndex:i];
        item.tag = 1000 + i;
        item.startPoint = StartPoint;
        item.endPoint = CGPointMake(StartPoint.x + EndRadios * sinf(i * M_PI_2 / (_viewArray.count - 1)), StartPoint.y - EndRadios * cosf(i*M_PI_2 / (_viewArray.count - 1)));
        item.neighbouringPoint = CGPointMake(StartPoint.x + NearRadios * sinf(i * M_PI_2 / (_viewArray.count - 1)), StartPoint.y - NearRadios * cosf(i * M_PI_2 / (_viewArray.count - 1)));
        item.farPoint = CGPointMake(StartPoint.x + FarRadios * sinf(i * M_PI_2 / (_viewArray.count - 1)), StartPoint.y - FarRadios * cosf(i * M_PI_2 / (_viewArray.count - 1)));
        item.center = item.startPoint;
        item.delegate = self;
        [self addSubview:item];
    }
}

- (BOOL)isExpanding{
    return _expanding;
}

- (void)setExpanding:(BOOL)expanding{
    _expanding = expanding;
    
    // rotate add button
    float angle = self.isExpanding ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _addButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    
    //expand or close animation
    if (!_timer) {
        _flag = self.isExpanding ? 0 : 5;
        SEL selector =self.isExpanding ? @selector(expand) : @selector(close);
        _timer = [NSTimer scheduledTimerWithTimeInterval:TimeOffSet target:self selector:selector userInfo:nil repeats:YES] ;
    }
}

- (void)expand{
    if (_flag == 6) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    int tag = 1000 + _flag;
    NCAnimationViewItem *item = (NCAnimationViewItem *)[self viewWithTag:tag];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:M_PI],[NSNumber numberWithFloat:0.0f], nil];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.5f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.neighbouringPoint.x, item.neighbouringPoint.y);
    CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:positionAnimation,rotateAnimation, nil];
    animationGroup.duration = 0.5f;
    animationGroup.fillMode = kCAFillModeBackwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [item.layer addAnimation:animationGroup forKey:@"Expand"];
    item.center = item.endPoint;
    
    _flag++;
    
}

- (void)close{
    if (_flag == -1) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    int tag = 1000 + _flag;
    
    NCAnimationViewItem *item = (NCAnimationViewItem *)[self viewWithTag:tag];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:M_PI * 2] ,[NSNumber numberWithFloat:0.0f],nil];
    rotateAnimation.duration = 0.5f;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:.0],[NSNumber numberWithFloat:.4],[NSNumber numberWithFloat:.5], nil];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.5f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
    animationgroup.duration = 0.5f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [item.layer addAnimation:animationgroup forKey:@"Close"];
    item.center = item.startPoint;
    _flag --;
    
}

- (CAAnimationGroup *)blowupAnimationAtPoint:(CGPoint)point{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:point], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.1f;
    animationgroup.fillMode = kCAFillModeForwards;
    
    return animationgroup;
}


- (CAAnimationGroup *)shrinkAnimationAtPoint:(CGPoint)point{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:point], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.15f;
    animationgroup.fillMode = kCAFillModeForwards;
    
    return animationgroup;
}








@end
