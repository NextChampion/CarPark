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
#import "TypeFiveCell.h"

#import "MediaCell.h" // 视频cell

#import "NewsDataHandle.h"
#import "ImportDetailsViewController.h"

#import <MediaPlayer/MediaPlayer.h>


@interface ImportNewsViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    int count;// 数据接口参数
}

@property(strong,nonatomic)UITableView *ImportTableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property(strong,nonatomic)NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *tableArray;

@property (nonatomic, assign) NSInteger start;// MJ 刷新数据的索引

/** 视频播放控制器*/
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer; // 播放器
/** 加载动画*/
@property(nonatomic,strong) UIActivityIndicatorView *loadingAni; // 小菊花
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;// 通知中心
@property(nonatomic,strong)UIImageView *backmovieplayer; // 预览图


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
    count = 0;
    [super viewDidLoad];
    [self RequestData];// 加载轮播图
    [self setupTableView];
    [self requestData];// 加载table数据
    
    
}



// 轮播图加载数据
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
    self.cycleView.currentPageDotColor = BackGroudColor; // 自定义分页控件小圆标颜色
    self.cycleView.autoScrollTimeInterval = 3;
    [self.ImportTableView addSubview:self.cycleView];
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleView.imageURLStringsGroup = imagesURLStrings;
    });
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    if (type == 4) {
        return ScreenHeight/3;
    }
    if (type == 3) {
        NSArray *array = [model.picCover componentsSeparatedByString:@";"];
        if (array.count == 3) {
            return ScreenHeight/5;
        }
        return ScreenHeight/3.5;
    }
    if (type == 2) {
        return ScreenHeight/3;
    }
    return 80;
}


#pragma mark - 表格图
// 创建table
- (void)setupTableView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.cycleView];
    self.ImportTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth ,ScreenHeight) style:(UITableViewStylePlain)];
    self.ImportTableView.backgroundColor = [UIColor clearColor];
    [self.ImportTableView registerClass:[TypeFourCell class] forCellReuseIdentifier:@"cell4"];
    [self.ImportTableView registerClass:[TypeThreeCell class] forCellReuseIdentifier:@"cell3"];
    [self.ImportTableView registerClass:[TypeTwoCell class] forCellReuseIdentifier:@"cell2"];
    [self.ImportTableView registerClass:[TypeOneCell class] forCellReuseIdentifier:@"cell1"];
    [self.ImportTableView registerClass:[TypeFiveCell class] forCellReuseIdentifier:@"cell5"];
    
    self.ImportTableView.tableHeaderView = headerView;
    self.ImportTableView.delegate = self;
    self.ImportTableView.dataSource = self;
    [self.view addSubview:self.ImportTableView];
    // 添加上拉刷新
    self.ImportTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _start = 0;
        count = 0;
        [self.tableArray removeAllObjects];
        [self requestData];
    }];
    
    // 添加下拉加载
    self.ImportTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _start += 5;
        [self requestData];
    }];
    
}

