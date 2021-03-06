//
//  ImportNewsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportNewsViewController.h"
#import "SDCycleScrollView.h"
#import "ImportModel.h"
#import "AFNetworking.h"

#import "DataModel.h"

#import "TypeOneCell.h"
#import "TypeTwoCell.h"
#import "TypeThreeCell.h"
#import "TypeFourCell.h"
#import "TypeFiveCell.h"
#import "MediaCell.h"

#import "ImportDetailsViewController.h"
#import "PictureDisplayViewController.h"

#import "WMPlayer.h"
#import <AVFoundation/AVFoundation.h>

#import "VideoPlayViewController.h"


@interface ImportNewsViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    int count;// 数据接口参数
    
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    UIView *playVideoBackgroudView;
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

@property (nonatomic, strong) UIView *playBackgroud;// 播放的背景图

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
    self.navigationItem.title = @"首页";
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册全屏完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil
     ];

    [self RequestData];// 加载轮播图
    [self setupTableView];
    [self requestData];// 加载table数据
    
    
}



// 轮播图加载数据
-(void)RequestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:ImportNews parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

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

    DataModel *model = self.tableArray[index];
    ImportDetailsViewController *importantDetailVC = [[ImportDetailsViewController alloc] init];
    NSString *str1 = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/GetStructNews?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",model.newsId,model.lastModify];
    importantDetailVC.requestStr = str1;
    importantDetailVC.contentTitle = model.title;
    importantDetailVC.type = [NSString stringWithFormat:@"%ld",model.type];
    [self.navigationController pushViewController:importantDetailVC animated:YES];
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
        return ScreenHeight/3.2;
    }
    if (type == 22) {
        return 0;
    }
    if (type == 2) {
        return ScreenHeight/3;
    }
    if (type == 1) {
        return ScreenHeight/7.5;
    }
    return 0;
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
    [self.ImportTableView registerClass:[MediaCell class] forCellReuseIdentifier:@"mediaCell"];
    [self.ImportTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    
    self.ImportTableView.tableHeaderView = headerView;
    self.ImportTableView.delegate = self;
    self.ImportTableView.dataSource = self;
    self.ImportTableView.showsVerticalScrollIndicator = NO;
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
    return self.tableArray.count;
}

// 设置table样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.tableArray.count == 0) {
//        return nil;
//    }
    DataModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    // 此处因为接口问题,前期cell 创建有问题,实际类型名与type的值不匹配
    // type== 1 返回typeOn
    // type == 2 返回typeFour
    // type == 4 返回typeFour
    // type == 5 返回typeFive
    if (type == 1 ) {
        TypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        return cell;
    }
    if (type == 22) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
        return cell;
    }
    if (type == 2) {
        MediaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
        [cell setDataWithModel:model];
        cell.playButton.tag = indexPath.row;
        [cell.playButton addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (wmPlayer&&wmPlayer.superview) { // 如果播放器存在 并且播放器的父试图存在
            if (indexPath==currentIndexPath) { // 如果当前的索引等于正在播放视频的cell的索引

            }else{
                [cell.playButton.superview bringSubviewToFront:cell.playButton]; // 如果播放器不存在 将button置顶
//                [cell.playBackgroud removeFromSuperview];
            }
            NSArray *indexpaths = [tableView indexPathsForVisibleRows];
            if (![indexpaths containsObject:currentIndexPath]) {//复用  如果当前的索引范围 包含了正在播放视频的cell的索引
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) { // 如果window包含播放器  视频正在小窗口播放
                    wmPlayer.hidden = NO; // 不显示cell里面的播放器
                    
                }else{
                    
                    wmPlayer.hidden = YES; // 隐藏播放器
//                    [cell.playButton.superview bringSubviewToFront:cell.playButton]; // 将button置顶
                    
                    
                }
            }else{
                if (cell.playBackgroud || [cell.playBackgroud.subviews containsObject:wmPlayer]) {
                    [cell.playBackgroud addSubview:wmPlayer];
                    [wmPlayer.player play];
                    wmPlayer.playOrPauseBtn.selected = NO;
                    wmPlayer.hidden = NO;
                }
                
            }
        }
        
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
    if (type == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
        return cell;
        
    }
    TypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    [cell setDataWithModel:model];
    return cell;
    
}

// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *model = self.tableArray[indexPath.row];
    
    switch (model.type) {
        case 2:{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
            break;
        case 3:{
            PictureDisplayViewController *pictureDetailVC = [[PictureDisplayViewController alloc] init];
            NSString *requestStr = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/GetNewsAlbum?newsid=%@",model.newsId];
            //        pictureDetailVC.isImportantPush = YES;
            pictureDetailVC.requestStr = requestStr;
            pictureDetailVC.contentTitle = model.title;
            pictureDetailVC.publishTime = model.publishTime;
            pictureDetailVC.type = [NSString stringWithFormat:@"%ld",model.type];
            pictureDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:pictureDetailVC animated:YES completion:nil];
            if (wmPlayer) {
                UIView *view = wmPlayer.superview;
                [view removeFromSuperview];
                [self releaseWMPlayer];
            }
        }
            break;
        case 4:{
            VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc] init];
            NSString *filePath = model.filePath;
            NSString *string = [filePath substringFromIndex:(filePath.length - 9)];//截取范围类的字符串
            NSString *requestStr = [NSString stringWithFormat:@"http://h5.ycapp.yiche.com/newvideo/%@.html?plat=2&appver=7.0&ts=",string];
            videoPlayVC.requestStr = requestStr;
            videoPlayVC.publishTime = model.publishTime;
            videoPlayVC.contentTitle = model.title;
            videoPlayVC.type = [NSString stringWithFormat:@"%ld",model.type];
            [self.navigationController pushViewController:videoPlayVC animated:YES];
            if (wmPlayer) {
                UIView *view = wmPlayer.superview;
                [view removeFromSuperview];
                [self releaseWMPlayer];
            }
        }
            break;
        case 22:
            break;
        default:{
            ImportDetailsViewController *importantDetailVC = [[ImportDetailsViewController alloc] init];
            NSString *str1 = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/GetStructNews?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",model.newsId,model.lastModify];
            importantDetailVC.requestStr = str1;
            importantDetailVC.contentTitle = model.title;
            importantDetailVC.type = [NSString stringWithFormat:@"%ld",model.type];
            [self.navigationController pushViewController:importantDetailVC animated:YES];
            if (wmPlayer) {
                UIView *view = wmPlayer.superview;
                [view removeFromSuperview];
                [self releaseWMPlayer];
            }
        }
            break;
    }
}



