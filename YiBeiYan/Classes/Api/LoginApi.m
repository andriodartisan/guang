//
//  loginApi.m
//  aiba
//
//  Created by wuguanpin on 14-5-4.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import "LoginApi.h"
#import "YBYApi.h"

#define LoginApi_DEBUG 1

@implementation LoginApi

+ (LoginApi *) shareLoginApi {
    static LoginApi *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [LoginApi new];
    });
    return _shareClient;
}

/**
 登陆
 */
+(void)loginWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi postWithURL:@"?m=user&a=login" WithParameters:parameters withFinishBlock:block];
}

/**
 获取验证码
 */
+(void)getVerificationCodeWithParameters:(NSDictionary*)parameters
                         withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi postWithURL:@"sendsms" WithParameters:parameters withFinishBlock:block];
}


/**
 注册
 */
+(void)registerWithParameters:(NSDictionary*)parameters
              withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"?m=user&a=register" WithParameters:parameters withFinishBlock:block];
}

/**
 完善个人信息
 */
+(void)completeUserInfoWithParameters:(NSDictionary*)parameters
                      withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"user/update" WithParameters:parameters withFinishBlock:block];
}

/**
 修改密码
 */
+(void)updatePasswordWithParameters:(NSDictionary*)parameters
                    withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"resetpassword" WithParameters:parameters withFinishBlock:block];
}

/**
 第三方登陆
 */
+(void)externalLoginWithParameters:(NSDictionary*)parameters
                   withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"externallogin" WithParameters:parameters withFinishBlock:block];
}

/**
 用户头像设置
 */
+(void)setAvatarWithParameters:(NSDictionary*)parameters
                     imageData:(NSData*) imageData
                    targetName:(NSString*) tgname
               withFinishBlock:(void (^)(id JSON, NSError *error))block{
//    [LoginApi responseWithURL:@"api/user/avatar/upload" WithParameters:parameters
//                    imageData:imageData
//                   targetName:tgname
//              withFinishBlock:block];
}

+(void)uploadAvatarWithParameters:(NSDictionary*)parameters
                     image:(UIImage*) image
                    imageName:(NSString*) imageName
               withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi uploadImageToPath:@"user/avatar/upload" WithParameters:parameters withImage:image withImageName:imageName withFinishBlock:block];
}

@end
