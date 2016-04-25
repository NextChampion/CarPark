//
//  TalkCarDetailViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TalkCarDetailViewController.h"
#import "TalkCarDetailModel.h"
#import "TalkCarOneCell.h"
#import "TalkCarTwoCell.h"
#import "TalkCarThreeCell.h"


@interface TalkCarDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) UITableViewStyle *style;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

@implementation TalkCarDetailViewController

-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}

-(NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [[NSDictionary alloc]init];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];

    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.style = UITableViewStylePlain;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TalkCarOneCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TalkCarTwoCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TalkCarThreeCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
     [self RequestData];
    
}

-(void)RequestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/media/GetStructMedia?newsId=%@&ts=%@&plat=2&theme=0&version=7.0",self.newsId,self.lastModify];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataDic = responseObject;
        NSArray *ReqArray = self.dataDic[@"data"][@"content"];
        NSLog(@"%@",self.dataDic[@"data"][@"title"]);
        NSLog(@"%@",self.dataDic[@"data"][@"publishTime"]);
        NSLog(@"%@",self.dataDic[@"data"][@"src"]);
        for (NSDictionary *dic in ReqArray) {
            TalkCarDetailModel *model = [[TalkCarDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
            NSLog(@"请求下来的数据 %@",self.array);
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 %@",error);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TalkCarDetailModel *model = self.array[indexPath.row];
    if ( indexPath.row == 0) {
        TalkCarOneCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell1.titleLabel.text = self.dataDic[@"data"][@"title"];
        NSLog(@"%@",self.dataDic[@"data"][@"title"]);
        cell1.timeLabel.text =  self.dataDic[@"data"][@"publishTime"];
        NSLog(@"%@",self.dataDic[@"data"][@"publishTime"]);
        cell1.srcLabel.text = self.dataDic[@"data"][@"src"];
        NSLog(@"%@",self.dataDic[@"data"][@"src"]);
        return cell1;
        
    }else{
        
        if (model.type == 1) {
         TalkCarThreeCell *cell3
            = [tableView dequeueReusableCellWithIdentifier:@"cell3" ];
            cell3.contentLabel.text = model.content;
           return cell3;
        }
        
        TalkCarTwoCell *cell2
        = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [cell2.imageView sd_setImageWithURL:[NSURL URLWithString:model.content]];
        return cell2;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TalkCarDetailModel *detail = self.array[indexPath.row];
    if (detail.type == 1) {
        NSInteger  height = [self stringHeight:detail.content] + 25;
        NSLog(@" %ld",(long)height);
        return height;
    }
    
    if (detail.type == 2) {
        NSArray *array = detail.style;
        NSInteger width = [array[0][@"width"]integerValue];
        NSInteger height = [array[0][@"height"]integerValue];
        NSInteger H = height * ScreenWidth / width;
        return H;
    }

    return 0;
}

-(CGFloat)stringHeight:(NSString *)aString{
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(ScreenWidth - 40, 100000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return temp.size.height;
    
    
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