#pragma mark - 控制播放器视频的相关方法

// 视频开始播放的方法
- (void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];// 获取cell的索引值保存下来
    MediaCell *cell = (MediaCell *)sender.superview.superview; // 创建视频cell
    DataModel *model = [self.tableArray objectAtIndex:sender.tag]; // 获取cell的数据model
    
    if (wmPlayer) { // 如果播放器存在
        [wmPlayer removeFromSuperview]; // 将播放器移除
        [wmPlayer setVideoURLStr:model.mp4Link]; // 设置播放链接
        [wmPlayer.player play]; // 播放
        
    }else{ // 如果播放器不存在
        wmPlayer = [[WMPlayer alloc]initWithFrame:cell.picCoverImage.bounds videoURLStr:model.mp4Link]; // 创建一个播放器
        
        
        [wmPlayer.player play];
        
    }
    self.currentCell.playBackgroud = [[UIView alloc] initWithFrame:self.currentCell.picCoverImage.frame];
    [self.currentCell.contentView addSubview:self.currentCell.playBackgroud];
    [self.currentCell.playBackgroud addSubview:wmPlayer];
    [self.ImportTableView reloadData];

}
// 视频播放完毕的通知响应发发
-(void)videoDidFinished:(NSNotification *)notice{
    MediaCell *currentCell = [self currentCell];  //  获取当前播放视频的cell
    [wmPlayer removeFromSuperview]; // 移除播放器
    [currentCell.playBackgroud removeFromSuperview];
//    [currentCell.playButton.superview bringSubviewToFront:currentCell.playButton]; // cell.contentView将button移到顶层
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}

// 视频关闭的响应方法
-(void)closeTheVideo:(NSNotification *)obj{

    MediaCell *currentCell = (MediaCell *)[self.ImportTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBackgroud removeFromSuperview];
    //    [currentCell.playButton.superview bringSubviewToFront:currentCell.playButton];
    [self releaseWMPlayer];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    
}
-(MediaCell *)currentCell{
    if (currentIndexPath==nil) {
        return nil;
    }
    MediaCell *currentCell = (MediaCell *)[self.ImportTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    return currentCell;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            
            if (wmPlayer.isFullscreen) {
                [self toCell];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (wmPlayer.fullScreenBtn.selected == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (wmPlayer.fullScreenBtn.selected == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        default:
            break;
    }
}



-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    wmPlayer.isFullscreen = YES;
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}
     


// 视频全屏的相应方法
-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            
            [self toCell];
        }
    }
}
     
-(void)toCell{
    MediaCell *currentCell = [self currentCell];
    [wmPlayer removeFromSuperview];

    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.playBackgroud.bounds;
        wmPlayer.playerLayer.frame = wmPlayer.bounds;
        [currentCell.playBackgroud addSubview:wmPlayer];
        
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
            
        }];
        
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
        
    }];
    
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.ImportTableView){
        if (wmPlayer==nil) {
            return;
        }
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.ImportTableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.ImportTableView convertRect:rectInTableView toView:[self.ImportTableView superview]];
//            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));

            if (rectInSuperview.origin.y < -self.currentCell.playBackgroud.frame.size.height || rectInSuperview.origin.y > self.view.frame.size.height-kNavbarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                    
                }
            }else{
                if ([self.currentCell.playBackgroud.subviews containsObject:wmPlayer]) {
                    
                }else{
                    MediaCell *currentCell = [self currentCell];
                    
//                    [wmPlayer removeFromSuperview]; 
                    currentCell.playBackgroud = [[UIView alloc] initWithFrame:currentCell.picCoverImage.bounds];
                    [currentCell.contentView addSubview:currentCell.playBackgroud];
                    [currentCell.playBackgroud addSubview:wmPlayer];

                    [self toCell];
                }
            }

        }
        
    }
}

-(void)toSmallScreen{
    //放widow上
    UIView *view = wmPlayer.superview;
    [wmPlayer removeFromSuperview];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(ScreenWidth/2,ScreenHeight-(ScreenWidth/2)*0.75, ScreenWidth/2, (ScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    }];
    
}

-(void)releaseWMPlayer{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
 
    [wmPlayer.player pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer = nil;
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;

 
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    currentIndexPath = nil;
}
     
-(void)dealloc{
// NSLog(@"%@ dealloc",[self class]);
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 [self releaseWMPlayer];
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
