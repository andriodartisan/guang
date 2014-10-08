//
//  PersonalDataController.m
//  35-setting
//
//  Created by yonglang on 14-5-5.
//  Copyright (c) 2014年 yonglang. All rights reserved.
//

#import "YBYImportFile.h"
#import "PersonalDataViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FaceCell.h"

@interface PersonalDataViewController ()

@property (nonatomic, strong) NSString *male;
@property (nonatomic, strong) NSString *female;
@property (nonatomic, strong) NSString *ok;
@property (nonatomic, strong) NSString *cancle;

@end

@implementation PersonalDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.bounds style:UITableViewStyleGrouped];
    
    self.tableView.sectionHeaderHeight = 15;
    self.tableView.sectionFooterHeight = 0;
    
    self.title = @"个人信息";
    
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _mutableArray = [NSMutableArray array];
    NSString *fileName = [NSString stringWithFormat:@"personalData"];
    _path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"];
    
    _documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, @"plist"]];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:_path];
    for (NSDictionary *dict in array) {
        [_mutableArray addObject:dict];
    }
    
    [self setTableViewProperty];
}

#pragma mark 设置TableView属性
- (void)setTableViewProperty {
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.bounds style:UITableViewStyleGrouped];
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    
    UIButton *logout = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logout setBackgroundColor:[UIColor redColor]];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = logout;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

- (void)logout {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"退出登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];

    sheet.tag = 3;
    [sheet showInView:self.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mutableArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _mutableArray[indexPath.section][indexPath.row];
    static NSString *CellIdentifier = @"PersonalDataCell";
    
    if (indexPath.section == 0) {
        FaceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"Face" owner:self options:nil];
            
            cell = [array objectAtIndex:0];
        }
        
        
        NSString *avatar = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERAVATAR];
        if (avatar == nil || [avatar isEqualToString:@""] ) {
            [cell.faceImageView setImage:[UIImage imageNamed:@"defaultavator"]];
        }else{
            _faceImageUrl = [NSURL URLWithString:[_userDefaults valueForKey:USER_DEFAULT_KEY_USERAVATAR]];
            [cell.faceImageView setImageWithURL:_faceImageUrl placeholderImage:[UIImage imageNamed:@"defaultavator"]];
        }
        
        
        cell.faceImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        cell.faceImageView.layer.masksToBounds = YES;
        cell.faceImageView.layer.cornerRadius = 28;
        cell.faceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.faceImageView.layer.borderWidth = 3.0f;
        cell.faceImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        cell.faceImageView.layer.shouldRasterize = YES;
        cell.faceImageView.clipsToBounds = YES;
        [cell setCellContent:dict[@"title"]];
        return cell;
    } else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        NSString *detailText = nil;
        if (indexPath.row == 0) {
            NSString *nickName = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERNAME];
            detailText = nickName;
        } else if (indexPath.row == 1) {
            NSString *sex = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERSEX];
            NSString *str = [NSString stringWithFormat:@"%d", [sex intValue]];
            detailText = ([str isEqualToString:@"1"]) ? @"男" : @"女";
        } else if (indexPath.row == 2) {
            NSString *alipay = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERALIPAY];
            detailText = alipay;
        }
        cell.detailTextLabel.text = detailText;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _dict = _mutableArray[indexPath.section][indexPath.row];
    if (_dict[@"controller"]) {
        Class c = NSClassFromString(_dict[@"controller"]);
        
        UIViewController *vc = [[c alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (_dict[@"style"]) {
        if ([_dict[@"style"] isEqualToString:@"sex"]) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:_dict[@"message"] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
            sheet.tag = 1;
            [sheet showInView:self.view];
        } else if ([_dict[@"style"] isEqualToString:@"image"]) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:_dict[@"message"] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", @"自己拍一张", nil];
            sheet.tag = 2;
            [sheet showInView:self.view];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *nickName = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERNAME];
            [self getAlert:_dict[@"message"] AndTag:1 AndPlaceHolder:nil AndText:nickName];
        } else {
            NSString *alipay = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERALIPAY];
            [self getAlert:_dict[@"message"] AndTag:2 AndPlaceHolder:nil AndText:alipay];
        }
    }
}