// table请求数据
- (void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    count++;
    NSString *str1 = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/toutiaov64/?page=%d&length=20&platform=2",count];
    [manager GET:str1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"list"];
        //        self.tableArray = [NSMutableArray new];
        for (NSDictionary *dic in array) {
            DataModel *model = [[DataModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        [self.ImportTableView reloadData];
        [self endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

// 停止刷新
-(void)endRefresh{
    [self.ImportTableView.mj_header endRefreshing];
    [self.ImportTableView.mj_footer endRefreshing];
}


#pragma mark - UITableViewDelegate
// 设置table行数
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"cell ========= %ld",self.tableArray.count);
    return self.tableArray.count;
}

// 设置table样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    // 此处因为接口问题,前期cell 创建有问题,实际类型名与type的值不匹配
    // type== 1 返回typeOn
    // type == 2 返回typeFour
    // type == 4 返回typeFour
    // type == 5 返回typeFive
    if (type == 1 || type == 22) {
        TypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    if (type == 2) {
//        TypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
//        [cell setDataWithModel:model];
//        cell.btn.tag = indexPath.row;
//        [cell.btn addTarget:self action:@selector(doput:) forControlEvents:UIControlEventTouchUpInside];
//        return cell;
        
        MediaCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
        // NSURL *imageUrl=[NSURL URLWithString:[[self.allDataArray objectAtIndex:indexPath.row] backImage]];
        // [cell.btnimage sd_setImageWithURL:imageUrl];
        [cell.btnimage setImage:[UIImage imageNamed:@"1"]];
        cell.btn.tag=indexPath.row;
        [cell.btn addTarget:self action:@selector(doput:) forControlEvents:UIControlEventTouchUpInside];
        cell.Labeltitle.text=@"视频标题";
        cell.playcountLabel.text=@"播放次数：4123";
        if (cell.btnimage==nil)
        {
            [cell.myImageView removeFromSuperview];
        }
        cell.playtimeLabel.text=[NSString stringWithFormat:@"%02d:%02d",7,34];
        
        
        return cell;
    }
    if (type == 5) {
        TypeFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    if (type == 4) {
        TypeFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    NSArray *array = [model.picCover componentsSeparatedByString:@";"];
    if (array.count == 3) {
        TypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    
    TypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    [cell setDataWithModel:model];
    return cell;
}

// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    if (model.type == 2) { // 如果是视频cell
//        播放视频

    }else{
    ImportDetailsViewController *importantDetailVC = [[ImportDetailsViewController alloc] init];
    importantDetailVC.newsId = model.newsId;
    importantDetailVC.lastModify = model.lastModify;
    [self.navigationController pushViewController:importantDetailVC animated:YES];
    }
}

/*
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
 NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 */


#pragma mark - 控制播放器视频的相关方法
// 视图出现的时候
-(void)viewWillAppear:(BOOL)animated
{
    // 判断player的状态
    
    if (self.moviePlayer.playbackState==MPMoviePlaybackStatePlaying||self.moviePlayer.playbackState==MPMoviePlaybackStatePaused) {
        [self.moviePlayer play];
    }
    else
    {
        //        如果没有状态 就调用布局table的方法
        [self show];
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //    if ([self.moviePlayer isFullscreen])
    //    {
    //        [self.moviePlayer play];
    //    }
    //    else
    //    {
    //        [self.moviePlayer pause];
    //        self.moviePlayer=nil;
    //    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}
/**
 *  支持横竖屏显示
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
-(void)show
{
    [self setupTableView];
    [self.ImportTableView registerClass:[MediaCell class] forCellReuseIdentifier:@"cell"];
    self.loadingAni=[[UIActivityIndicatorView alloc]init];
    self.loadingAni.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    
}



// 停止展示的时候 将播放器置为空
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 判断player的状态 是正在播放 还是暂停
    if (self.moviePlayer.playbackState==MPMoviePlaybackStatePlaying||self.moviePlayer.playbackState==MPMoviePlaybackStatePaused)
    {
        // 移除两个视图
        [self.backmovieplayer removeFromSuperview];
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer=nil;
        
    }
    
    
}

// button按钮
-(void)doput:(UIButton *)btn
{
    // 如果播放器是正在播放或者暂停播放
    if (self.moviePlayer.playbackState==MPMoviePlaybackStatePlaying||self.moviePlayer.playbackState==MPMoviePlaybackStatePaused)
    {
        // 移除背景图  移除播放视图
        [self.backmovieplayer removeFromSuperview];
        [self.moviePlayer.view removeFromSuperview];
    }
    // 播放链接
    NSString *urlStr= @"http://flv2.bn.netease.com/videolib3/1511/19/RiCBl0272/SD/RiCBl0272-mobile.mp4";//[[self.allDataArray objectAtIndex:btn.tag] mp4_url];
    NSString* UrlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:UrlStr];
    if (!_moviePlayer) { // 如果播放器非空
        // 创建播放器 设置播放连接url  自适应屏宽和屏高
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    // 如果播放器正准备播放
    if ([self.moviePlayer isPreparedToPlay]) {
        [_moviePlayer setContentURL:url];
        //        预览图移除
        [self.backmovieplayer removeFromSuperview];
    }
    
    self.moviePlayer.view.frame=CGRectMake(10,(btn.tag)*280+20,self.view.frame.size.width-20, 210);
    self.loadingAni.frame=CGRectMake(self.moviePlayer.view.bounds.size.width/2-18.5,self.moviePlayer.view.bounds.size.height/2-18.5, 37, 37);
    [self.ImportTableView addSubview:self.moviePlayer.view];
    self.backmovieplayer=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width-20, 210)];
    // 设置预览图
    self.backmovieplayer.image=[UIImage imageNamed:@"night_sidebar_cellhighlighted_bg@2x"];
    // 将预览图添加到播放器上面
    [self.moviePlayer.view addSubview:self.backmovieplayer];
    // 预览图上添加小菊花
    [self.backmovieplayer addSubview:self.loadingAni];
    // 添加通知
    [self addNotification];
    // 小菊花执行动画
    [self.loadingAni startAnimating];
    // table重载数据
    [self.ImportTableView reloadData];
    
}



// 添加通知
-(void)addNotification{
    // 获取通知中心
    self.notificationCenter=[NSNotificationCenter defaultCenter];
    
    // 通知中心添加观察者
    [self.notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    // 如果播放器响应了该方法
    if ([self.moviePlayer respondsToSelector:@selector(loadState)])
    {
        // 播放器准备播放
        [self.moviePlayer prepareToPlay];
    }
    else
    {
        // 播放器播放
        [self.moviePlayer play];
    }
    // 通知中心添加观察者  观察播放结束
    [self.notificationCenter addObserver:self selector:@selector(mediaPlayerPlayFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}
/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
// 播放状态改变 采用通知通知其他对象
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    // 小菊花停止
    [self.loadingAni stopAnimating];
    // 预览图移除
    [self.backmovieplayer removeFromSuperview];
    // 如果播放器的加载状态位置
    if ([self.moviePlayer loadState]!=MPMovieLoadStateUnknown)
    {
        //        判断状态
        switch (self.moviePlayer.playbackState) {
            case MPMoviePlaybackStatePlaying:
                
                //  NSLog(@"正在播放...");
                break;
            case MPMoviePlaybackStatePaused:
                // NSLog(@"暂停播放.");
                break;
            case MPMoviePlaybackStateStopped:
                // NSLog(@"停止播放.");
                break;
            default:
                // NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
                break;
        }
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
// 播放完成 通知其他对象
-(void)mediaPlayerPlayFinished:(NSNotification *)notification
{
    //NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
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
