//
//  TextViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TextViewController.h"
#import "DataModel.h"
#import "TypeOneCell.h"
#import "TextDetailViewController.h"

@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int count;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 数据页数,表示下次请求第几页的数据*/
@property (nonatomic, assign)NSInteger page;


@end

@implementation TextViewController
static NSString *const RecommandId = @"cell";

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    //    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setupView{
    count = 0;
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    [self.tableView registerNib:[UINib nibWithNibName:@"RecommandTableCell" bundle:nil] forCellReuseIdentifier:RecommandId];
    [self.tableView registerClass:[TypeOneCell class] forCellReuseIdentifier:RecommandId];
    [self.view addSubview:self.tableView];
    
    //添加上拉刷新的header
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    //添加下拉加载的footer动画
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    NSMutableArray *arrayImg = [NSMutableArray array];
    for (int i = 1; i < 7; i++) {
        [arrayImg addObject:[UIImage imageNamed:[NSString stringWithFormat:@"demo－%d.tiff",i]]];
    }
    [footer setImages:arrayImg duration:2 forState:(MJRefreshStateRefreshing)];
    self.tableView.mj_footer = footer;
}

-(void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    count++;
    NSString *str = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=1&serialid=&pageindex=%d&pagesize=20&appver=7.0",count];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self endRefresh];
        if (1 == self.page) {//说明在重新请求数据
            self.dataArray = nil;
        }
        NSArray *ReqArray = [[responseObject objectForKey:@"data"]objectForKey:@"list"];
        for (NSDictionary *dic in ReqArray) {
            DataModel *model = [[DataModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self updataView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefresh];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力";
        [hud hide:YES afterDelay:2];
        NSLog(@"请求失败 %@",error);
    }];
}

#pragma mark - 更新视图
-(void)updataView{
    [self.tableView reloadData];
}

#pragma mark - 停止更新视图
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommandId forIndexPath:indexPath];
    DataModel *model = self.dataArray[indexPath.row];
//    cell.srcLabel.text = model.src;
//    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
//    cell.titleLabel.text = model.title;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
//    [cell.commentImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"commenticon.png"]];
    [cell setDataWithModel:model];
    cell.srcLabel.text = model.publishTime;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.dataArray[indexPath.row];
    if (model.type == 2) { // 如果是视频cell
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //  播放视频
        // 什么都不做
    }else{
        TextDetailViewController *DetailVC = [[TextDetailViewController alloc] init];
        NSString *requestStr = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/GetStructYCNews?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",model.newsId,model.lastModify];
        DetailVC.requestStr = requestStr;
        [self.navigationController pushViewController:DetailVC animated:YES];
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
