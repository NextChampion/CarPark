//
//  CollectionViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionListDB.h"
#import "PictureDisplayViewController.h"
#import "VideoPlayViewController.h"
#import "ImportDetailsViewController.h"
//#import "ImportDetailsViewController.h"
//#import "ImportantDetailTypeOneCell.h"
//#import "ImportantDetailTypeTwoCell.h"
//#import "ImportantDetailHeaderView.h"

@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL isSourceArrayExist;
}

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CollectionViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc]init];
    }
    return _tableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据库 读取数据
    CollectionListDB *db = [[CollectionListDB alloc] init];
    NSArray *array = [db selectAllRecord];
    NSLog(@"%@",array);
    self.tableArray = [array copy];
    if (array.count > 0) {
        isSourceArrayExist = YES;
    }
    // Do any additional setup after loading the view.
    if (self.isPresent) { //如果是present的 就加一个button
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = back;
    }
    if (isSourceArrayExist) {
        UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:(UIBarButtonItemStyleDone) target:self action:@selector(clearAction)];
        self.navigationItem.rightBarButtonItem = clearItem;
    }
    
    [self setupView];
}

- (void)clearAction{
    // 数据库 读取数据
    CollectionListDB *db = [[CollectionListDB alloc] init];
    [db dropTable];
}

- (void)backAction{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupView{
//    CGFloat tableViewX = 0;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"collectionCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSourceArrayExist) {
        return self.tableArray.count;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];
    if (isSourceArrayExist) {
        NSDictionary *dic = self.tableArray[indexPath.row];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"collectionCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = dic[@"publishTime"];
            
            cell.textLabel.text = dic[@"title"];;
        }
        return cell;
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"collectionCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"暂无收藏";
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.tableArray[indexPath.row];
    NSLog(@"%@",dic);
    NSInteger type = [dic[@"type"] integerValue];
    NSLog(@"%ld",type);
    switch ([dic[@"type"] integerValue]) {
        case 2:{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
            break;
        case 3:{
            PictureDisplayViewController *pictureDetailVC = [[PictureDisplayViewController alloc] init];
            NSString *requestStr = dic[@"requestStr"];
            pictureDetailVC.requestStr = requestStr;
            pictureDetailVC.contentTitle = dic[@"title"];
            pictureDetailVC.publishTime = dic[@"publishTime"];
            pictureDetailVC.type = dic[@"type"];
            pictureDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:pictureDetailVC animated:YES completion:nil];
        }
            break;
        case 4:{
            VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc] init];
//            NSString *filePath = dic[@"filePath"];
//            NSString *string = [filePath substringFromIndex:(filePath.length - 9)];//截取范围类的字符串
//            NSLog(@"截取的值为：%@",string);
//            NSString *requestStr = [NSString stringWithFormat:@"http://h5.ycapp.yiche.com/newvideo/%@.html?plat=2&appver=7.0&ts=",string];
            videoPlayVC.requestStr = dic[@"requestStr"];
            NSLog(@"%@",dic[@"requestStr"]);
            videoPlayVC.publishTime = dic[@"publishTime"];
            NSLog(@"%@",dic[@"publishTime"]);
            videoPlayVC.type = dic[@"type"];
            NSLog(@"%@",dic[@"type"]);
            videoPlayVC.contentTitle = dic[@"title"];
            NSLog(@"%@",dic[@"title"]);
//            NSLog(@"%@",requestStr);
            [self.navigationController pushViewController:videoPlayVC animated:YES];
        }
            break;
        case 22:
            break;
        default:{
            ImportDetailsViewController *importantDetailVC = [[ImportDetailsViewController alloc] init];
            importantDetailVC.requestStr = dic[@"requestStr"];
            NSLog(@"%@",dic[@"requestStr"]);
            importantDetailVC.contentTitle = dic[@"title"];
            NSLog(@"%@",dic[@"title"]);
            importantDetailVC.type = dic[@"type"];
            NSLog(@"%@",dic[@"type"]);
            [self.navigationController pushViewController:importantDetailVC animated:YES];
        }
            break;
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
