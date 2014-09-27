//
//  I8Api.h
//  aiba
//
//  Created by Rusher on 14/9/4.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager+UploadImage.h"

@interface YBYApi :AFHTTPSessionManager

+ (YBYApi *) shareYBYApi;

+ (void)requestWithURL:(NSString*)url
        WithParameters:(NSDictionary*)parameters
       withFinishBlock:(void (^)(id JSON, NSError *error))block ;

+ (void)postWithURL:(NSString*)url
     WithParameters:(NSDictionary*)parameters
    withFinishBlock:(void (^)(id JSON, NSError *error))block;


+ (void)uploadImageToPath:(NSString*)path
           WithParameters:(NSDictionary*)parameters
                withImage:(UIImage*) image
            withImageName:(NSString*) filename
          withFinishBlock:(void (^)(id JSON, NSError *error))block;



+ (void)uploadFileToPath:(NSString*)path
          WithParameters:(NSDictionary*) parameters
                withData:(NSData*) filedata
            withFilename:(NSString*) filename
           withFileLabel:(NSString*) label
            withMineType:(NSString*) mimeType
       withProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)) progressBlock
         withFinishBlock:(void (^)(id JSON, NSError *error))block;

@end
