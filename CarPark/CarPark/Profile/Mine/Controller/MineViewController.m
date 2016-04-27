//
//  MineViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/25.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderCell.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView{
    
    // 设置table
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineHeaderCell" bundle:nil] forCellReuseIdentifier:@"mineHeaderCell"];
//    CGFloat iconX = 20;
//    CGFloat iconY = 20;
//    CGFloat iconW = 40;
//    CGFloat iconH = 40;
//    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
//    self.icon.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.icon];
//    __weak typeof (self) weakSelf = self;
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
//        make.top.equalTo(weakSelf.view.mas_top).offset(40);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//
//    CGFloat nameLabelX = 100;
//    CGFloat nameLabelY = 100;
//    CGFloat nameLabelW = 60;
//    CGFloat nameLabelH = 60;
//    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
//    self.nameLabel.backgroundColor = BackGroudColor;
//    [self.view addSubview:self.nameLabel];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.icon.mas_bottom).offset(10);
//        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
//        make.height.equalTo(@21);
//        make.width.equalTo(@60);
//    }];
    
    


    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cellID";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineHeaderCell"];
            cell.nameLabel.text = @"kvnextchampion";
            [cell.nameLabel sizeToFit];
            cell.iconImage.image = [UIImage imageNamed:@"logo"];
            cell.iconImage.layer.cornerRadius = 50;
            cell.iconImage.layer.masksToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"hahahaa";
        cell.textLabel.text = @"账户信息";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 150;
    }
    return 40;
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
