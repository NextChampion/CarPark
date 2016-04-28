//
//  CollectionListDB.h
//  CarPark
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionListDB : NSObject{
    FMDatabase *dataBase;
}
// 建表
- (void)createTable;
// 增
- (void)insertCollectionRecordWithArray:(NSArray *)array;
// 删
- (void)deleteRecordWithTitle:(NSString *)title;
// 查
- (NSArray *)selectAllRecord;
// 清空
- (void)deleteAllRecords;
// 销毁表格
- (void)dropTable;

@end
