//
//  PictureDisplayViewController.h
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "BaseViewController.h"

@interface PictureDisplayViewController : BaseViewController
@property (nonatomic, assign) BOOL isImportantPush;
@property (nonatomic, strong) NSString *requestStr;
@property (nonatomic, strong) NSString *contentTitle;
@property (nonatomic, strong) NSString *publishTime;
//@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *type;
@end
