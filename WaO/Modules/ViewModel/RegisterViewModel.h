//
//  SQRegisterViewModel.h
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/12.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, SigninState) {
//    SigninStateStart,
//    SigninStateCompleted,
//    SigninStateError,
//};

@interface RegisterViewModel : NSObject

@property (nonatomic, strong) RACCommand *registerCommand;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *signinState;

@end
