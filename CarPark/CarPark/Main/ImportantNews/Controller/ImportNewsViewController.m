//
//  ImportNewsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportNewsViewController.h"
#import "SDCycleScrollView.h"

@interface ImportNewsViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *ImportTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(strong,nonatomic)NSMutableArray *array;

@end

@implementation ImportNewsViewController

static NSString* const Identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    headerView.backgroundColor = [UIColor orangeColor];
    [self setupCycleView];
    [headerView addSubview:self.cycleView];

    self.ImportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth ,ScreenHeight) style:(UITableViewStylePlain)];
    self.ImportTableView.delegate = self;
    self.ImportTableView.dataSource = self;
    [self.ImportTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.ImportTableView.tableHeaderView = headerView;
    [self.view addSubview:self.ImportTableView];
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
    
}

- (void)setupCycleView{
    
    self.title = @"要   闻";
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建带标题的图片轮播器
    CGFloat w = self.view.bounds.size.width;
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:nil];
    
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleView.titlesGroup = titles;
    self.cycleView.currentPageDotColor = [UIColor orangeColor ]; // 自定义分页控件小圆标颜色
//    [demoContainerView addSubview:self.cycleView];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleView.imageURLStringsGroup = imagesURLStrings;
    });

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
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
