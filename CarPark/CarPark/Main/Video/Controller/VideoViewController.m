//
//  VideoViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "VideoViewController.h"
#import "TypeFourCell.h"
#import "VideoModel.h"
#import "VideoPlayViewController.h"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int count;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, assign) NSInteger start;// MJ刷新  索引值
@end

@implementation VideoViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self handelData];
    // Do any additional setup after loading the view.
}

- (void)handelData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    count++;
    NSString *str = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/video/getappvideolist?pageindex=%d&pagesize=20&plat=2",count];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"list"];
        for (NSDictionary *dic in array) {
            VideoModel *model = [[VideoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        NSLog(@"%ld",self.tableArray.count);
        [self.tableView reloadData];
        [self endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)setupView{
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TypeFourCell class] forCellReuseIdentifier:@"videoCell"];
    [self.view addSubview:self.tableView];
    // 添加上拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _start = 0;
        count = 0;
        [self.tableArray removeAllObjects];
        [self handelData];
    }];
    
    // 添加下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _start += 5;
        [self handelData];
    }];
}

// 结束刷新
- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    VideoModel *model = self.tableArray[indexPath.row];
    if (model.type == 2) {
        
        cell.titleLabel.text = model.title;
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentcount];
        [cell.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        cell.durationLabel.text = model.duration;
        cell.srcLabel.text = model.sourcename;
        cell.playCountLabel.text = [NSString stringWithFormat:@"%.2f万",(float)model.totalvisit/10000];
    }else{
        NSDictionary *dic = model.user;
        cell.titleLabel.text = [dic objectForKey:@"nickName"];
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentcount];
        [cell.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        cell.durationLabel.text = model.duration;
        cell.srcLabel.text = model.sourcename;
        cell.playCountLabel.text = [NSString stringWithFormat:@"%.2f万",(float)model.totalvisit/10000];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenHeight/3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *model = self.tableArray[indexPath.row];
    VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc] init];
    videoPlayVC.modifytime = model.modifytime;
    videoPlayVC.videoid = model.videoid;
    NSLog(@"videoPlayVC.modifytime = %@",videoPlayVC.modifytime);
    [self.navigationController pushViewController:videoPlayVC animated:YES];
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
