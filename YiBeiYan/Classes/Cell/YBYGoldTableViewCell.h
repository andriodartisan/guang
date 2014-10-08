//
//  YBYGoldTableViewCell.h
//  YiBeiYan
//
//  Created by next on 14-10-8.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBYGoldTableViewCell : UITableViewCell
@property(strong,nonatomic) UIView *view;

@property(strong,nonatomic) UILabel *topGoldNumber;
@property(strong,nonatomic) UILabel *topRebateTime;
@property(strong,nonatomic) UILabel *detailLabel;

@end
