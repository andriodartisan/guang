//
//  YBYOrderTableViewCell.h
//  YiBeiYan
//
//  Created by next on 14-10-8.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"


@interface YBYOrderTableViewCell : UITableViewCell
@property(strong,nonatomic) UIView *view;

@property(strong,nonatomic) UILabel *topOrderNumber;
@property(strong,nonatomic) UILabel *topOrderTime;

@property(strong,nonatomic) UIImageView *goodsImageView;

@property(strong,nonatomic) UIView *rightView;
@property(strong,nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) UILabel *confirmOrderTimeLabel;
@property(strong,nonatomic) UILabel *rebateTimeLabel;

@property(strong,nonatomic) UILabel *bottomOrderRebate;
@end
