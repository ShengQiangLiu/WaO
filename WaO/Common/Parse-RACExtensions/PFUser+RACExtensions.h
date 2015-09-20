//
//  PFUser+RACExtensions.h
//  ReactiveCocoaDemo
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "PFUser.h"

@interface PFUser (RACExtensions)
+ (RACSignal *)rac_logInWithUsername:(NSString *)username withPassword:(NSString *)password;
- (RACSignal *)rac_signUp;
@end
