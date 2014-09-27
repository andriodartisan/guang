//
//  GoodsApi.h
//  YiBeiYan
//
//  Created by next on 14-9-27.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsApi : NSObject

/**
 *  商品分类
 *
 *  @param parameters <#parameters description#>
 *  @param block      <#block description#>
 */
+(void)typesWithParameters:(NSDictionary*)parameters
           withFinishBlock:(void (^)(id JSON, NSError *error))block;

/**
 *  商品列表
 *
 *  @param parameters <#parameters description#>
 *  @param block      <#block description#>
 */
+(void)listsWithParameters:(NSDictionary*)parameters
              withFinishBlock:(void (^)(id JSON, NSError *error))block;

@end
