//
//  NewCarsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NewCarsViewController.h"
#import "NewCarsCell.h"
#import "NewCarsModel.h"
#import "BaseCollectionViewCell.h"
#import "NewsDataHandle.h"
#import "MJRefresh.h"
//#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NewCarsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) NSMutableArray *collectionDataArray;
@property (nonatomic, strong) SDCycleScrollView *scrollview;

@end

@implementation NewCarsViewController

//- (NSMutableArray *)collectionDataArray{
//    if (_collectionDataArray) {
//        _collectionDataArray = [[NSMutableArray alloc] init];
//    }
//    return _collectionDataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    __weak typeof(self) weakSelf = self;
    [[NewsDataHandle shareNewsDataHandle] aychronDataWithReloadDataBlock:^{
        [weakSelf.collectionView reloadData];
    }];
    
      [self setUpScroll];
    [self reloadUpData];
}

- (void)setupView{
    //    UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
    //    [textButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    textButton.backgroundColor = [UIColor blueColor];
    //    [textButton setTitle:@"测试" forState:UIControlStateNormal];
    //    [self.view addSubview:textButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenHeight / 4);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 3;
    //    flowLayout.itemSize = CGSizeMake(ScreenWidth / 2, ScreenHeight / 4);
    flowLayout.itemSize = CGSizeMake((ScreenWidth)/2 - 1, 150);
    
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = ScreenWidth;
    CGFloat collectionViewH = ScreenHeight;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewCarsCell" bundle:nil] forCellWithReuseIdentifier:@"NewCarsCell_id"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
- (void)reloadUpData{
    __weak typeof(self) weakSelf = self;
    //上拉加载
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[NewsDataHandle shareNewsDataHandle] aychronDataWithReloadDataBlock:^{
            [self.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView reloadData];
        }];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSLog(@"ssss");
        [[NewsDataHandle shareNewsDataHandle] aychronDataWithReloadDataBlock1:^{
            [self.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
        }];
    }];
}
- (void)buttonAction:(UIButton *)sender{
    NSLog(@"这个button能点击");
}
- (void)loadingAction{
    __weak typeof(self) weakSelf = self;
    [[NewsDataHandle shareNewsDataHandle] aychronDataWithReloadDataBlock1:^{
        [weakSelf.collectionView reloadData];
    }];
}
#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.collectionDataArray.count;
    NSLog(@"%ld",[NewsDataHandle shareNewsDataHandle].newsArray.count);
    return [NewsDataHandle shareNewsDataHandle].newsArray.count;
}

// 设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewCarsModel *model = [NewsDataHandle shareNewsDataHandle].newsArray[indexPath.row];
    
    NewCarsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewCarsCell_id" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    
    [cell setDataWithModel:model];
    return cell;
}
// headerview

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableview = headerView;
    }
    
    //    if (kind == UICollectionElementKindSectionFooter)
    //    {
    //        RecipeCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    //
    //        reusableview = footerview;
    //    }
    
    reusableview.backgroundColor = [UIColor blueColor];
    return reusableview;
    
}


-(void)setUpScroll{

    NSArray *imageUrl = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1461153522&di=234814c99ea6fa939b8c593376bae916&src=http://img1a.xgo-img.com.cn/pics/1538/a1537491.jpg"
                          ,@"http://static.sporttery.cn/images/130517/18-13051G32G3-52.jpg"];
    NSArray *titleUrl = @[@"打打瞌睡的奇偶",@"圣诞节哦我"];

    CGFloat scrollX = 0;
    CGFloat scrollY = 0;
    CGFloat scrollW = ScreenWidth;
    CGFloat scrollH = ScreenHeight / 4;
    self.scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(scrollX, scrollY, scrollW, scrollH) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    self.scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.scrollview.titlesGroup = titleUrl;
    self.scrollview.currentPageDotColor = [UIColor redColor];
    self.scrollview.autoScrollTimeInterval = 3;
    [self.collectionView addSubview:self.scrollview];
    self.scrollview.imageURLStringsGroup = imageUrl;


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
