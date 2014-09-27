//
//  I8Api.m
//  aiba
//
//  Created by Rusher on 14/9/4.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import "YBYApi.h"
#import "YBYImportFile.h"
#import "UIImage+Resize.h"
#import <CommonCrypto/CommonDigest.h>

#define I8Api_DEBUG     1

@implementation YBYApi


+ (YBYApi *) shareYBYApi {
    static YBYApi *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[YBYApi alloc] initWithBaseURL:[NSURL URLWithString:YBY_API_URL]];
    });
    return _shareClient;
}

- (id) initWithBaseURL:(NSURL *)URL
{
    self = [super initWithBaseURL:URL];
    if (!self) {
        return nil;
    }
    return self;
}

+ (void)requestWithURL:(NSString*)url
        WithParameters:(NSDictionary*)parameters
       withFinishBlock:(void (^)(id JSON, NSError *error))block {
    NSMutableDictionary *para = [self getHashParameters:parameters];
    ShowNetworkActivityIndicator();
    
#if I8Api_DEBUG
    NSLog(@"--------------------------------------------");
    NSLog(@"URL: %@",url);
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"\tparam:%@,value:%@",key,obj);
    }];
    NSLog(@"--------------------------------------------");
#endif
    
    [[YBYApi shareYBYApi] GET:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject, nil);
        HideNetworkActivityIndicator();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        HideNetworkActivityIndicator();
        if (block) {
            block(nil, error);
        }
    }];
}

+ (void)postWithURL:(NSString*)url
        WithParameters:(NSDictionary*)parameters
       withFinishBlock:(void (^)(id JSON, NSError *error))block {
    NSMutableDictionary *para = [self getHashParameters:parameters];
    ShowNetworkActivityIndicator();
    
#if I8Api_DEBUG
    NSLog(@"--------------------------------------------");
    NSLog(@"URL: %@",url);
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"\tparam:%@,value:%@",key,obj);
    }];
    NSLog(@"--------------------------------------------");
#endif
    
    [[YBYApi shareYBYApi] POST:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject, nil);
        HideNetworkActivityIndicator();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        HideNetworkActivityIndicator();
        if (block) {
            block(nil, error);
        }
    }];
}

+(NSDictionary *)getHashParameters:(NSDictionary *)parameters{
    NSArray *allkeys = [parameters allKeys];
    NSArray *sortedArray = [allkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *hash = [NSString stringWithFormat:@""];
    for (NSString *key in sortedArray) {
        hash = [hash stringByAppendingString:[parameters valueForKey:key]];
    }
    hash = [hash stringByAppendingString:YBY_HASH_KEY_VALUE];
    hash = [self md5:hash];
    
    NSMutableDictionary *newparameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [newparameters setValue:hash forKey:@"hash"];
    return newparameters;
}

+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (void)uploadImageToPath:(NSString*)path
           WithParameters:(NSDictionary*)parameters
                withImage:(UIImage*) image
            withImageName:(NSString*) filename
          withFinishBlock:(void (^)(id JSON, NSError *error))block {
    
    
    [self uploadFileToPath:path WithParameters:parameters
                  withData:[image compressedData]
              withFilename:filename
             withFileLabel:@"picture"
              withMineType:@"image/png"
         withProgressBlock:nil
           withFinishBlock:block];
    
}

+ (void)uploadFileToPath:(NSString*)path
          WithParameters:(NSDictionary*) parameters
                withData:(NSData*) filedata
            withFilename:(NSString*) filename
           withFileLabel:(NSString*) label
            withMineType:(NSString*) mimeType
       withProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)) progressBlock
         withFinishBlock:(void (^)(id JSON, NSError *error))block {
    
    [[YBYApi shareYBYApi] POST:path parameters:parameters data:filedata withFinishBlock:block];
}


@end
