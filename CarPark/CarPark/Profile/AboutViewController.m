//
//  AboutViewController.m
//  CarPark
//
//  Created by lanou3g on 16/5/3.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITextView *textView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    textView.userInteractionEnabled = NO;
    [self.view addSubview:textView];
    textView.text = @"欢迎提出改进意见\n        邮箱:zcx4150@163.com";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
