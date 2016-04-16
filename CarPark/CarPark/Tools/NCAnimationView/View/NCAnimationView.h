//
//  CXAnimationView.h
//  CXAnimationButton
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCAnimationViewItem.h"


@class NCAnimationView;
@protocol NCAnimationViewDelegate <NSObject>

- (void)animationView:(NCAnimationView *)view didSelectedIndex:(NSInteger)index;

@end


@interface NCAnimationView : UIView

@property (nonatomic, strong) NSArray *viewArray;
@property (nonatomic, getter=isExpanding, assign) BOOL expanding;
@property (nonatomic, assign) id<NCAnimationViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame viewArray:(NSArray<NCAnimationViewItem *> *)array;
+ (instancetype)viewWithFrame:(CGRect)frame viewArray:(NSArray<NCAnimationViewItem *> *)array;
@end
