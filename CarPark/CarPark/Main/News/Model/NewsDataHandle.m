//
//  NewsDataHandle.m
//  CarPark
//
//  Created by 吴朝胜 on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "NewsDataHandle.h"
#import "ToolData.h"
#import "NewCarsModel.h"

@interface NewsDataHandle ()
@property(nonatomic,assign)NSInteger index;
@end

@implementation NewsDataHandle

+ (NewsDataHandle *)shareNewsDataHandle{
    static NewsDataHandle *newsDataHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (newsDataHandle == nil) {
            newsDataHandle = [NewsDataHandle new];
        }
    });
    return newsDataHandle;
}

// 请求20条数据
- (void)aychronDataWithReloadDataBlock:(ReloadDataBlock)reloadDataBlock{
    [ToolData requestDataWithUrl:@"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=3&serialid=&pageindex=1&pagesize=20&appver=7.0" withHTTPMethod:nil withHTTPBody:nil withReqestDataBlock:^(id object) {
        NSDictionary *firstDic = (NSDictionary *)object;
        NSDictionary *dataDic = firstDic[@"data"];
        NSArray *dataArray = dataDic[@"list"];
        self.newsArray = [NSMutableArray new];
        for (NSDictionary *d in dataArray) {
            NewCarsModel *model = [NewCarsModel new];
            [model setValuesForKeysWithDictionary:d];
            [self.newsArray addObject:model];
        //    NSLog(@"%@",model);
        }
        reloadDataBlock();
    }];
}
// 调用一次, 向下翻页
- (void)aychronDataWithReloadDataBlock1:(ReloadDataBlock)reloadDataBlock{
    
    NSString * string = [NSString stringWithFormat:@"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=3&serialid=&pageindex=%ld&pagesize=20&appver=7.0",(long)self.index++];
    NSLog(@"%ld",(long)self.index);
    [ToolData requestDataWithUrl:string withHTTPMethod:nil withHTTPBody:nil withReqestDataBlock:^(id object) {
        NSDictionary *firstDic = (NSDictionary *)object;
        NSDictionary *dataDic = firstDic[@"data"];
        NSArray *dataArray = dataDic[@"list"];
        for (NSDictionary *d in dataArray) {
            NewCarsModel *model = [NewCarsModel new];
            [model setValuesForKeysWithDictionary:d];
            [self.newsArray addObject:model];
            NSLog(@"%@",model);
        }
        reloadDataBlock();
    }];
}

@end
