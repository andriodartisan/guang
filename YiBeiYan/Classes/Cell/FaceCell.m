//
//  FaceCell.m
//  aiba
//
//  Created by yonglang on 14-5-8.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import "FaceCell.h"
#import "UIImageView+AFNetworking.h"

@implementation FaceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setCellContent: (NSString *)title {
    self.title.text = title;
    self.title.font = [UIFont boldSystemFontOfSize:15];
}

- (void)setFaceImage: (UIImage *)image {
    NSLog(@"你进来了");
    [self.faceImageView setImage:image];
}

@end
