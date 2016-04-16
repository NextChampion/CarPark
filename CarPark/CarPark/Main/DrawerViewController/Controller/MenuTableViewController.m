//
//  MenuTableViewController.m
//  UIProject_1Dramer
//
//  Created by lanou3g on 16/3/29.
//  Copyright © 2016年 zcx. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"








@interface MenuTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *list; // 菜单列表数据源
}

@end

@implementation MenuTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [[NSMutableArray alloc] init];
    [list addObject:@"首页"];
    [list addObject:@"说车"];
    [list addObject:@"图片"];
    [list addObject:@"视频"];
    [list addObject:@"推荐"];
    [list addObject:@"新车"];
    [list addObject:@"测评"];
    [list addObject:@"导购"];
   
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 50)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 80, 20)];
    [button setTitle:@"收藏列表" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(90, 0, 80, 20)];
    [button1 setTitle:@"下载列表" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(downloadListAction:) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor grayColor];
    button1.backgroundColor = [UIColor grayColor];
    
    [view addSubview:button];
    [view addSubview:button1];
    self.tableView.tableHeaderView = view;
    
//    self.headerView.userInteractionEnabled = YES;

//    [self.view insertSubview:self.headerView atIndex:0];
    
}



// 收藏列表
//- (void)collectionAction:(UIButton *)sender{
//    
//    NSLog(@"点击了收藏列表按钮");
//    if (![[UserInfoManager getUserID]isEqualToString:@" "]) {
//        // 跳转到收藏列表
//    }else{
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        DrawerViewController *drawer = [(AppDelegate *)([UIApplication sharedApplication].delegate) drawerViewController];
//        [drawer presentViewController:nav animated:YES completion:nil];
//    }
//}
//- (void)downloadListAction:(UIButton *)sender{
//    NSLog(@"点击了下载列表按钮");
//    PlayListViewController *playListVC = [[PlayListViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:playListVC];
//    DrawerViewController *drawer = [(AppDelegate *)([UIApplication sharedApplication].delegate) drawerViewController];
//    [drawer  presentViewController:nav animated:YES completion:nil];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}

// 改变行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 80, 20)];
    [button setTitle:@"收藏列表" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(90, 0, 80, 20)];
    [button1 setTitle:@"下载列表" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(downloadListAction:) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor grayColor];
    button1.backgroundColor = [UIColor grayColor];
    
    [view addSubview:button];
    [view addSubview:button1];
    return view;
}


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

//// 选中cell的相应事件
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    // 获取抽屉对象
//    DrawerViewController *menuController = (DrawerViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerViewController;
//    if (indexPath.row == 0) {
//        ReadViewController *viewController = [[ReadViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
//        [menuController setRootViewController:navController animated:YES];
//    }else if (indexPath.row == 1){
//        RadioViewController *controller = [[RadioViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
//        [menuController setRootViewController:navController animated:YES];
//    }else if (indexPath.row == 2){
//        TopicViewController *controller = [[TopicViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
//        [menuController setRootViewController:navController animated:YES];
//    }else if (indexPath.row == 3){
//        ProductViewController *controller = [[ProductViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
//        [menuController setRootViewController:navController animated:YES];
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
