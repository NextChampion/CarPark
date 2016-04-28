//
//  CollectionListDB.m
//  CarPark
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "CollectionListDB.h"
#import "DataBaseManager.h"
#define collection @"collectionRecord"
@implementation CollectionListDB


- (instancetype)init{
    if (self = [super init]) {
        dataBase = [DataBaseManager defaultManager].database;
    }
    return self;
}



// 建表
- (void)createTable{
    NSString *string = [NSString stringWithFormat:@"create table if not exists %@ (title text,publishTime text,contentURL text)",collection];
    BOOL isCreate = [dataBase executeUpdate:string];
    if (isCreate) {
        NSLog(@"数据库创建成功");
    }else{
        NSLog(@"数据库创建失败");
    }
}

// 增
- (void)insertCollectionRecordWithArray:(NSArray *)array{
    NSString *string = [NSString stringWithFormat:@"insert into %@ (title,publishTime,contentURL) values (?,?,?)",collection];
    // 使用sqlite3_bind 进行参数的绑定
    // 缺点 可读性差
    BOOL isInsert = [dataBase executeUpdate:string withArgumentsInArray:array];// 使用数组绑定参数
    if (isInsert) {
        NSLog(@"添加数据成功");
        
    }else{
        NSLog(@"添加数据失败");
    }
}


// 删
- (void)deleteRecordWithTitle:(NSString *)title{
    if (![dataBase open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    [dataBase setShouldCacheStatements:YES];
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if(![dataBase tableExists:collection])
    {
        return;
    }
    //删除操作
    BOOL isDelete = [dataBase executeUpdate:@"delete from ? where title = ?",collection, [NSString stringWithFormat:@"%@",title]];
    if (isDelete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
    [dataBase close];
}

// 查
- (NSArray *)selectAllRecord{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *string = [NSString stringWithFormat:@"select * from %@",collection];
    FMResultSet *result = [dataBase executeQuery:string];
    while ([result next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[result stringForColumn:@"title"] forKey:@"title"];
        [dic setValue:[result stringForColumn:@"publishTime"] forKey:@"publishTime"];
        [dic setValue:[result stringForColumn:@"contentURL"] forKey:@"contentURL"];
        [array addObject:dic];
    }
    return array;
}

// 清空
- (void)deleteAllRecords{

    NSArray *array = [self selectAllRecord];
    for (NSDictionary *dic in array) {
        [self deleteRecordWithTitle:dic[@"title"]];
    }
}

// 销毁表格
- (void)dropTable{
    BOOL isDrop = [dataBase executeUpdate:@"drop table if exists ?;",collection];
    if (isDrop) {
        NSLog(@"销毁表格成功");
    }else{
        NSLog(@"销毁表格失败");
    }
}
@end
