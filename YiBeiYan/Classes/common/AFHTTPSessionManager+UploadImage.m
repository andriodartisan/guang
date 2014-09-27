//
//  AFHTTPSessionManager+UploadImage.m
//  AibaIOS
//
//  Created by 88 on 13-12-4.
//  Copyright (c) 2013年 Yonglang. All rights reserved.
//

#import "AFHTTPSessionManager+UploadImage.h"
#import "AFNetworking.h"
#import "YBYImportFile.h"

#define i8API_DEBUG         1
#define BS_I8API_STAT_FLAG  1

@implementation AFHTTPSessionManager (UploadImage)


- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
        data:(NSData*)data
withFinishBlock:(void (^)(id JSON, NSError *error))block
{
    
#if i8API_DEBUG
    NSLog(@"--------------------------------------------");
    NSLog(@"URL: %@",URLString);
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"\tparam:%@,value:%@",key,obj);
    }];
    NSLog(@"--------------------------------------------");
#endif
    
#if BS_I8API_STAT_FLAG
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
#endif
    NSString *urlString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"picture" fileName:@"photo" mimeType:@"image/png"];
    }];
    [request setTimeoutInterval:30];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        HideNetworkActivityIndicator();
        NSData *responseData = operation.responseData;
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        if (block) {
            block(jsonObj, nil);
        }
#if BS_I8API_STAT_FLAG
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval duration = end - start;
        NSLog(@"[API COST]: %@, %f",URLString,round(duration*1000));
#endif
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HideNetworkActivityIndicator();
        if (block) {
            block(nil, error);
        }
#if BS_I8API_STAT_FLAG
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval duration = end - start;
        NSLog(@"[API COST]: %@, %f",URLString,round(duration*1000));
#endif
    }];
    
    [operation start];
    ShowNetworkActivityIndicator();
}


- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
      images:(NSArray*)images
withFinishBlock:(void (^)(id JSON, NSError *error))block {
    
#if i8API_DEBUG
    NSLog(@"--------------------------------------------");
    NSLog(@"URL: %@",URLString);
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"\tparam:%@,value:%@",key,obj);
    }];
    NSLog(@"--------------------------------------------");
#endif
    
#if BS_I8API_STAT_FLAG
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
#endif
    NSString *urlString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        for (int i = 0 ; i < images.count ; i++) {
            NSData *data = UIImageJPEGRepresentation([images objectAtIndex:i],1);
             [formData appendPartWithFileData:data name:@"picture" fileName:[NSString stringWithFormat:@"photo%d",i] mimeType:@"image/png"];
        }
    }];
    [request setTimeoutInterval:30];
    NSLog(@"%@",request.URL);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        if (block) {
            block(jsonObj, nil);
        }
#if BS_I8API_STAT_FLAG
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval duration = end - start;
        NSLog(@"[API COST]: %@, %f",URLString,round(duration * 1000));
#endif
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
#if BS_I8API_STAT_FLAG
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval duration = end - start;
        NSLog(@"[API COST]: %@, %f",URLString,round( duration * 1000 ));
#endif
    }];
    
    [operation start];
}

- (NSOperation *)uploadImage:(NSString *)URLString
  parameters:(NSDictionary *)parameters
      images:(NSArray*)images
withFinishBlock:(void (^)(id JSON, NSError *error))block {
    
    NSString *urlString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        for (int i = 0 ; i < images.count ; i++) {
            NSData *data = UIImageJPEGRepresentation([images objectAtIndex:i],1);
            [formData appendPartWithFileData:data name:@"picture" fileName:[NSString stringWithFormat:@"photo%d",i] mimeType:@"image/png"];
        }
    }];
    [request setTimeoutInterval:30];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
        if (block) {
            block(jsonObj, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
    
    [operation start];
    
    return operation;
}



@end
