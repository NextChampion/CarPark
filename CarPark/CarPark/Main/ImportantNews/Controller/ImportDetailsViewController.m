//
//  ImportDetailsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportDetailsViewController.h"
#import "ImportNewsViewController.h"
#import "DataModel.h"


@interface ImportDetailsViewController ()

@end

@implementation ImportDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction:)];
   
}



- (void)handleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString * str =  @"http://api.ycapp.yiche.com/appnews/GetStructNews?newsId=31801&ts=20160422164303&plat=2&theme=0&version=7.0";
    NSString *str1 = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/GetStructNews?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",self.newsId,self.lastModify];
    NSLog(@"%@",str1);
    [manager GET:str1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"content"];
        ImportantDetailheaderModel *headerModel = [[ImportantDetailheaderModel alloc] init];
        [headerModel setValuesForKeysWithDictionary:dataDic[@"data"]];
        ImportantDetailHeaderView *view = [[ImportantDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        [view setDataWithModel:headerModel];
        
        NSLog(@"responseObject = %@",array);
        for (NSDictionary *dic in array) {
            ImportDetailModel *model = [[ImportDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        [self setupView];
        self.tableView.tableHeaderView = view;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void)setupView{
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 64;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight - 64;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"importantDetailCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView registerClass:[ImportantDetailTypeOneCell class] forCellReuseIdentifier:@"oneCell"];
    [self.tableView registerClass:[ImportantDetailTypeTwoCell class] forCellReuseIdentifier:@"twoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

-(void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    
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
