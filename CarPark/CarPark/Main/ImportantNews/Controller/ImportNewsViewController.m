//
//  ImportNewsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportNewsViewController.h"
#import "SDCycleScrollView.h"
#import "ImportTableVIewCell.h"
#import "ImportModel.h"
#import "AFNetworking.h"

#import "DataModel.h"
#import "TypeOneCell.h"

#import "TypeOneCell.h"
#import "TypeTwoCell.h"
#import "TypeThreeCell.h"
#import "TypeFourCell.h"


@interface ImportNewsViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *ImportTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(strong,nonatomic)NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *tableArray;


@end

@implementation ImportNewsViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}

-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = [UIColor grayColor];
//    self.title = @"要   闻";
    [self RequestData];
    [self requestData];// 加载table数据
    //创建headerView
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:self.cycleView];
//    
//    self.ImportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth ,ScreenHeight) style:(UITableViewStylePlain)];
//    [self.ImportTableView registerClass:[TypeFourCell class] forCellReuseIdentifier:@"cell4"];
//    [self.ImportTableView registerClass:[TypeThreeCell class] forCellReuseIdentifier:@"cell3"];
//    [self.ImportTableView registerClass:[TypeTwoCell class] forCellReuseIdentifier:@"cell2"];
//    [self.ImportTableView registerClass:[TypeOneCell class] forCellReuseIdentifier:@"cell1"];
//    
//    self.ImportTableView.tableHeaderView = headerView;    
//    self.ImportTableView.delegate = self;
//    self.ImportTableView.dataSource = self;
//    [self.view addSubview:self.ImportTableView];
    
    
}

- (void)setupTableView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.cycleView];
    self.ImportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth ,ScreenHeight- 64) style:(UITableViewStylePlain)];
    [self.ImportTableView registerClass:[TypeFourCell class] forCellReuseIdentifier:@"cell4"];
    [self.ImportTableView registerClass:[TypeThreeCell class] forCellReuseIdentifier:@"cell3"];
    [self.ImportTableView registerClass:[TypeTwoCell class] forCellReuseIdentifier:@"cell2"];
    [self.ImportTableView registerClass:[TypeOneCell class] forCellReuseIdentifier:@"cell1"];
    
    self.ImportTableView.tableHeaderView = headerView;
    self.ImportTableView.delegate = self;
    self.ImportTableView.dataSource = self;
    [self.view addSubview:self.ImportTableView];
}

- (void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:ImportNews parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"list"];
        for (NSDictionary *dic in array) {
            DataModel *model = [[DataModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
            
        }
        [self setupTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"cell ========= %ld",self.tableArray.count);
    return self.tableArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DataModel *model = self.tableArray[indexPath.row];
     NSInteger type = model.type;

    if (type == 1 || type == 22 || type == 5) {
        TypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    if (type == 4) {
        TypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    
    TypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    [cell setDataWithModel:model];
    return cell;
    
}

-(void)RequestData{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:ImportNews parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"*****%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *ReqArray = [[responseObject objectForKey:@"data" ]objectForKey:@"list"];
        NSArray *reqArray = [NSMutableArray arrayWithArray:ReqArray];
        for (NSDictionary *dic in reqArray) {
            ImportModel *model = [[ImportModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
        [self setupCycleView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error=====%@",error);
    }];
    
}
#pragma mark - 轮播图
- (void)setupCycleView{

    NSMutableArray *ImageArray = [[NSMutableArray alloc]init];
    NSMutableArray *titleArray = [[NSMutableArray alloc]init]; 
    for (int i = 0; i < 3; i++) {
        ImportModel *model = self.array[i];
        [ImageArray addObject: model.picCover];
        [titleArray addObject: model.title];
    
         }
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = ImageArray;
    //图片配文字
    NSArray *titles = titleArray;
  
    // 网络加载 --- 创建带标题的图片轮播器
    CGFloat w = self.view.bounds.size.width;
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
//    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) imageURLStringsGroup:imagesURLStrings];
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleView.titlesGroup = titles;
    self.cycleView.currentPageDotColor = [UIColor redColor ]; // 自定义分页控件小圆标颜色
    self.cycleView.autoScrollTimeInterval = 3;
     [self.ImportTableView addSubview:self.cycleView];
//             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleView.imageURLStringsGroup = imagesURLStrings;
    });
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    if (type == 4) {
        return ScreenHeight/3;
    }
    return 80;
    
}

/*
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
 NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 */


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
