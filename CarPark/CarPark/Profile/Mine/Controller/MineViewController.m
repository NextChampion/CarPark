//
//  MineViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/25.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderCell.h"
#import <StoreKit/StoreKit.h>
#import "AboutViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SKStoreProductViewControllerDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, assign) BOOL switchState;
@end

@implementation MineViewController



- (UISwitch *)switchView{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    
    
    if (self.isPresent) {
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = back;
    }
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
//    if (self.isPresent) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAllowMenuShow"] isEqualToString:@"YES"]) {
            self.switchState = YES;
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAllowMenuShow"] isEqualToString:@"NO"]){
            self.switchState = NO;
        }
//    }
    
}

//- (void)viewDidDisappear:(BOOL)animated{
//    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",self.switchState] forKey:@"isAllowMenuShow"];
//}

- (void)backAction{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupView{
    
    // 设置table
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineHeaderCell" bundle:nil] forCellReuseIdentifier:@"mineHeaderCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 1;
            break;
    }
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cellID";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineHeaderCell"];
            cell.nameLabel.text = @"CarPark";
            [cell.nameLabel sizeToFit];
            cell.iconImage.image = [UIImage imageNamed:@"111.png"];
            cell.iconImage.layer.cornerRadius = 50;
            cell.iconImage.layer.masksToBounds = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeIconImage)];
            cell.iconImage.userInteractionEnabled = YES;
            [cell.iconImage addGestureRecognizer:tap];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//    if (indexPath.section == 1) {
        switch (indexPath.section) {
            case 1:
            {
                if (indexPath.row == 0) {
                    if (cell) {
                        cell.accessoryView = self.switchView;
                        self.switchView.on = self.switchState;
                        [self.switchView addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
                        //                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.textLabel.text = @"悬浮按钮";
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }

                }else if (indexPath.row == 1){
                    if (cell) {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.textLabel.text = @"清理缓存";
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                }
            }
                break;
            case 2:
            {
                if (cell) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = @"评价";
                }
            }
                break;
            case 3:
            {
                if (cell) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = @"关于我们";
                }
            }
                break;

            default:
                break;
        }
//    }
    return cell;
}

- (void)switchAction{
    // 更改是否显示悬浮按钮的属性
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAllowMenuShow"] isEqualToString:@"YES"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isAllowMenuShow"];
//        self.switchState = NO;
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isAllowMenuShow"];
//        self.switchState = YES;
    }

}

- (void)changeIconImage{

    // 弹出系统的相册
    // 选择控制器（系统相册）
    UIImagePickerController *picekerVc = [[UIImagePickerController alloc] init];

    // 设置选择控制器的来源
    // UIImagePickerControllerSourceTypePhotoLibrary 相册集
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum:照片库
    picekerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

    // 设置代理
    picekerVc.delegate = self;

    // modal
    [self presentViewController:picekerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 当用户选择一张图片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     // 获取选中的照片
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MineHeaderCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.iconImage.image = image;
     // 把选中的照片画到画板上

//     _drawView.image = image;

     // dismiss
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 150;
    }
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            // 什么都不做
            break;
        case 1:{
            if (indexPath.row == 0) {
                // 什么都不做
            }else{
                
                CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject]
                + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
                
                NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.2fK, 删除缓存", size * 1024.0];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                    [self cleanCaches];
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
                [alert addAction:action];
                [alert addAction:cancel];
                [self showDetailViewController:alert sender:nil];
                
//                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//                [self.view addSubview:HUD];
//                HUD.delegate = self;
//                HUD.labelText = @"正在清理内存";
//                HUD.dimBackground = YES;
//                [HUD showWhileExecuting:@selector(clearAction) onTarget:self withObject:nil animated:YES];
        }
            break;
        case 2:
            {

                SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
                //设置代理请求为当前控制器本身
                storeProductViewContorller.delegate = self;
                //加载一个新的视图展示
                [storeProductViewContorller loadProductWithParameters:
                 //appId
#warning 需要改成自己的appid
                 @{SKStoreProductParameterITunesItemIdentifier : @"67787803"} completionBlock:^(BOOL result, NSError *error) {
                     //block回调
                     if(error){
                         NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                     }else{
                         //模态弹出AppStore应用界面
                         [self presentViewController:storeProductViewContorller animated:YES completion:nil];
                     }
                 }];
            }
            }
            break;
        case 3:{
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        default:
            break;
    }
}



// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理</span>
    
    NSFileManager *manager = [NSFileManager defaultManager]; CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}

// 根据路径删除文件
- (void)cleanCaches:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

- (void)cleanCaches
{
    [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject];
    [self cleanCaches:NSTemporaryDirectory()];
}

#pragma mark - SKStoreProductViewControllerDelegate
//取消按钮监听方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD*)hud {
    [hud removeFromSuperview];
    hud = nil;
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
