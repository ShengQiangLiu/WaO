//
//  SignInViewController.m
//  WaO
//
//  Created by admin on 15/9/20.
//  Copyright © 2015年 ShengQiangLiu. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *logInButton;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(240, 240, 240);

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerBtnClick:)];
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.image = [UIImage imageNamed:@"haha.png"];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.headImageView];
    
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    //    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    //    imageView1.image = [UIImage imageNamed:];
    //    self.usernameTextField.leftView = imageView1;
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.placeholder = @"  username";
//    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.emailTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.placeholder = @"  password";
//    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordTextField];
    
    self.logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logInButton.backgroundColor = RGB(127, 127, 127);
    self.logInButton.layer.cornerRadius = 5;
    [self.logInButton setTitle:@"登录" forState:UIControlStateNormal];
//    self.logInButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.logInButton];
    
    [self viewLayout];

}

- (void)registerBtnClick:(id)sender {
//    [self.navigationController pushViewController:[SQRegisterViewController new] animated:YES];
}

- (void)viewLayout {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(VScale(100));
        make.size.mas_equalTo(CGSizeMake(HScale(80), VScale(80)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).with.offset(VScale(20));
        make.left.equalTo(self.view.mas_left).with.offset(HScale(15));
        make.right.equalTo(self.view.mas_right).with.offset(HScale(-15));
        make.height.mas_equalTo(VScale(40));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(VScale(20));
        make.left.equalTo(self.view.mas_left).with.offset(HScale(15));
        make.right.equalTo(self.view.mas_right).with.offset(HScale(-15));
        make.height.mas_equalTo(VScale(40));
    }];
    [self.logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(VScale(20));
        make.left.equalTo(self.view.mas_left).with.offset(HScale(15));
        make.right.equalTo(self.view.mas_right).with.offset(HScale(-15));
        make.height.mas_equalTo(VScale(40));
    }];
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
