//
//  ToolData.h
//  CarPark
//
//  Created by 吴朝胜 on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestDataBlock)(id object);

@interface ToolData : NSObject

+ (void)requestDataWithUrl:(NSString *)urlStr
            withHTTPMethod:(NSString *)methodStr
              withHTTPBody:(NSString *)bodyStr
       withReqestDataBlock:(RequestDataBlock)requestDataBlock;

@end
