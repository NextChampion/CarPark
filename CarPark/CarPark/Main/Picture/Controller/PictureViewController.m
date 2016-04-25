//
//  PictureViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureDisplayViewController.h"

#import "PictureModel.h"
#import "TypeTwoCell.h"
#import "TypeThreeCell.h"


@interface PictureViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;

@end

@implementation PictureViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
    [self handleData];
}

- (void)handleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.ycapp.yiche.com/AppNews/GetAppNewsAlbumList?page=1&length=20&platform=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"];
        for (NSDictionary *dic in array) {
            PictureModel *model = [[PictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        NSLog(@"%@",self.tableArray);
        [self setupView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


-(void)setupView{
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TypeThreeCell class] forCellReuseIdentifier:@"picture3Cell"];
    [self.tableView registerClass:[TypeTwoCell class] forCellReuseIdentifier:@"picture2Cell"];
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureModel *model = self.tableArray[indexPath.row];
    
    NSArray *array = [model.picCover componentsSeparatedByString:@";"];
    if (array.count == 3) {
        TypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture3Cell" forIndexPath:indexPath];
        cell.titleLabel.text = model.title;
        cell.srcLabel.text = model.src;
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
        [cell.picCoverImageLeft sd_setImageWithURL:[NSURL URLWithString:array[0]]];
        [cell.picCoverImageMid sd_setImageWithURL:[NSURL URLWithString:array[1]]];
        [cell.picCoverImageRight sd_setImageWithURL:[NSURL URLWithString:array[2]]];
        return cell;
    }
    TypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picture2Cell" forIndexPath:indexPath];
    cell.titleLabel.text = model.title;
    cell.srcLabel.text = model.src;
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    [cell.picCoverImage sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureModel *model = self.tableArray[indexPath.row];
    PictureDisplayViewController *pictureDisplayVC = [[PictureDisplayViewController alloc] init];
    pictureDisplayVC.newsId = model.newsId;
    pictureDisplayVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:pictureDisplayVC animated:YES completion:nil];
//    [self.navigationController pushViewController:pictureDisplayVC animated:YES];
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