- (void)getAlert: (NSString *)message AndTag: (NSInteger)t AndPlaceHolder: (NSString *)placeHolder AndText: (NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.clearsContextBeforeDrawing = YES;
    alert.delegate = self;
    alert.tag = t;
    [[alert textFieldAtIndex:0] setClearButtonMode:UITextFieldViewModeWhileEditing];
    if (nil != placeHolder && 0 < placeHolder.length) {
        [[alert textFieldAtIndex:0] setPlaceholder:placeHolder];
    } else {
        [[alert textFieldAtIndex:0] setText:text];
    }
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _mutableArray.count - 1) {
        return 20;
    }
    return 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    
    long int row = alertView.tag;
    NSString *name = [alertView textFieldAtIndex:0].text;
    
    if (row == 1) {
        if (name != nil && name.length > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [self setUserNickName:name AndOtherField:nil AndOtherFieldValue:nil AndIndexPath:indexPath];
        }
        
    } else if (row == 2) {
        if (name != nil && name.length > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self setUserAlipay:name AndOtherField:nil AndOtherFieldValue:nil AndIndexPath:indexPath];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        NSString *username = [_userDefaults valueForKey:USER_DEFAULT_KEY_USERNAME];
        if (buttonIndex == 0) {
            [self setUserNickName:username AndOtherField:@"sex" AndOtherFieldValue:@"1" AndIndexPath:indexPath];
        } else if (buttonIndex == 1) {
            [self setUserNickName:username AndOtherField:@"sex" AndOtherFieldValue:@"0" AndIndexPath:indexPath];
        }
    } else if (actionSheet.tag == 2) {
        if (buttonIndex == 0) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        } else if (buttonIndex == 1) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"NotCamera" delegate:self cancelButtonTitle:_ok otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setAllowsEditing:YES];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
        }
    } else if(actionSheet.tag == 3){
        if (buttonIndex == 0) {
            [_userDefaults removeObjectForKey:USER_DEFAULT_KEY_ACCESSTOKEN];
            [_userDefaults removeObjectForKey:USER_DEFAULT_KEY_USERID];
            [_userDefaults removeObjectForKey:USER_DEFAULT_KEY_USERNAME];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image =  [info objectForKey:UIImagePickerControllerEditedImage];
    self.imageData = UIImageJPEGRepresentation(image,0.00001);
    [self.delegate setFaceImage:[UIImage imageWithData:self.imageData]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self setUserAvatar: indexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 设置用户头像
-(void)setUserAvatar: (NSIndexPath *)indexPath {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_USERID] forKey:@"userid"];
    [parameters setValue:[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_ACCESSTOKEN] forKey:@"accesstoken"];
    

    
//    [LoginApi uploadAvatarWithParameters:parameters image:[UIImage imageWithData:self.imageData] imageName:@"picture" withFinishBlock:^(id JSON, NSError *error) {
//        if (!error) {
//            NSString *code = [JSON valueForKeyPath:@"code"];
//            NSLog(@"avaterCode ==== %@", code);
//            if ([code isEqualToString:@"0"]) {
//                [[NSUserDefaults standardUserDefaults] setValue:[JSON valueForKeyPath:@"avatar"] forKey:USER_DEFAULT_KEY_USERAVATAR];
//                
//                _faceImageUrl = [NSURL URLWithString:[JSON valueForKeyPath:@"avatar"]];
//                [self updateNotification];
//                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//                NSLog(@"set avatar success");
//            }else{
//                NSLog(@" failed ....");
//            }
//        }else{
//            NSLog(@" error ....");
//        }
//
//    }];
    
    
}

#pragma mark 设置请求参数
- (NSMutableDictionary *)setParameter: (NSString *)username AndOtherField: (NSString *)otherField AndOtherFieldValue: (NSString *)otherFieldValue {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:username forKeyPath:USER_DEFAULT_KEY_USERNAME];
    if (otherField) {
        [parameters setValue:otherFieldValue forKey:otherField];
    }
    [parameters setValue:[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_USERID] forKey:@"userid"];
    [parameters setValue:[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_ACCESSTOKEN] forKey:@"accesstoken"];
    return parameters;
}

#pragma mark 设置用户昵称
-(void)setUserNickName: (NSString *)username AndOtherField: (NSString *)field AndOtherFieldValue: (NSString *)otherFieldValue AndIndexPath: (NSIndexPath *)indexPath {
    
    NSString *oldFieldValue=otherFieldValue;
    if(otherFieldValue==nil || otherFieldValue.length <= 0){
        otherFieldValue=@"!!!";
    }
    NSMutableDictionary *parameters = [self setParameter:username AndOtherField:field AndOtherFieldValue:otherFieldValue];

//    [LoginApi completeUserInfoWithParameters:parameters withFinishBlock:^(id JSON, NSError *error) {
//        if (!error) {
//            NSString *code = [JSON valueForKeyPath:@"code"];
//            if ([code isEqualToString:@"0"]) {
//                [_userDefaults setValue:username forKey:USER_DEFAULT_KEY_USERNAME];
//                
//                if (field) {
//                    [_userDefaults setValue:oldFieldValue forKeyPath:field];
//                }
//                [self updateNotification];
//                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//            }else{
//                NSLog(@" failed ....");
//            }
//        }else{
//            NSLog(@" error ....");
//        }
//    }];
}

#pragma mark 绑定支付宝账号
-(void)setUserAlipay: (NSString *)username AndOtherField: (NSString *)field AndOtherFieldValue: (NSString *)otherFieldValue AndIndexPath: (NSIndexPath *)indexPath {
    
    NSString *oldFieldValue=otherFieldValue;
    if(otherFieldValue==nil || otherFieldValue.length <= 0){
        otherFieldValue=@"!!!";
    }
    NSMutableDictionary *parameters = [self setParameter:username AndOtherField:field AndOtherFieldValue:otherFieldValue];
    
    //    [LoginApi completeUserInfoWithParameters:parameters withFinishBlock:^(id JSON, NSError *error) {
    //        if (!error) {
    //            NSString *code = [JSON valueForKeyPath:@"code"];
    //            if ([code isEqualToString:@"0"]) {
    //                [_userDefaults setValue:username forKey:USER_DEFAULT_KEY_USERNAME];
    //
    //                if (field) {
    //                    [_userDefaults setValue:oldFieldValue forKeyPath:field];
    //                }
    //                [self updateNotification];
    //                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    //            }else{
    //                NSLog(@" failed ....");
    //            }
    //        }else{
    //            NSLog(@" error ....");
    //        }
    //    }];
}


#pragma mark 修改用户信息通知消息
- (void)updateNotification {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateUserData" object:nil userInfo:nil];
}

-(void) viewDidAppear:(BOOL)animated {
//    [[BaiduMobStat defaultStat] pageviewStartWithName:NSStringFromClass([self class])];
    
}

-(void) viewDidDisappear:(BOOL)animated {
//    [[BaiduMobStat defaultStat] pageviewEndWithName:NSStringFromClass([self class])];
}

@end
