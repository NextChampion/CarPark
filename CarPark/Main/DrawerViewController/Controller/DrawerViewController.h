//
//  DrawerViewController.h
//  UIProject_1Dramer
//
//  Created by lanou3g on 16/3/29.
//  Copyright © 2016年 zcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController<UIGestureRecognizerDelegate>

// 抽屉的根视图控制器
@property (nonatomic, strong) UIViewController *rootViewController;
// 抽屉的左菜单视图控制器
@property (nonatomic, strong) UIViewController *leftViewControllrt;
// 当菜单栏称为第一响应者 通过点击手势进行返回
@property (nonatomic, readonly) UITapGestureRecognizer *tap;


// 自定义初始化方法,在自定义方法中设置根视图控制器的对象
- (id)initWithRootViewController:(UIViewController *)viewController;
// 设置跟视图控制器
- (void)setRootViewController:(UIViewController *)rootViewController animated:(BOOL)animated;
// 显示跟视图
- (void)showRootViewControllerWithAnimated:(BOOL)animated;
// 显示左边菜单视图
- (void)showLeftViewControllerWithAnimated:(BOOL)animated;





@end
