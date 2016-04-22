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


@interface TalkCarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UICollectionViewFlowLayout *CollectionLayout;
@property (nonatomic, assign) NSInteger page;
@end

@implementation TalkCarViewController

static NSString *const collectionID = @"header";

-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"说   车";
    [self setUpCollection];
    [self RequestData];
   
}

#pragma mark - 创建collectionView
-(void)setUpCollection{
    
    self.CollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    //headerView大小
    self.CollectionLayout.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenHeight / 4);
    self.CollectionLayout.itemSize = CGSizeMake(ScreenWidth, 200);
//    self.CollectionLayout.minimumInteritemSpacing = 1;
    self.CollectionLayout.minimumLineSpacing = 3;
    
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = ScreenWidth;
    CGFloat collectionViewH = ScreenHeight;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:self.CollectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
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
            [self.array addObject:model];
            NSLog(@"请求下来的数据%@",responseObject);
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

    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionID forIndexPath:indexPath];
        reusableView = headerView;
    }
    reusableView.backgroundColor = [UIColor grayColor];
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TalkCarDetailViewController *VC = [[TalkCarDetailViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
    
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
