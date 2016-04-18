//
//  BaseViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseViewController.h"
#import "NCAnimationView.h"

@interface BaseViewController ()<NCAnimationViewDelegate>

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    // Camera MenuItem.
    NCAnimationViewItem *cameraMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                    highlightedImage:storyMenuItemImagePressed
                                                                        ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                             highlightedContentImage:nil];
    // People MenuItem.
    NCAnimationViewItem *peopleMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                    highlightedImage:storyMenuItemImagePressed
                                                                        ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                             highlightedContentImage:nil];
    // Place MenuItem.
    NCAnimationViewItem *placeMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                            highlightedContentImage:nil];
    // Music MenuItem.
    NCAnimationViewItem *musicMenuItem = [[NCAnimationViewItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                            highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem, placeMenuItem,musicMenuItem, nil];
    
    NCAnimationView *menu = [NCAnimationView viewWithFrame:self.view.frame viewArray:menus];
    menu.userInteractionEnabled = YES;
    menu.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationView:(NCAnimationView *)view didSelectedIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个button",index);
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
