//
//  SQSigninViewModel.m
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/1.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "SigninViewModel.h"
#import "PFUser+RACExtensions.h"
#import "NSString+EmailAdditions.h"
//#import "SSKeychain+Login.h"
#import "UserInfoHandler.h"

@interface SigninViewModel ()
@property (nonatomic, strong) RACSignal *emailValidSignal;
@property (nonatomic, strong) RACSignal *passwordValidSignal;
@end

/*
 参考文章：http://www.tuicool.com/articles/nYJRvu
 */

@implementation SigninViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self mapLoginCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapLoginCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.loginCommand.executionSignals map:^id(RACSignal *value) {
//        NSLog(@"开始");
        return NSLocalizedString(@"START", nil);
    }];
//
    RACSignal *comloetedMessageSource = [self.loginCommand.executionSignals flattenMap:^RACStream *(RACSignal *signal) {
        
//       return [[[signal materialize] filter:^BOOL(RACEvent *event) {
//           return event.eventType == RACEventTypeCompleted;
//       }] map:^id(id value) {
//           return NSLocalizedString(@"COMPLETED", nil);
//       }];
        
        return [signal map:^id(PFUser *user) {
            NSLog(@"%@", user);
            [UserInfoHandler sharedInstance].userInfo = user;
            return NSLocalizedString(@"COMPLETED", nil);
        }];
    }];
    
    RACSignal *failedMessageSource = [[self.loginCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        NSLog(@"%@", error);
        return NSLocalizedString(error.localizedDescription, nil);
    }];
    
//    [self.loginCommand.executionSignals subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, comloetedMessageSource, failedMessageSource]];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.emailValidSignal, self.passwordValidSignal] reduce:^id(NSNumber *emailValid, NSNumber *passwordValid){
            return @([emailValid boolValue] && [passwordValid boolValue]);
        }] signalBlock:^RACSignal *(id input) {
            return [PFUser rac_logInWithUsername:self.email withPassword:self.password];
        }];
    }
    return _loginCommand;
}

- (RACSignal *)emailValidSignal {
    if (!_emailValidSignal) {
        _emailValidSignal = [RACObserve(self, email) map:^id(id value) {
            return @([self.email isValidEmail]);
        }];
    }
    return _emailValidSignal;
}

- (RACSignal *)passwordValidSignal {
    if (!_passwordValidSignal) {
        _passwordValidSignal = [RACObserve(self, password) map:^id(id value) {
            return @([self.password length] > 0);
        }];
    }
    return _passwordValidSignal;
}

@end
