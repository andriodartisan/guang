//
//  YBYOrderTableViewCell.m
//  YiBeiYan
//
//  Created by next on 14-10-8.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "YBYOrderTableViewCell.h"

@implementation YBYOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float horizontalInterval = 5;
        float verticalInterval = 5;
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        _view = [[UIView alloc] initWithFrame:CGRectMake(horizontalInterval, 0, frame.size.width - horizontalInterval*2, 170)];
        
        _topOrderNumber = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 160, 30)];
        _topOrderNumber.font = [UIFont systemFontOfSize:12.0];
        _topOrderNumber.textAlignment = UIControlContentVerticalAlignmentCenter;
        _topOrderNumber.textAlignment = UITextAlignmentLeft;
        _topOrderNumber.text = @"订单号：542206485935638";
        
        _topOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 135, 30)];
        _topOrderTime.font = [UIFont systemFontOfSize:12.0];
        _topOrderTime.textAlignment = UIControlContentVerticalAlignmentCenter;
        _topOrderTime.textAlignment = UITextAlignmentRight;
        _topOrderTime.text = @"下单日期：2014-02-20";
        
        UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(5, 30, frame.size.width - horizontalInterval*2-10, 1)];
        toplineView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:231.0f/255.0f blue:228.0f/255.0f alpha:1];
        
        
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 35, 100, 100)];
        [_goodsImageView setImage:[UIImage imageNamed:@"recommend_demo_pic.jpg"]];
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(110, 35, frame.size.width - horizontalInterval*2 - 110, 100)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - horizontalInterval*2 - 110 - 5, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        _titleLabel.textAlignment = UITextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;

        
        //        //文字居中显示
        //        label.textAlignment = UIControlContentVerticalAlignmentTop;
        //        label.textAlignment = UIControlContentHorizontalAlignmentCenter;
        //        //自动折行设置
        //        label.lineBreakMode = NSLineBreakByWordWrapping;
        //
        //        label.numberOfLines = 0;
        
        _titleLabel.text = @"2014新款真丝连衣裙韩版女雪纺衫长款裙夏季修身显瘦气质大码女装";
        
        float thirdWidth = frame.size.width - horizontalInterval*2 - 110 -5;
        
        _confirmOrderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, thirdWidth, 25)];
        _confirmOrderTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _confirmOrderTimeLabel.textAlignment = UITextAlignmentLeft;
        _confirmOrderTimeLabel.text = @"确认收货时间：2014-03-03";

        
        
        _rebateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, thirdWidth, 25)];
        _rebateTimeLabel.text = @"返利时间：2014-03-03";
        _rebateTimeLabel.textAlignment = UITextAlignmentLeft;
        _rebateTimeLabel.font = [UIFont systemFontOfSize:12.0];
        
        
        
        UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(5, 139, frame.size.width - horizontalInterval*2-10, 1)];
        bottomlineView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:231.0f/255.0f blue:228.0f/255.0f alpha:1];
        
        _bottomOrderRebate = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, frame.size.width - horizontalInterval*2-10, 30)];
        _bottomOrderRebate.font = [UIFont systemFontOfSize:14.0];
        _bottomOrderRebate.textAlignment = UIControlContentVerticalAlignmentCenter;
        _bottomOrderRebate.textAlignment = UITextAlignmentRight;
        _bottomOrderRebate.text = @"返利：￥39 x 4.26% = 166集分宝";

        
        [_rightView addSubview:_titleLabel];
        [_rightView addSubview:_confirmOrderTimeLabel];
        [_rightView addSubview:_rebateTimeLabel];
        
        [_view addSubview:_topOrderNumber];
        [_view addSubview:_topOrderTime];
        [_view addSubview:toplineView];
        [_view addSubview:_goodsImageView];
        [_view addSubview:_rightView];
        [_view addSubview:bottomlineView];
        [_view addSubview:_bottomOrderRebate];
        
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
