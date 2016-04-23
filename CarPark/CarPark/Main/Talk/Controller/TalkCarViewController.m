//
//  TalkCarViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TalkCarViewController.h"

@interface TalkCarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UICollectionViewFlowLayout *CollectionLayout;

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

}

#pragma mark - 创建collectionView
-(void)setUpCollection{
    
    self.CollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    //headerView大小
    self.CollectionLayout.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenHeight / 4);
    self.CollectionLayout.itemSize = CGSizeMake(ScreenWidth, 150);
//    self.CollectionLayout.minimumInteritemSpacing = 1;
    self.CollectionLayout.minimumLineSpacing = 3;
    
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = ScreenWidth;
    CGFloat collectionViewH = ScreenHeight;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:self.CollectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.collectionView registerNib:[UINib nibWithNibName:@"TalkCarViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionID];
    
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 50;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
 
    cell.backgroundColor = [UIColor redColor];
    
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
