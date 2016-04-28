//
//  DataBaseManager.h
//  UIProject_1Dramer
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 zcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DataBaseManager : NSObject
// 对外暴露数据库单利对象
@property (nonatomic, strong) FMDatabase *database;

+ (instancetype)defaultManager;

- (void)closeDatebase;
@end
