//
//  RegisterViewController.m
//  CarPark
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 com.lcarpark.zfw. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UITextField *usernameTextField;// 账号
@property (nonatomic, strong) UITextField *passwordTextField;// 密码
@property (nonatomic, strong) UITextField *passwordTextField2;// 密码

@end

@implementation RegisterViewController

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
    [back setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
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
    self.usernameTextField.placeholder = @"请输入手机号";
//    self.usernameTextField.borderStyle = UITextBorderStyleLine;
    self.usernameTextField.secureTextEntry = YES;
    self.usernameTextField.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, self.usernameTextField.bounds.size.height)];
    self.usernameTextField.leftView.backgroundColor = [UIColor clearColor];
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.usernameTextField];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.centerY.equalTo(weakSelf.view.mas_centerY).offset(-100);
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
    self.passwordTextField.placeholder = @"设置登录密码";
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
    
    // 确认密码
    self.passwordTextField2 = [[UITextField alloc] init];
    self.passwordTextField2.placeholder = @"请再次输入密码";
//    self.passwordTextField2.borderStyle = UITextBorderStyleLine;
    self.passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField2.secureTextEntry = YES;
    self.passwordTextField2.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.passwordTextField.bounds.size.height)];
    self.passwordTextField2.leftView.backgroundColor = [UIColor blackColor];
    self.passwordTextField2.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwordTextField2];
    [self.passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.usernameTextField.mas_leading);
        make.trailing.equalTo(weakSelf.usernameTextField.mas_trailing);
        make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(-0.5);
        make.height.equalTo(weakSelf.usernameTextField.mas_height);
    }];
    
    // 确认密码上加一根线
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.bottom.equalTo(self.passwordTextField2.mas_top);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    // 确认密码下加一根线
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(self.passwordTextField2.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
    }];
    
    // logo
    UIImageView *logo = [[UIImageView alloc] init];
    logo.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(line.mas_top);
        make.width.equalTo(@(ScreenWidth / 2));
        make.height.equalTo(@(ScreenHeight / 5));
    }];
    
    
    // 登录按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setTitle:@"提交" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor orangeColor];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.passwordTextField2.mas_bottom).offset(25);
        make.width.equalTo(@(ScreenWidth- 60));
        make.height.equalTo(@(ScreenHeight/18));
    }];
    
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerButtonAction{
    NSLog(@"注册账号");
}

// 点击屏幕收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordTextField2 resignFirstResponder];
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
