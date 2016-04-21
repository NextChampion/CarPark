//
//  ImportDetailsViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "ImportDetailsViewController.h"
#import "ImportNewsViewController.h"
@interface ImportDetailsViewController ()

@end

@implementation ImportDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction:)];
    

}

-(void)backAction:(UIBarButtonItem *)sender{
    
   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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
