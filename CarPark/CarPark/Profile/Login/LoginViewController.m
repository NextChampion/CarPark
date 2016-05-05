//
//  LoginViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}

- (void)setupView{
    
    __weak typeof (self) weakSelf = self;
    
    
    // 返回上一页按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    [back setTitleColor:BackGroudColor forState:UIControlStateNormal];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    // 用户名
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.placeholder = @"请输入账号";
    //    self.usernameTextField.borderStyle = UITextBorderStyleLine;
    self.usernameTextField.secureTextEntry = YES;
    self.usernameTextField.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, self.usernameTextField.bounds.size.height)];
    self.usernameTextField.leftView.backgroundColor = [UIColor clearColor];
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.usernameTextField];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.centerY.equalTo(weakSelf.view.mas_centerY).offset(-80);
        make.height.equalTo(@(ScreenHeight/15));
    }];
    
    // 用户名上加一根线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.bottom.equalTo(self.usernameTextField.mas_top);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    // 密码
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    //    self.passwordTextField.borderStyle = UITextBorderStyleLine;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.passwordTextField.bounds.size.height)];
    self.passwordTextField.leftView.backgroundColor = [UIColor blackColor];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.usernameTextField.mas_leading);
        make.trailing.equalTo(weakSelf.usernameTextField.mas_trailing);
        make.top.equalTo(weakSelf.usernameTextField.mas_bottom).offset(-0.5);
        make.height.equalTo(weakSelf.usernameTextField.mas_height);
    }];
    
    // 密码上加一根线
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.bottom.equalTo(self.passwordTextField.mas_top);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    // 确认密码下加一根线
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    // logo
    UIImageView *logo = [[UIImageView alloc] init];
    //    logo.backgroundColor = BackGroudColor;
    [logo sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"logo_word.png"]];
    [logo setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(line.mas_top).offset(-40);
        make.width.equalTo(@(ScreenWidth / 2));
        make.height.equalTo(@(ScreenHeight / 10));
    }];
    
    
    // 登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"登       陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = BackGroudColor;
    [loginButton setTintColor:[UIColor whiteColor]];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(50);
        make.width.equalTo(@(ScreenWidth- 60));
        make.height.equalTo(@(ScreenHeight/18));
    }];
    
    // 注册新用户按钮
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"注册新用户" forState:UIControlStateNormal];
    [button setTitleColor:BackGroudColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.width.equalTo(@(ScreenWidth/4));
        make.height.equalTo(@30);
    }];
    
    
}

// 返回按钮
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self setupMenuView];
}

// 登陆接口
- (void)loginAction{
//    NSLog(@"登录账号");
}

// 注册跳转
- (void)registerAction{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [registerVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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
