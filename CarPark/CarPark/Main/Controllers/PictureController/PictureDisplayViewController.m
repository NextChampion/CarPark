//
//  PictureDisplayViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "PictureDisplayViewController.h"
#import "AutoView.h"
#import "PictureDisplayModel.h"

@interface PictureDisplayViewController ()

@property (nonatomic, strong) NSArray *pictureUrlArray;
@property (nonatomic, strong) NSMutableArray *pictureNameArray;
@property (nonatomic, strong) AutoView *autoView;

@end

@implementation PictureDisplayViewController

- (NSMutableArray *)pictureNameArray{
    if (!_pictureNameArray) {
        _pictureNameArray = [[NSMutableArray alloc] init];
    }
    return _pictureNameArray;
}

-(NSArray *)pictureUrlArray{
    if (!_pictureUrlArray) {
        _pictureUrlArray = [[NSArray alloc] init];
    }
    return _pictureUrlArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
    self.navigationItem.rightBarButtonItem = collectionItem;
    
    [self handleData];
}

// 收藏按钮
-(void)collectionAction{
    NSLog(@"点击了收藏按钮");
//    CollectionListDB *db = [[CollectionListDB alloc] init];
//    [db createTable];
//    DetailHeaderModel *headerModel = self.headerArray[0];
//    NSLog(@"%@",self.headerArray[0]);
//    NSArray *array = [[NSArray alloc] initWithObjects:headerModel.title,headerModel.publishTime,self.requestStr, nil];
//    //    @[headerModel.title,headerModel.publishTime,self.requestStr];
//    NSLog(@"%@-----%@-------%@",headerModel.title,headerModel.publishTime,self.requestStr);
//    NSLog(@"////////%@",array);
//    [db insertCollectionRecordWithArray:array];
}

- (void)handleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    @"http://api.ycapp.yiche.com/appnews/GetNewsAlbum?newsid=31923"
    [manager GET:self.requestStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"albums"];
        NSMutableArray *contentArray = [NSMutableArray array];
        NSMutableArray *imageUrls = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            PictureDisplayModel *model = [PictureDisplayModel new];
            [model setValuesForKeysWithDictionary:dic];
            [contentArray addObject:model.content];
            [imageUrls addObject:model.imageUrl];
        }
        self.pictureNameArray = contentArray;
        self.pictureUrlArray = imageUrls;
        [self setupView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


- (void)setupView{
    
    CGFloat autoViewX = 0;
    CGFloat autoViewY = 0;
    CGFloat autoViewW = ScreenWidth;
    CGFloat autoViewH = ScreenHeight;
    self.autoView = [AutoView imageScrollViewWithFrame:CGRectMake(autoViewX, autoViewY, autoViewW, autoViewH) imageLinkURL:self.pictureUrlArray titleArr:self.pictureNameArray placeHolderImageName:nil pageControlShowStyle:UIPageControlShowStyleNone];
    self.autoView.backgroundColor = [UIColor blackColor];
    self.autoView.isNeedCycleRoll = NO;
    [self.view addSubview:self.autoView];
    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    bar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bar];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backButton];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
