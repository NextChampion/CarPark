//
//  ToolData.m
//  CarPark
//
//  Created by 吴朝胜 on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ToolData.h"

@implementation ToolData
+ (void)requestDataWithUrl:(NSString *)urlStr
            withHTTPMethod:(NSString *)methodStr
              withHTTPBody:(NSString *)bodyStr
       withReqestDataBlock:(RequestDataBlock)requestDataBlock
{
    
    //1.准备网址对象url
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    //2.准备请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    if ([methodStr isEqualToString:@"POST"]) {
        [request setHTTPMethod:methodStr];
        NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    //3.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //4.创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err = nil;
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        if (nil == err) {
            //回调传值（将请求到的数据传到数据管理类再操作）
            requestDataBlock(object);
            
        }else
        {
            NSLog(@"解析失败！%@", err);
        }
        
    }];
    //5.执行任务
    [task resume];
    
    
    
    
}
@end
