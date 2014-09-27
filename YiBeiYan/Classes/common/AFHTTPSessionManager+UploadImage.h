//
//  AFHTTPSessionManager+UploadImage.h
//  AibaIOS
//
//  Created by 88 on 13-12-4.
//  Copyright (c) 2013年 Yonglang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (UploadImage)


- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
        data:(NSData*)data
withFinishBlock:(void (^)(id JSON, NSError *error))block;


- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
      images:(NSArray*)images
withFinishBlock:(void (^)(id JSON, NSError *error))block;

@end
