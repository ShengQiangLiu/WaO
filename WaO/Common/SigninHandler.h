//
//  SiginHandler.h
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/12.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SigninHandler : NSObject

+ (instancetype)sharedInstance;
- (void)setupLoginViewController;
- (void)setupHomeViewController;

@end
