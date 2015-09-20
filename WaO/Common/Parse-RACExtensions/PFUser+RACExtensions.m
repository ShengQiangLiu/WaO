//
//  PFUser+RACExtensions.m
//  ReactiveCocoaDemo
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "PFUser+RACExtensions.h"
#import "PFRACErrors.h"
#import "PFRACCallbacks.h"

@implementation PFUser (RACExtensions)
+ (RACSignal *)rac_logInWithUsername:(NSString *)username withPassword:(NSString *)password {
        return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self logInWithUsernameInBackground:username password:password block:PFRACObjectCallback(subscriber)];
            return nil;
        }] pfrac_useDefaultErrorDescription:@"log in failed"] setNameWithFormat:@"PFUser +rac_logInWithUsername: %@ password: %@", username, password];
}

- (RACSignal *)rac_signUp {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self signUpInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];
        return nil;
    }] pfrac_useDefaultErrorDescription:NSLocalizedString(@"sign up failed", nil)] setNameWithFormat:@"%@ -rac_signUp", self];
}


@end
