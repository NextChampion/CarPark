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

//#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface NewCarsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionDataArray;

@end

@implementation NewCarsViewController

- (NSMutableArray *)collectionDataArray{
    if (_collectionDataArray) {
        _collectionDataArray = [[NSMutableArray alloc] init];
    }
    return _collectionDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[NewCarsCell class] forCellWithReuseIdentifier:@"newCarCell"];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView{
    UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
    [textButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    textButton.backgroundColor = [UIColor blueColor];
    [textButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:textButton];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.itemSize = CGSizeMake(ScreenWidth / 2, ScreenHeight / 4);
    
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = ScreenHeight / 3;
    CGFloat collectionViewW = ScreenWidth;
    CGFloat collectionViewH = ScreenHeight / 3 * 2;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
}

- (void)buttonAction:(UIButton *)sender{
    NSLog(@"这个button能点击");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.collectionDataArray.count;
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewCarsModel *model = self.collectionDataArray[indexPath.row];
    NewCarsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newCarCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    [cell setDataWithModel:model];
    return cell;
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
