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

#import "MineViewController.h"


#import "BaseViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *list; // 菜单列表数据源
    NSMutableArray *images; // 菜单图片数据源
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
    images = [[NSMutableArray alloc] init];
    [images addObject:@"importantNews.png"];
    [images addObject:@"talk.png"];
    [images addObject:@"image.png"];
    [images addObject:@"video.png"];
    [images addObject:@"recommand.png"];
    [images addObject:@"new.png"];
    [images addObject:@"text.png"];
    [images addObject:@"guide.png"];
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
    CGRect headerFrame =  CGRectMake(headerViewX, headerViewY, kMenuDisplayedWidth, headerViewH);
    self.headerView.frame = headerFrame;
    self.headerView.backgroundColor = BackGroudColor;
    [self.view addSubview:self.headerView];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,13,kMenuDisplayedWidth-10,headerViewH)];
    [self.headerView addSubview:logoImage];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    logoImage.image = [UIImage imageNamed:@"logo_word.png"];
    __weak typeof(self) weakSelf = self;
//    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(weakSelf.footerView.mas_centerX);
//        make.centerY.mas_equalTo(weakSelf.footerView.mas_centerX).offset(10);
//        make.size.mas_equalTo(CGSizeMake(kMenuDisplayedWidth, headerViewH));
//    }];
    
    // 2 底部的view
    CGFloat footerViewX = 0;
    CGFloat footerViewH = 60;
    CGFloat footerViewY = ScreenHeight - footerViewH - 64;
    CGFloat footerViewW = headerViewW;
    
    CGRect footerFrame = CGRectMake(footerViewX, footerViewY, footerViewW, footerViewH);
    self.footerView.frame = footerFrame;
    self.footerView.backgroundColor = BackGroudColor;
    [self.view addSubview:self.footerView];
    
    
    // 3 中部的tableView
    CGFloat tableViewX = 0;
    CGFloat tableViewY = CGRectGetHeight(self.headerView.frame) - 64;
    CGFloat tableViewW = kMenuDisplayedWidth;
    CGFloat tableViewH = ScreenHeight - headerViewH - footerViewH;
    CGRect tableFrame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    self.tableView.frame = tableFrame;
    [self.view addSubview:self.tableView];
    
    // 个人中心按钮
//    UIButton *mineButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    mineButton.frame = CGRectMake(5, 5, 130, 60);
    UIButton *mineButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 130, 60)];
    mineButton.backgroundColor = [UIColor clearColor];
    mineButton.showsTouchWhenHighlighted = YES;
    [mineButton addTarget:self action:@selector(mineAction) forControlEvents:UIControlEventTouchUpInside];
    [mineButton setTitle:@"个人中心" forState:UIControlStateNormal];
    [mineButton setImage:[UIImage imageNamed:@"profile.png"] forState:UIControlStateNormal];
    [self.footerView addSubview:mineButton];
    [mineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footerView.mas_centerY);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kMenuDisplayedWidth/2 - 1, 40));
    }];
    
    // 按钮上部加一根白线
    UIView *lineAboveMineButton = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kMenuDisplayedWidth, 1)];
    lineAboveMineButton.backgroundColor = [UIColor whiteColor];
    [self.footerView addSubview:lineAboveMineButton];
    [lineAboveMineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.footerView.mas_left);
        make.right.equalTo(weakSelf.footerView.mas_right);
        make.bottom.mas_equalTo(weakSelf.footerView.mas_centerY).offset(-21);
        make.height.equalTo(@1);
    }];
    
    // 个人收藏列表
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 130, 60)];
    collectionButton.backgroundColor = [UIColor clearColor];
    [collectionButton addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton setTitle:@"个人收藏" forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    collectionButton.showsTouchWhenHighlighted = YES;
    [self.footerView addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footerView.mas_centerY);
        make.left.equalTo(mineButton.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(kMenuDisplayedWidth/2, 40));
    }];
    
    // 按钮下部加一根白线
    UIView *lineBelowMineButton = [[UIView alloc] initWithFrame:CGRectMake(0,50, kMenuDisplayedWidth, 1)];
    lineBelowMineButton.backgroundColor = [UIColor whiteColor];
    [self.footerView addSubview:lineBelowMineButton];
    [lineBelowMineButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(weakSelf.footerView.mas_left);
        make.left.equalTo(weakSelf.footerView.mas_left);
        make.right.equalTo(weakSelf.footerView.mas_right);
        make.bottom.mas_equalTo(weakSelf.footerView.mas_centerY).offset(20);
        make.height.equalTo(@1);
    }];
    
    // 按钮之间加一根白线
    UIView *lineBetweenMineButtonAndCollectionButton = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 10, 40)];
    lineBetweenMineButtonAndCollectionButton.backgroundColor = [UIColor whiteColor];
    [self.footerView addSubview:lineBetweenMineButtonAndCollectionButton];
    [lineBetweenMineButtonAndCollectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.footerView.mas_centerY).offset(-1);
        make.left.equalTo(mineButton.mas_right);
        make.size.mas_equalTo(CGSizeMake(1, 42));

    }];
}

-(void)mineAction{
    NSLog(@"打开个人中心");
    MineViewController *mineVC = [[MineViewController alloc] init];
    DrawerViewController *menuController = (DrawerViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerViewController;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [menuController setRootViewController:navController animated:YES];
    
}

- (void)collectionAction{
    NSLog(@"打开个人收藏");
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
        cell.textLabel.text = [list objectAtIndex:indexPath.row];
    }
    
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
