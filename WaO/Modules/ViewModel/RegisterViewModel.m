//
//  SQRegisterViewModel.m
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/12.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "RegisterViewModel.h"
#import "PFUser+RACExtensions.h"
#import "NSString+EmailAdditions.h"

@interface RegisterViewModel ()

@property (nonatomic, strong) RACSignal *usernameSignal;
@property (nonatomic, strong) RACSignal *emailValidSignal;
@property (nonatomic, strong) RACSignal *passwordValidSignal;

@end

@implementation RegisterViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self mapRegisterCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapRegisterCommandStateToStatusMessage {
    RACSignal *startedMessage = [self.registerCommand.executionSignals map:^id(id value) {
        return NSLocalizedString(@"START", nil);
    }];
    
    RACSignal *completedMessage = [self.registerCommand.executionSignals flattenMap:^RACStream *(RACSignal *signal) {
        
       return [signal map:^id(PFUser *user) {
           [UserInfoHandler sharedInstance].userInfo = user;
           return NSLocalizedString(@"COMPLETED", nil);
       }];
    }];
    
    RACSignal *faildMessage = [[self.registerCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        NSLog(@"%@", error);
        
        return NSLocalizedString(error.localizedDescription, nil);
    }];
    
    RAC(self, signinState) = [RACSignal merge:@[startedMessage, completedMessage, faildMessage]];
    
}

- (RACCommand *)registerCommand {
    if (!_registerCommand) {
        _registerCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.emailValidSignal, self.passwordValidSignal, self.usernameSignal] reduce:^id(NSNumber *emailValid, NSNumber *passwordValid, NSNumber *usernameValid){
            return @([emailValid boolValue] && [passwordValid boolValue] && [usernameValid boolValue]);
        }] signalBlock:^RACSignal *(id input) {
            PFUser *user = [PFUser user];
            user.username = self.username;
            user.password = self.password;
            user.email = self.email;
            user[ParseUserName] = self.username;
            user[ParseUserPassword] = self.password;
            user[ParseUserEmail] = self.email;
            return [user rac_signUp];
        }];
    }
    return _registerCommand;
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

- (RACSignal *)usernameSignal {
    if (!_usernameSignal) {
        _usernameSignal = [RACObserve(self, username) map:^id(id value) {
            return @([self.username length] > 0);
        }];
    }
    return _usernameSignal;
}


@end
