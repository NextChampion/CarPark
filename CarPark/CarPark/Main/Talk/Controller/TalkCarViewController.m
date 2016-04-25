//
//  TalkCarViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TalkCarViewController.h"
#import "TalkCarViewCell.h"
#import "TalkModel.h"
#import "TalkCarDetailViewController.h"
#import "TalkCarScrollViewController.h"

@interface TalkCarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong)NSMutableArray *ScrolArray;
/** 就是那个headerView*/
@property (nonatomic, strong) UICollectionViewFlowLayout *CollectionLayout;
@property (nonatomic, assign) NSInteger page;
/** 第三方轮播图*/
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@property (nonatomic,strong)UICollectionReusableView *reusableView ;

@end

@implementation TalkCarViewController

static NSString *const collectionID = @"header";

-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}

-(NSMutableArray *)ScrolArray{
    if (!_ScrolArray ) {
        _ScrolArray = [[NSMutableArray alloc]init];
    }
    return _ScrolArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"说   车";
    [self RequestData];
    [self setUpCollection];
    [self creatScrollView];
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

#pragma mark - 创建collectionView
-(void)setUpCollection{
    
    self.CollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    //headerView大小
    self.CollectionLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 180);
    self.CollectionLayout.itemSize = CGSizeMake(ScreenWidth, 230);
    
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = ScreenWidth;
    CGFloat collectionViewH = ScreenHeight;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:self.CollectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.minimumZoomScale = 3;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TalkCarViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionID];
    [self addRefResh];
    [self.view addSubview:self.collectionView];
    
}
#pragma mark - 添加上拉刷新,下拉加载
-(void)addRefResh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RequestData)];
    MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RequestData)];
    self.collectionView.mj_footer = footer;
}
#pragma mark - 数据请求
-(void)RequestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:TalkCar parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self endResh];
        NSArray *ReqArray = [[responseObject objectForKey:@"data"]objectForKey:@"list"];
        for (NSDictionary *dic in ReqArray) {
            TalkModel *model = [[TalkModel alloc]init];
            model.title = dic[@"title"];
            model.picCover = dic[@"picCover"];
            model.commentCount = dic[@"commentCount"];
            model.mediaName = dic[@"mediaName"];
            model.newsId = dic[@"newsId"];
            model.lastModify = dic[@"lastModify"];
            [self.array addObject:model];
            [self updataView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力";
        [hud hide:YES afterDelay:2];
        NSLog(@"请求失败 %@",error);
    }];
}

#pragma mark - 更新视图
-(void)updataView{
    [self.collectionView reloadData];
}

#pragma mark - 停止更新视图
-(void)endResh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
#pragma mark - collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TalkCarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    TalkModel *model = self.array[indexPath.row];
    [cell.picCover sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    cell.title.text = model.title;
    cell.commentCount.text = [NSString stringWithFormat:@"%@",model.commentCount];
    cell.mediaName.text  = model.mediaName ;
    cell.selected = YES;
    return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    self.reusableView = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionID forIndexPath:indexPath];
        _reusableView = headerView;
    }
    _reusableView.backgroundColor = [UIColor redColor];
    return _reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TalkModel *model = self.array[indexPath.row];
    TalkCarDetailViewController *VC = [[TalkCarDetailViewController alloc]init];
    VC.newsId = model.newsId;
    VC.lastModify = model.lastModify;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 创建轮播图
-(void)creatScrollView{
    
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180) delegate:self placeholderImage:nil];
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.scrollView.currentPageDotColor = [UIColor redColor];
    self.scrollView.autoScrollTimeInterval = 3;
    self.scrollView.backgroundColor = [UIColor blueColor];
    [self.collectionView addSubview:self.scrollView];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:TalkCarScroll parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject ;
        NSArray *array  = dic[@"result"][@"articlelist"];
        for (NSDictionary *dic1 in array) {
            TalkModel *model = [[TalkModel alloc]init];
            model.articletitle = dic1[@"articletitle"];
            model.imgurl = dic1[@"imgurl"];
            model.articleid = dic1[@"articleid"];
            [self.ScrolArray addObject:model];
            NSMutableArray *urlImageArray= [NSMutableArray array];
            for (int i = 0; i < self.ScrolArray.count; i++) {
                NSLog(@"%lu",(unsigned long)self.ScrolArray.count);
                TalkModel *model = self.ScrolArray[i];
                [urlImageArray addObject:model.imgurl];

            }
            NSArray *imageUrlStr = urlImageArray;
        
            self.scrollView.imageURLStringsGroup = imageUrlStr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.scrollView.imageURLStringsGroup = imageUrlStr;
            });
        }
        [self updataView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败++++ %@",error);
        
    }];
    
    }

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"indeax = %ld",(long)index);
    TalkModel *model = self.ScrolArray[index];
    TalkCarScrollViewController *talkVC = [[TalkCarScrollViewController alloc]init];
    talkVC.articleid = model.articleid;
    NSLog(@"model = %@",model.articleid);
    [self.navigationController pushViewController:talkVC animated:YES];
   
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
