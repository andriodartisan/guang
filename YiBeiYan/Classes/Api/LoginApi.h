//
//  loginApi.h
//  aiba
//
//  Created by wuguanpin on 14-5-4.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginApi : NSObject

/**
  登陆
 */
+(void)loginWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 注册
 */
+(void)registerWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 完善个人信息
 */
+(void)completeUserInfoWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 修改密码
 */
+(void)updatePasswordWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 第三方登陆
 */
+(void)externalLoginWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 用户头像设置
 */
+(void)setAvatarWithParameters:(NSDictionary*)parameters
                     imageData:(NSData*) imageData
                    targetName:(NSString*) tgname
               withFinishBlock:(void (^)(id JSON, NSError *error))block;


+(void)uploadAvatarWithParameters:(NSDictionary*)parameters
                            image:(UIImage*) image
                        imageName:(NSString*) imageName
                  withFinishBlock:(void (^)(id JSON, NSError *error))block;


@end
