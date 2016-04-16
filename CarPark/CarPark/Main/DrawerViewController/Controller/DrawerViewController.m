//
//  DrawerViewController.m
//  UIProject_1Dramer
//
//  Created by lanou3g on 16/3/29.
//  Copyright © 2016年 zcx. All rights reserved.
//

#import "DrawerViewController.h"




#define kMenuFullWidth [UIScreen mainScreen].bounds.size.width  //菜单的宽度  屏幕宽度
#define kMenuDisplayedWidth ([UIScreen mainScreen].bounds.size.width - 80) // 200.0f  // 菜单显示的宽度


@interface DrawerViewController (){
    BOOL canShowLeft;  // 判断左菜单是否能够显示
    BOOL showingLeftView; // 判断左菜单是否正在现实
}

//@property (nonatomic, strong) UIView *headerView;

@end

@implementation DrawerViewController
@synthesize leftViewControllrt = _left;
@synthesize rootViewController = _root;

//- (UIView *)headerView{
//    if (!_headerView) {
//        _headerView = [[UIView alloc] init];
//    }
//    return _headerView;
//}

// 实现初始化方法
- (id)initWithRootViewController:(UIViewController *)viewController{
    if (self = [super init]) {
        self.rootViewController = viewController;
    }
    return self;
}



// 视图加载完毕以后
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setRootViewController:_root];
    if (!_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
}

// 点击手势  关闭该点击手势并且调用方法使页面返回当前视图控制器
- (void)tap:(UITapGestureRecognizer *)gesture{
    [gesture setEnabled:NO];
    [self showRootViewControllerWithAnimated:YES];
}

- (void)setRootViewController:(UIViewController *)rootViewController{
    UIViewController *tempRootVC = _root;// 新建一个控制器接收一个原来的控制器
    _root = rootViewController;  // 传入的控制器赋值给原来的控制器
    if (_root) { // 如果传入的控制器不为空
        if (tempRootVC) {  // 并且原视图控制器不为空
            [tempRootVC.view removeFromSuperview];  // 将原来的控制器的view层移除
            tempRootVC = nil;  // 同时置为空
        }
        UIView *view = _root.view;   // 新建一个view
        view.frame = self.view.bounds;// 设置新建view的面积为根视图控制的view大小
        [self.view addSubview:view];  // 将新建的view添加到根视图控制器的view之上
    }else{   // 如果传入的视图控制器为空
        if (tempRootVC) {  // 原控制器不为空
            [tempRootVC.view removeFromSuperview]; // 移除原控制器的view层
            tempRootVC = nil;  // 同时设置原视图控制器的视图为空
        }
    }
    [self setNavButtons];// 设置导航栏的按钮
}

- (void)setNavButtons{
    // 如果根视图控制器为空  直接跳出
    if (!_root) {
        return;
    }
    
    // 设置跟视图控制器
    UIViewController *topController = nil; // 新建一个视图控制器
    if ([_root isKindOfClass:[UINavigationController class]]) { // 如果根视图控制器是NavigationController
        UINavigationController *navController = (UINavigationController *)_root;// 强转跟视图控制器的类型为NavigationController
        if ([[navController viewControllers] count] > 0) {// 如果NavigationController的控制器数量大于0
            topController = [[navController viewControllers] objectAtIndex:0];// 获取NavigationController第0个控制器 赋值给新建的控制器
        }
    }else{  // 如果跟视图控制器不是NavigationController
        topController = _root; // 视图控制器为跟视图控制器
    }
    
    // 在根视图导航栏上添加左button
    if (canShowLeft) { // 如果可以显示左侧菜单栏
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft:)]; // 创建一个button并且关联事件显示左侧菜单栏
        topController.navigationItem.leftBarButtonItem = button; // 将 button赋值给导航栏的根视图的左button
    }else{ // 如果不可以显示左侧菜单栏
        topController.navigationItem.leftBarButtonItem = nil;  // 左上角的button置为空
    }
}
// 显示左侧菜单栏的方法   对应左上角的button点击事件
- (void)showLeft:(id)sender{
    [self showLeftViewControllerWithAnimated:YES];// 展示左侧菜单栏 有动画效果
}

// 手势的代理方法  当点击开始的时候 根据点击的位置  判断是否执行点击事件
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == _tap) { // 如果点击手势存在
        if (_root && showingLeftView) { // 并且 左侧菜单栏存在同时正在显示着
            // 判断给定的点是否被一个CGRect包含,可以用CGRectContainsPoint函数
            // 设置单击手势能够相应的范围
            return CGRectContainsPoint(_root.view.frame, [gestureRecognizer locationInView:self.view]);// 判断这个点是否在菜单栏的框架里面  是的话返回YES 不是的话 返回NO
        }
        return NO;  // 如果点击手势不存在  就返回no  不执行手势
    }
    return YES;  // 默认返回yes  执行手势事件
}

