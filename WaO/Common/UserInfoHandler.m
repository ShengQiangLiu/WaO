//
//  UserInfoHandler.m
//  ReactiveCocoaDemo
//
//  Created by admin on 15/9/13.
//  Copyright (c) 2015年 ShengQiangLiu. All rights reserved.
//

#import "UserInfoHandler.h"




@implementation UserInfoHandler

+ (instancetype)sharedInstance {
    static UserInfoHandler *userInfoHandler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoHandler = [[[self class] alloc] init];
    });
    return userInfoHandler;
}

- (PFUser *)userInfo {
    return _userInfo?_userInfo:[PFUser currentUser];
}

- (BOOL)accountIsExist {
    return [PFUser currentUser]?YES:NO;
}

- (NSString *)email {
    return self.userInfo.email;
}

- (NSString *)password {
    return self.userInfo.password;
}

- (NSString *)nickname {
    return self.userInfo[ParseUserName];
}

- (PFFile *)picture {
    return self.userInfo[ParseUserPicture];
}

@end
