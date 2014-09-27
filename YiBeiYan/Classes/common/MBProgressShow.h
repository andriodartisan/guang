//
//  MBProgressShow.h
//  AibaIOS
//
//  Created by 88 on 13-11-11.
//  Copyright (c) 2013年 Yonglang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface MBProgressShow : NSObject

@property(nonatomic) BOOL flag;
@property (strong, nonatomic) MBProgressHUD * showHud;

+ (MBProgressShow *)shareInstance;
- (void)reSetShowHud;

/**
 *  文本提示
 *
 *  @param showText 提示信息
 */
-(void)showHUDModeText:(NSString*) showText;
@end
