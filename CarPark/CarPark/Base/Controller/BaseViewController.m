//
//  BaseViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseViewController.h"
#import "NCAnimationView.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CollectionViewController.h"
#import "PictureDisplayViewController.h"
#import "MineViewController.h"
#import "DrawerViewController.h"

@interface BaseViewController ()<NCAnimationViewDelegate>

@property (nonatomic, strong) NCAnimationView *menu;

@end

@implementation BaseViewController

- (NCAnimationView *)menu{
    if (!_menu) {
        _menu = [[NCAnimationView alloc] init];
    }
    return _menu;
}




// 控制器加载完成 添加悬浮按钮
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self setupMenuView];
}

- (void)setupMenuView{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg_menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg_menuitem_highlighted.png"];
    
    // Camera MenuItem.
    NCAnimationViewItem *profileMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                     highlightedImage:storyMenuItemImagePressed
                                                                         ContentImage:[UIImage imageNamed:@"profile.png"]
                                                              highlightedContentImage:nil];
    // People MenuItem.
    NCAnimationViewItem *collectionMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                        highlightedImage:storyMenuItemImagePressed
                                                                            ContentImage:[UIImage imageNamed:@"collection.png"]
                                                                 highlightedContentImage:nil];

    NSArray *menus = [NSArray arrayWithObjects:profileMenuItem, collectionMenuItem, nil];
    self.menu = [NCAnimationView viewWithFrame:self.view.frame viewArray:menus];
    self.menu.userInteractionEnabled = YES;
    self.menu.alpha = 0.3;
    self.menu.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.menu];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

        if ([self isKindOfClass:[LoginViewController class]] || [self isKindOfClass:[RegisterViewController class]] || [self isKindOfClass:[CollectionViewController class]] || [self isKindOfClass:[PictureDisplayViewController class]] || [self isKindOfClass:[MineViewController class]]) {
            if (self.menu) {
                
            }
        }else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAllowMenuShow"] isEqualToString:@"YES"]) {
                [self setupMenuView];
            }
        }

}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}
// 控制器消失的时候 移除悬浮按钮
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.menu) {
        [self.menu removeFromSuperview];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationView:(NCAnimationView *)view didSelectedIndex:(NSInteger)index{
    if (index == 0) {
        MineViewController *mineVC = [[MineViewController alloc] init];
        mineVC.isPresent = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mineVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (index == 1) {
        CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
        collectionVC.isPresent = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:collectionVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
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