#pragma mark - 显示视图
// 是否使用动画的方式显示根视图
- (void)showRootViewControllerWithAnimated:(BOOL)animated{
    [_tap setEnabled:NO]; // 让点击手势不能响应
    // 设置跟视图能够响应
    _root.view.userInteractionEnabled = YES;
    
    CGRect frame = _root.view.frame; // 创建一个框架 将跟视图控制器的框架复制给他
    frame.origin.x = 0.0f; // 设置这个框架的x轴为0  即紧贴着屏幕左侧
    BOOL _enabled = [UIView areAnimationsEnabled];  // 判断视图的动画是否执行结束
    
    
    if (!animated) { // 如果显示视图时设置没有动画   就讲视图的动画关闭
        [UIView setAnimationsEnabled:NO]; //   关闭视图的动画效果
    }
    
    
    
    [UIView animateWithDuration:.3 animations:^{ // 使用代码块设置动画效果
        _root.view.frame = frame; // 动画效果是改变跟视图控制器的框架
    } completion:^(BOOL finished) { // 动画结束以后
        if (_left && _left.view.superview) { // 判断左侧菜单栏是否存在同事左侧菜单栏父试图是否存在
            [_left.view removeFromSuperview]; // 如果同时存在  就将左侧菜单栏从父试图移除
        }
        showingLeftView = NO;  // 将左侧菜单栏的显示状态切换为 不显示
    }];
    
    if (!animated) {  // 动画效果执行以后  如果 动画为不显示
        [UIView setAnimationsEnabled:_enabled];  //  动画执行过程中 不可以调用执行动画的效果 ,避免出现uibug
    }
}

// 显示左侧菜单栏的视图  是否使用动画效果
- (void)showLeftViewControllerWithAnimated:(BOOL)animated{
    // 如果菜单不能显示  直接跳出
    if (!canShowLeft){
        return;
    }
    // 设置菜单正在显示的标记为yes
    showingLeftView = YES;
    
    UIView *view = self.leftViewControllrt.view; // 创建一个视图 接收菜单栏的视图
    CGRect frame = self.view.bounds; // 创建一个框架  接收跟视图控制器的边界
    frame.size.width = kMenuFullWidth; // 这个框架的宽等于屏幕的宽度
    frame.size.height = ScreenHeight - 64;

    
//    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 100)];
//    self.headerView.backgroundColor = [UIColor redColor];
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 80, 40)];
//    [button setTitle:@"收藏列表" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(90, 5, 80, 40)];
//    [button1 setTitle:@"下载列表" forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(downloadListAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    button.backgroundColor = [UIColor grayColor];
//    button1.backgroundColor = [UIColor grayColor];
//    self.headerView.userInteractionEnabled = YES;
//    
//    [self.headerView addSubview:button];
//    [self.headerView addSubview:button1];
//    [self.view insertSubview:self.headerView atIndex:0];
    
    
    frame.origin.y = 64;
    view.frame = frame; // 刚刚新建的视图的框架 等于这个框架
    [self.view insertSubview:view atIndex:0]; // 在当前的view第0层 插入一个视图
    [self.leftViewControllrt viewWillAppear:animated]; // 左侧菜单栏使用传入的动画的效果显示  传入的为no就不显示动画 传入的为yes  就显示动画
    
    frame = _root.view.frame;  // 将新建的框架设置为跟视图控制器的框架
    frame.origin.x = CGRectGetMaxX(view.frame) - (kMenuFullWidth - kMenuDisplayedWidth);  // 框架的x值 为视图的框架  减去  (全屏的宽减掉菜单栏的宽的差 )
    
    BOOL _enabled = [UIView areAnimationsEnabled];  // 判断动画效果是否执行完毕
    if (!animated) {
        [UIView setAnimationsEnabled:NO];  // 如果没执行完毕 视图的动画效果的不能交互
    }
    
    _root.view.userInteractionEnabled = NO; // 关闭跟视图控制器的交互
    [UIView animateWithDuration:.3 animations:^{ // 执行动画
        _root.view.frame = frame; // 动画效果为改变跟视图控制器的框架
    } completion:^(BOOL finished) {  // 动画完毕以后
        [_tap setEnabled:YES];  // 点击手势的交互打开
    }];
    if (!animated) {   // 如果没有执行完动画
        [UIView setAnimationsEnabled:_enabled];  // 视图的动画交互为关闭
    }
}




#pragma mark -设置根视图控制器对象和左菜单视图控制器对象-
- (void)setLeftViewControllrt:(UIViewController *)leftViewControllrt{
    _left = leftViewControllrt;
    canShowLeft = (_left != nil); // 菜单栏不等于空  就可以显示
    [self setNavButtons];  // 设置左上交的button
}
// 设置根视图控制器 有没有动画
- (void)setRootViewController:(UIViewController *)rootViewController animated:(BOOL)animated{
    
    if (!rootViewController) { // 如果跟视图控制器为空  直接返回
        [self setRootViewController:rootViewController];
        return;
    }
    
    if (showingLeftView) { // 如果菜单栏可以显示
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // app忽略交互事件
        __block DrawerViewController *selfRef = self; // 创建一个抽屉控制器
        __block UIViewController *rootRef = _root;  // 创建一个根视图控制器的的根视图为当前根视图
        
        CGRect frame = rootRef.view.frame;  //获取当前使视图的frame大小
        frame.origin.x = rootRef.view.bounds.size.width;  // x为紧贴屏幕最右边沿
        
        [UIView animateWithDuration:.1 animations:^{  // 设置动画
            rootRef.view.frame = frame; // 改变框架
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents]; // 动画结束以后 结束忽略交互 即可以处理用户交互
            [selfRef setRootViewController:rootViewController]; // 抽屉的跟视图控制器
            _root.view.frame = frame; // 原来根视图的控制器移到屏幕右边沿
            [selfRef showRootViewControllerWithAnimated:animated];// 使用动画显示跟视图控制器
        }];
    }else{  // 如果左侧菜单栏不可以显示
        [self setRootViewController:rootViewController];  // 设置跟视图控制器为自己
        [self showRootViewControllerWithAnimated:animated]; // 展示跟视图控制器
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
