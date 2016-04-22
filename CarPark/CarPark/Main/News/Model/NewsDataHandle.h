//
//  NewsDataHandle.h
//  CarPark
//
//  Created by 吴朝胜 on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <Foundation/Foundation.h>

//block用来回调刷新界面
typedef void(^ReloadDataBlock)();

//创建单例
@interface NewsDataHandle : NSObject
//给新车界面赋值的数组
@property (nonatomic,strong) NSMutableArray *newsArray;

+ (NewsDataHandle *)shareNewsDataHandle;

//请求数据
- (void)aychronDataWithReloadDataBlock:(ReloadDataBlock)reloadDataBlock;
// 调用一次, 向下翻页
- (void)aychronDataWithReloadDataBlock1:(ReloadDataBlock)reloadDataBlock;

@end
