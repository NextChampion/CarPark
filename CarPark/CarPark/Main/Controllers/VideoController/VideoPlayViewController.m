//
//  VideoPlayViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "CollectionListDB.h"

@interface VideoPlayViewController (){
    BOOL isCollected;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *collectionItem; // 收藏按钮

@end

@implementation VideoPlayViewController

- (NSString *)web_URL{
    if (!_web_URL) {
        _web_URL = [[NSString alloc] init];
    }
    return _web_URL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.contentTitle);
    CollectionListDB *db = [[CollectionListDB alloc] init];
    isCollected = [db selectRecordWithTitle:self.contentTitle];
    NSLog(@"%@",self.contentTitle);
    if (isCollected) {  // 如果收藏过
        self.collectionItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect_selected.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
        self.navigationItem.rightBarButtonItem = self.collectionItem;
    }else{
        self.collectionItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
        self.navigationItem.rightBarButtonItem = self.collectionItem;
    }
    
    self.web_URL = self.requestStr;
    
    [self setupWebview];
}

// 收藏按钮
// 收藏按钮
- (void)collectionAction{
    NSLog(@"点击了收藏按钮");
    CollectionListDB *db = [[CollectionListDB alloc] init];
    if (isCollected) {
        NSLog(@"想取消收藏");
        // 取消收藏
        [self.collectionItem setImage:[UIImage imageNamed:@"collect.png"]];
        [db deleteRecordWithTitle:self.contentTitle];
        isCollected = NO;
    }else{
        NSLog(@"想收藏这一页");
        [self.collectionItem setImage:[UIImage imageNamed:@"collect_selected.png"]];
        [db createTable];
        NSArray *array = [[NSArray alloc] initWithObjects:self.contentTitle,self.publishTime,self.requestStr, self.type,nil]; // 存标题 链接
        [db insertCollectionRecordWithArray:array];
        isCollected = YES;
    }
}


- (void)setupWebview{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.webView];
    NSString *newURL = [self importStyleWithHtmlString:self.web_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newURL]];
    [self.webView loadRequest:request];
    
}

// 将html进行处理
- (NSString *)importStyleWithHtmlString:(NSString *)HTML
{
    //老的字符串通过HTML这个参数传递过来
    
    //先找到布局文件的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"style" ofType:@"css"];
    NSLog(@"-%@",filePath);
    
    //替换HTML字符串中的布局， 修改为通过本地文件配置
    //1.先写一个可用于配置布局的字符串命令，并设置配置类型为本地的文件（命令都是HTML语言， 可以不用懂， 大致知道什么意思就可以了， 文件内容可以让webView中的图片适应屏幕宽度）
    NSString *replace = [NSString stringWithFormat:@"<link href=\"%@\" rel=\"stylesheet\" type=\"text/css\"/>",filePath];
    //2.替换原有的命令字符串
    HTML = [HTML stringByReplacingOccurrencesOfString:@"</head>" withString:replace];
    NSLog(@"HTML:%@",HTML);
    
    //返回新配置的HTML字符串
    return HTML;
    
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
