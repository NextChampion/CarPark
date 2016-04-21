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


@interface ImportNewsViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *ImportTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(strong,nonatomic)NSMutableArray *array;


@end

@implementation ImportNewsViewController

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
    //创建headerView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.cycleView];
    
    self.ImportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth ,ScreenHeight) style:(UITableViewStylePlain)];
    [self.ImportTableView registerNib:[UINib nibWithNibName:@"ImportTableVIewCell" bundle:nil] forCellReuseIdentifier:@"ImportTableVIewCell"];
    self.ImportTableView.tableHeaderView = headerView;    
    self.ImportTableView.delegate = self;
    self.ImportTableView.dataSource = self;
    [self.view addSubview:self.ImportTableView];
    
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ImportTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImportTableVIewCell"forIndexPath:indexPath];
    
    
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
            //            model.title = dic[@"title"];
            //            model.picCover = dic[@"picCover"];
            [self.array addObject:model];
         
        }
        [self setupCycleView];
//        NSLog(@"_____打印请求成功的返回信息%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error=====%@",error);
    }];
    
    
 /*
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:ImportNews];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {;
    
            NSError *Reqerror;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&Reqerror];
            
            NSArray *ReqArray = [[dataDic objectForKey:@"data" ]objectForKey:@"list"];
            
            NSArray *reqArray = [NSMutableArray arrayWithArray:ReqArray];
            NSLog(@"dic = %@",reqArray);
            for (NSDictionary *dic in reqArray) {
                NSLog(@"+++++%@",dic);
                ImportModel *model = [[ImportModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic];
                //            model.title = dic[@"title"];
                //            model.picCover = dic[@"picCover"];
                [self.array addObject:model];
            }
            [self setupCycleView];
            NSLog(@"----------self .array = %@",self.array);
    }];
     [ task resume];
*/
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
    
    return 120;
    
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
