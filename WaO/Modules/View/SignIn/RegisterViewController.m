//
//  RegisterViewController.m
//  WaO
//
//  Created by Sniper on 15/9/20.
//  Copyright © 2015年 ShengQiangLiu. All rights reserved.
//

#import "RegisterViewController.h"
#import "SigninHandler.h"
#import "NSString+EmailAdditions.h"
#import "RegisterViewModel.h"

@interface RegisterViewController ()
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) RegisterViewModel *viewModel;

@end


@implementation RegisterViewController

- (instancetype)init {
    if (self = [super init]) {
        self.viewModel = [[RegisterViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.placeholder = NSLocalizedString(@"  username", nil);
    self.usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.usernameTextField];
    
    
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.placeholder = NSLocalizedString(@"  email ", nil);
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.emailTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.placeholder = NSLocalizedString(@"  password", nil);
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordTextField];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = RGB(127, 127, 127);
    self.registerButton.layer.cornerRadius = 5;
    [self.registerButton setTitle:NSLocalizedString(@"注册", nil)  forState:UIControlStateNormal];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.registerButton];

    [self subviewsLayout];

    [self bindWithViewModel];
    
}

- (void)subviewsLayout {
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(VScale(150));
        make.left.equalTo(self.view.mas_left).with.offset(HScale(15));
        make.right.equalTo(self.view.mas_right).with.offset(HScale(-15));
        make.height.mas_equalTo(VScale(40));
    }];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(VScale(20));
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
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(VScale(20));
        make.left.equalTo(self.view.mas_left).with.offset(HScale(15));
        make.right.equalTo(self.view.mas_right).with.offset(HScale(-15));
        make.height.mas_equalTo(VScale(40));
    }];
    
}

- (void)bindWithViewModel {
    RAC(self.viewModel, email) = self.emailTextField.rac_textSignal;
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    self.registerButton.rac_command = self.viewModel.registerCommand;
    [RACObserve(self.viewModel, signinState) subscribeNext:^(NSString *state) {
        if (state.isExist) {
            if ([state isEqualToString:@"START"]) {
                [SVProgressHUD showWithStatus:@"注册中...."  maskType:SVProgressHUDMaskTypeClear];
            } else if ([state isEqualToString:@"COMPLETED"]) {
                [SVProgressHUD dismiss];
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"SUCCESS" description:@"注册成功" type:TWMessageBarMessageTypeSuccess statusBarStyle:UIStatusBarStyleLightContent callback:NULL];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[SigninHandler sharedInstance] setupHomeViewController];
                });
            } else {
                [SVProgressHUD dismiss];
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"ERROR" description:[NSString stringWithFormat:@"%@", state] type:TWMessageBarMessageTypeError statusBarStyle:UIStatusBarStyleLightContent callback:NULL];
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
