


//
//  MBProgressShow.m
//  AibaIOS
//
//  Created by 88 on 13-11-11.
//  Copyright (c) 2013年 Yonglang. All rights reserved.
//

#import "MBProgressShow.h"
#import "RDVAppDelegate.h"

static MBProgressShow *sigleton = nil;
@implementation MBProgressShow

+ (MBProgressShow *) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        sigleton = [[MBProgressShow alloc] init];
    });
    return sigleton;
}


- (id)init {
    self = [super init];
    if (self !=nil) {
        self.flag = NO;
        self.showHud = [MBProgressHUD showHUDAddedTo:[RDVAppDelegate appDelegate].window animated:YES];
        self.showHud.hidden = YES;
    }
    return self;
}

- (void)reSetShowHud {
    [self.showHud removeFromSuperview];
     self.showHud = [MBProgressHUD showHUDAddedTo:[RDVAppDelegate appDelegate].window animated:YES];
     self.showHud.hidden = YES;
    self.flag = NO;
}

-(void)showHUDModeText:(NSString*) showText{
    [self.showHud setHidden:NO];
    [self.showHud show:YES];
    self.showHud.mode = MBProgressHUDModeText;
    self.showHud.labelText = showText;
    [self.showHud hide:YES afterDelay:1.5];
}

@end
