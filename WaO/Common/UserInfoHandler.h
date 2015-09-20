//
//  UserInfoHandler.h
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/13.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoHandler : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) PFUser *userInfo;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *nickname;
@property (nonatomic, strong, readonly) PFFile *picture;
- (BOOL)accountIsExist;

@end
