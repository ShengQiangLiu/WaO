//
//  SignInViewController.m
//  WaO
//
//  Created by admin on 15/9/20.
//  Copyright © 2015年 ShengQiangLiu. All rights reserved.
//

#import "SignInViewController.h"
#import "RegisterViewController.h"
#import "SigninViewModel.h"
#import "NSString+EmailAdditions.h"
#import "SigninHandler.h"

@interface SignInViewController ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *logInButton;

@property (nonatomic, strong) SigninViewModel *viewModel;

@end

@implementation SignInViewController

- (instancetype)init {
    if (self = [super init]) {
        self.viewModel = [[SigninViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(240, 240, 240);

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerBtnClick:)];
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.image = [UIImage imageNamed:@"haha.png"];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.headImageView];
    
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    //    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    //    imageView1.image = [UIImage imageNamed:];
    //    self.usernameTextField.leftView = imageView1;
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.placeholder = @"  username";
    [self.view addSubview:self.emailTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.placeholder = @"  password";
    [self.view addSubview:self.passwordTextField];
    
    self.logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logInButton.backgroundColor = RGB(127, 127, 127);
    self.logInButton.layer.cornerRadius = 5;
    [self.logInButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.logInButton];
    
    [self viewLayout];
    [self bindWithViewModel];

}

- (void)registerBtnClick:(id)sender {
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
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


- (void)bindWithViewModel {
    
    // 这里监听，里面的信号才会启动
    RAC(self.viewModel, email) = self.emailTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    self.logInButton.rac_command = self.viewModel.loginCommand;
    [RACObserve(self.viewModel, statusMessage) subscribeNext:^(NSString *value) {
        if (value.isExist) {
            if ([value isEqualToString:@"START"]) {
                [SVProgressHUD showWithStatus:@"Logging in..." maskType:SVProgressHUDMaskTypeClear];
            } else if ([value isEqualToString:@"COMPLETED"]){
                [SVProgressHUD dismiss];
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"SUCCESS" description:@"注册成功" type:TWMessageBarMessageTypeSuccess statusBarStyle:UIStatusBarStyleLightContent callback:NULL];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[SigninHandler sharedInstance] setupHomeViewController];
                });
            } else  {
                [SVProgressHUD dismiss];
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"ERROR" description:[NSString stringWithFormat:@"%@", value] type:TWMessageBarMessageTypeError statusBarStyle:UIStatusBarStyleLightContent callback:NULL];
            }
        }
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
