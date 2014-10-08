//
//  FaceCell.h
//  aiba
//
//  Created by yonglang on 14-5-8.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalDataViewController.h"

@interface FaceCell : UITableViewCell<PersonalDataViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;

- (void)setCellContent: (NSString *)title;

@end
