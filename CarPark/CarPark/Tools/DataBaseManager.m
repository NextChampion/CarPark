//
//  DataBaseManager.m
//  UIProject_1Dramer
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 zcx. All rights reserved.
//

#import "DataBaseManager.h"
#define SqliteName @"collectionRecord.sqlite"

@implementation DataBaseManager

+ (instancetype)defaultManager{
    static DataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        // 获取document路径
        NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 创建数据库路径
        NSString *path = [string stringByAppendingPathComponent:SqliteName];

        // 打开数据库
        self.database = [[FMDatabase alloc] initWithPath:path];
        BOOL isOpen = [self.database open];
        if (!isOpen) {
            NSLog(@"打开数据库库失败");
        }
        
    }
    return  self;
}


- (void)closeDatebase{
    [self.database close];
}

@end
