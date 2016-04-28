//
//  ImportDetailsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportDetailsViewController.h"
#import "ImportantDetailTypeOneCell.h"
#import "ImportantDetailTypeTwoCell.h"
#import "ImportDetailModel.h"
#import "ImportantDetailheaderModel.h"
#import "ImportantDetailHeaderView.h"



@interface ImportDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ImportDetailsViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    [manager GET:self.requestStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"content"];
        ImportantDetailheaderModel *headerModel = [[ImportantDetailheaderModel alloc] init];
        [headerModel setValuesForKeysWithDictionary:dataDic[@"data"]];
        ImportantDetailHeaderView *view = [[ImportantDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        [view setDataWithModel:headerModel];
        
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
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView registerClass:[ImportantDetailTypeOneCell class] forCellReuseIdentifier:@"oneCell"];
    [self.tableView registerClass:[ImportantDetailTypeTwoCell class] forCellReuseIdentifier:@"twoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImportDetailModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    if (type == 1) {
        ImportantDetailTypeOneCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        [cell setDataWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(type == 2){
        
        ImportantDetailTypeTwoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        [cell setDataWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImportDetailModel *model = self.tableArray[indexPath.row];
    if (model.type == 1) {
        
        NSInteger height = [self stringHeight:model.content] + 25;
        return height;
        
    }else if (model.type == 2) {
        
        NSArray *array = model.style;
        NSInteger width = [array[0][@"width"] integerValue];
        NSInteger height = [array[0][@"height"] integerValue];
        NSInteger H = height*ScreenWidth/width;
        return H;
    }
    return 0;
}

// 自适应高度
- (CGFloat)stringHeight:(NSString *)aString{
    // !!!: 1 传参数的时候,宽度最好和以前的label宽度一样  2 字体的大小,最好和label上面字体的大小一样
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(ScreenWidth - 40, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    return temp.size.height;
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
