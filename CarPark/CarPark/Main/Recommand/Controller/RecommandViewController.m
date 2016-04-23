//
//  RecommandViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "RecommandViewController.h"
#import "RecommandTableCell.h"

@interface RecommandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation RecommandViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView{
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommandTableCell" bundle:nil] forCellReuseIdentifier:@"RecommandTableCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommandTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommandTableCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
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
