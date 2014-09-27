//
//  GoodsApi.m
//  YiBeiYan
//
//  Created by next on 14-9-27.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "GoodsApi.h"
#import "YBYApi.h"

@implementation GoodsApi

+ (GoodsApi *) shareLoginApi {
    static GoodsApi *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [GoodsApi new];
    });
    return _shareClient;
}

+(void)typesWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"?m=goods&a=types" WithParameters:parameters withFinishBlock:block];
}

+(void)listsWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block{
    [YBYApi requestWithURL:@"?m=goods&a=lists" WithParameters:parameters withFinishBlock:block];
}
@end
