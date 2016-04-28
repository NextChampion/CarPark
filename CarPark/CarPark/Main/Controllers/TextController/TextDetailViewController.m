//
//  TextDetailViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TextDetailViewController.h"
#import "DetailTableViewTypeOneCell.h"
#import "DetailTableViewTypeTwoCell.h"
#import "DetailTableViewTypeThreeCell.h"
#import "DetailModel.h"
#import "DetailHeaderModel.h"
#import "CollectionListDB.h"

@interface TextDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *headerArray;

@end

@implementation TextDetailViewController

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSMutableArray alloc] init];
    }
    return _tableArray;
}

- (NSMutableArray *)headerArray{
    if (!_headerArray) {
        _headerArray = [[NSMutableArray alloc] init];
    }
    return _headerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
    self.navigationItem.rightBarButtonItem = collectionItem;
    // Do any additional setup after loading the view from its nib.
    [self handleData];
    
    
    
    
}


- (void)handleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.requestStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDic = responseObject;
        NSArray *array = dataDic[@"data"][@"content"];
        DetailHeaderModel *headerModel = [[DetailHeaderModel alloc] init];
        NSDictionary *headerDic = [[NSDictionary alloc] init];
        headerDic = [dataDic objectForKey:@"data"];
        [headerModel setValuesForKeysWithDictionary:headerDic];
        [self.headerArray addObject:headerModel];
        for (NSDictionary *dic in array) {
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArray addObject:model];
        }
        [self setupView];
//        self.tableView.tableHeaderView = view;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

// 收藏按钮
-(void)collectionAction{
    NSLog(@"点击了收藏按钮");
    CollectionListDB *db = [[CollectionListDB alloc] init];
    [db createTable];
    DetailHeaderModel *headerModel = self.headerArray[0];
    NSLog(@"%@",self.headerArray[0]);
    NSArray *array = [[NSArray alloc] initWithObjects:headerModel.title,headerModel.publishTime,self.requestStr, nil];
//    @[headerModel.title,headerModel.publishTime,self.requestStr];
    NSLog(@"%@-----%@-------%@",headerModel.title,headerModel.publishTime,self.requestStr);
    NSLog(@"////////%@",array);
    [db insertCollectionRecordWithArray:array];
}

- (void)setupView{
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 64;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight - 64;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"importantDetailCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerClass:[DetailTableViewTypeOneCell class] forCellReuseIdentifier:@"oneCell"];
    [self.tableView registerClass:[DetailTableViewTypeTwoCell class] forCellReuseIdentifier:@"twoCell"];
    [self.tableView registerClass:[DetailTableViewTypeThreeCell class] forCellReuseIdentifier:@"threeCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailModel *model = self.tableArray[indexPath.row];
    NSInteger type = model.type;
    if (indexPath.row == 0) {
        DetailHeaderModel *headerModel = self.headerArray[indexPath.row];
        DetailTableViewTypeThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
        cell.titleLabel.text = headerModel.title;
//        [cell.titleLabel sizeToFit];
        cell.srcLabel.text = headerModel.src;
        [cell.srcLabel sizeToFit];
        cell.publishTimeLabel.text = headerModel.publishTime;
        [cell.publishTimeLabel sizeToFit];
        
        [cell.publishTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.srcLabel.mas_right).offset(10);
            make.bottom.equalTo(cell.srcLabel.mas_bottom);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if (type == 1) {
            DetailTableViewTypeOneCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"oneCell"];
            [cell setDataWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(type == 2){
            
            DetailTableViewTypeTwoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"twoCell"];
            [cell setDataWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailModel *model = self.tableArray[indexPath.row];
    if (indexPath.row == 0) {
        return ScreenHeight/6;
    }else{
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

@end
