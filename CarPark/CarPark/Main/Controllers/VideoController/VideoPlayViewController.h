//
//  VideoPlayViewController.h
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseViewController.h"

@interface VideoPlayViewController : BaseViewController
@property (nonatomic, strong) NSString *web_URL;
@property (nonatomic, strong) NSString *videoid;
@property (nonatomic, strong) NSString *modifytime;// 传值  拼接到 请求连接里 做参数确定cell对应的新闻内容
@property (nonatomic, strong) NSString *requestStr; // 请求链接
@property (nonatomic, strong) NSString *contentTitle;
@property (nonatomic, strong) NSString *publishTime;
//@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *type;
@end
