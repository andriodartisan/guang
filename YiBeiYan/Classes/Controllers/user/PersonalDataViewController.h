//
//  PersonalDataController.h
//  35-setting
//
//  Created by yonglang on 14-5-5.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalDataViewControllerDelegate <NSObject>
@optional
- (void)setFaceImage: (UIImage *)image;

@end

@interface PersonalDataViewController : UITableViewController<UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    NSMutableArray *_mutableArray;
    NSMutableDictionary *_dict;
    NSString *_path;
    NSString *_documentPath;
    NSUserDefaults *_userDefaults;
}

@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) NSURL *faceImageUrl;
@property (strong, nonatomic) NSString *location;

@property (weak, nonatomic) id<PersonalDataViewControllerDelegate> delegate;

@end
