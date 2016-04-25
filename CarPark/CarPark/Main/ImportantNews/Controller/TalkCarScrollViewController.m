//
//  TalkCarScrollViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "TalkCarScrollViewController.h"
#import "TalkModel.h"

@interface TalkCarScrollViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation TalkCarScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor redColor];
    [self CreatwebView];
   
}

-(UIWebView *)CreatwebView{
   
    if (!_webView) {
        NSString *UrlStr = [NSString stringWithFormat:@"http://m.che168.com/list/%@.html?isapp=1",self.articleid];
        self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        self.webView.delegate = self;
        NSLog(@"articleid = %@",UrlStr);
        NSURL *URL = [NSURL URLWithString:UrlStr];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:URL];
        [self.webView loadRequest:request];
          [self.view addSubview:self.webView];
    }
    return _webView;
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
