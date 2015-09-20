//
//  SigninViewModel.h
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/1.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SigninViewModel : NSObject

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *statusMessage;

@end
