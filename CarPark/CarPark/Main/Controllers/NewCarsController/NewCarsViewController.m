//
//  NewCarsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NewCarsViewController.h"
#import "TypeOneCell.h"
#import "DataModel.h"
#import "TextDetailViewController.h"
//#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NewCarsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int count;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, assign) NSInteger start;// MJ 刷新数据的索引
@end

@implementation NewCarsViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}

- (void)viewDidLoad {
    count = 0;
    [super viewDidLoad];
    self.navigationItem.title = @"新车";
    [self setupView];
    [self handleData];
    
}

- (void)handleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    count++;
    NSString *str = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=5&serialid=&pageindex=%d&pagesize=20&appver=7.0",count];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"list"];
        for (NSDictionary *dic in array) {
            DataModel *model = [[DataModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


-(void)setupView{
    
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[TypeOneCell class] forCellReuseIdentifier:@"newCell"];
    [self.view addSubview:self.tableView];
    
    // 添加上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _start = 0;
        count = 0;
        [self.tableArray removeAllObjects];
        [self handleData];
    }];
    
    // 添加下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _start += 5;
        [self handleData];
    }];
}

// 停止刷新
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    TypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newCell"];
    [cell setDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenHeight/8;
}


// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    TextDetailViewController *DetailVC = [[TextDetailViewController alloc] init];
    NSString *requestStr = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/GetStructYCNews?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",model.newsId,model.lastModify];
    DetailVC.requestStr = requestStr;
    DetailVC.contentTitle = model.title;
    DetailVC.type = [NSString stringWithFormat:@"%ld",model.type];
    [self.navigationController pushViewController:DetailVC animated:YES];
    
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
