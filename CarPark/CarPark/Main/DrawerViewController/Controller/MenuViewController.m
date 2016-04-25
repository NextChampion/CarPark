//
//  MenuViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/13.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "MenuTableViewController.h"

#import "NewCarsViewController.h"
#import "RecommandViewController.h"
#import "ImportNewsViewController.h"
#import "GuideViewController.h"
#import "PictureViewController.h"
#import "TextViewController.h"
#import "TalkCarViewController.h"
#import "VideoViewController.h"


#import "BaseViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *list; // 菜单列表数据源
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITableView *mmm;


@end

@implementation MenuViewController

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list = [[NSMutableArray alloc] init];
    [list addObject:@"首页"];
    [list addObject:@"说车"];
    [list addObject:@"图片"];
    [list addObject:@"视频"];
    [list addObject:@"推荐"];
    [list addObject:@"新车"];
    [list addObject:@"测评"];
    [list addObject:@"导购"];
    [self setupView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupView{
    // 1 头部view
    CGFloat headerViewX = 0;
    CGFloat headerViewY = -64;
    CGFloat headerViewW = self.view.frame.size.width;
    CGFloat headerViewH = 100;
    CGRect headerFrame =  CGRectMake(headerViewX, headerViewY, headerViewW, headerViewH);
    self.headerView.frame = headerFrame;
    self.headerView.backgroundColor = BackGroudColor;
    [self.view addSubview:self.headerView];
    
    // 2 中部的tableView
    CGFloat tableViewX = 0;
    CGFloat tableViewY = CGRectGetHeight(self.headerView.frame) - 64;
    CGFloat tableViewW = headerViewW;
    CGFloat tableViewH = ScreenHeight - 100 - 80;
    CGRect tableFrame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    self.tableView.frame = tableFrame;
    [self.view addSubview:self.tableView];
    // 3 底部的view
    CGFloat footerViewX = 0;
    CGFloat footerViewY = ScreenHeight - 80 - 64;
    CGFloat footerViewW = headerViewW;
    CGFloat footerViewH = 80;
    CGRect footerFrame = CGRectMake(footerViewX, footerViewY, footerViewW, footerViewH);
    self.footerView.frame = footerFrame;
    self.footerView.backgroundColor = BackGroudColor;
    [self.view addSubview:self.footerView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
    }
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}


// 选中cell的相应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取抽屉对象
    DrawerViewController *menuController = (DrawerViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerViewController;
    if (indexPath.row == 0) {
        ImportNewsViewController *viewController = [[ImportNewsViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 1){
        TalkCarViewController  *controller = [[TalkCarViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 2){
        PictureViewController *controller = [[PictureViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 3){
        VideoViewController *controller = [[VideoViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 4){
        RecommandViewController *controller = [[RecommandViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 5){
        NewCarsViewController *controller = [[NewCarsViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 6){
        TextViewController *controller = [[TextViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
    }else if (indexPath.row == 7){
        GuideViewController *controller = [[GuideViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [menuController setRootViewController:navController animated:YES];
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
