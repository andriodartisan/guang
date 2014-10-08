//
//  YBYGoldTableViewCell.m
//  YiBeiYan
//
//  Created by next on 14-10-8.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "YBYGoldTableViewCell.h"

@implementation YBYGoldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float horizontalInterval = 5;
        float verticalInterval = 5;
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        _view = [[UIView alloc] initWithFrame:CGRectMake(horizontalInterval, 0, frame.size.width - horizontalInterval*2, 71)];
        
        _topRebateTime = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 160, 30)];
        _topRebateTime.font = [UIFont systemFontOfSize:12.0];
        _topRebateTime.textAlignment = UIControlContentVerticalAlignmentCenter;
        _topRebateTime.textAlignment = UITextAlignmentLeft;
        _topRebateTime.text = @"2014-03-03 22:57:43";
        
        _topGoldNumber = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 135, 30)];
        _topGoldNumber.font = [UIFont systemFontOfSize:12.0];
        _topGoldNumber.textAlignment = UIControlContentVerticalAlignmentCenter;
        _topGoldNumber.textAlignment = UITextAlignmentRight;
        _topGoldNumber.text = @"100000";
        
        UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(5, 30, frame.size.width - horizontalInterval*2-10, 1)];
        toplineView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:231.0f/255.0f blue:228.0f/255.0f alpha:1];
        
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 31, frame.size.width - horizontalInterval*2, 40)];
        _detailLabel.font = [UIFont systemFontOfSize:14.0];
        _detailLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        _detailLabel.textAlignment = UITextAlignmentLeft;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;

        
        _detailLabel.text = @"购物返集分宝";
        
       
        
        [_view addSubview:_topRebateTime];
        [_view addSubview:_topGoldNumber];
        [_view addSubview:toplineView];
        [_view addSubview:_detailLabel];

        
        _view.backgroundColor = [UIColor colorWithRed:0.858824 green:0.843137 blue:0.823529 alpha:1];
        _view.layer.masksToBounds = YES;
        _view.layer.cornerRadius = 5.0;
        
        [self addSubview:_view];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
