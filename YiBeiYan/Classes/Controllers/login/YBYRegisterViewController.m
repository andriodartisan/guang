//
//  YBYRegisterViewController.m
//  YiBeiYan
//
//  Created by next on 14-9-26.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "YBYRegisterViewController.h"
#import "YBYImportFile.h"
#import "LoginApi.h"

@interface YBYRegisterViewController ()
@property(nonatomic) CGRect vFrame;
@property(strong,nonatomic) UITextField *email;
@property(strong,nonatomic) UITextField *passwd;
@property(strong,nonatomic) UITextField *passwdAgain;
@property(strong,nonatomic) UIView *mainView;
@end

@implementation YBYRegisterViewController

@synthesize vFrame = _vFrame;
@synthesize email = _email;
@synthesize passwd =_passwd;
@synthesize passwdAgain = _passwdAgain;
@synthesize mainView = _mainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"注册"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addNavBar];
    [self addInput];
}

#pragma mark addNavBar
-(void) addNavBar
{
    //右侧完成
    UIBarButtonItem *navBarFinish = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(btnClick)];
    navBarFinish.tag = 102;
    self.navigationItem.rightBarButtonItem = navBarFinish;
}

-(void)btnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark addView
//创建输入框
- (void)addInput
{
    //基本参数定义
    CGFloat padx   = 80.0f;
    _vFrame        = CGRectMake(10, 14, 300, 120);
    UIFont *lpFont = [UIFont boldSystemFontOfSize:16];
    
    //邮箱和密码背景颜色设置
    _mainView = [[UIView alloc] initWithFrame:_vFrame];
    _mainView.layer.cornerRadius = 8.0;
    _mainView.layer.borderWidth = 1;
    _mainView.layer.borderColor = [UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f].CGColor;
    [_mainView setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f]];
    [self.view addSubview:_mainView];
    
    //邮箱与密码中间分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 300, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f]];
    [self.view addSubview:line];
    
    //密码与确认密码中间分割线
    UIView *ppline = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 300, 1)];
    [ppline setBackgroundColor:[UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f]];
    [self.view addSubview:ppline];
    
    //用户名或Email
    UIImageView * _eview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [_eview setUserInteractionEnabled:YES];
    [_mainView addSubview:_eview];
    
    UILabel *_unameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 55, 40)];
    [_unameLab setText:@"用户名"];
    _unameLab.highlighted = YES;
    _unameLab.highlightedTextColor = [UIColor blackColor];
    [_unameLab setFont:lpFont];
    [_unameLab setBackgroundColor:[UIColor clearColor]];
    [_unameLab setTextColor:[UIColor blackColor]];
    [_mainView addSubview:_unameLab];
    
    //用户邮箱
    _email = [[UITextField alloc] initWithFrame:CGRectMake(padx, 5, 200, 40)];
    [_email setBackgroundColor:[UIColor clearColor]];
    [_email setKeyboardType:UIKeyboardTypeEmailAddress];
    [_email setTextColor:[UIColor grayColor]];
    //[_email setClearButtonMode:UITextFieldViewModeWhileEditing];  //编辑时会出现个修改X
    [_email setTag:101];
    [_email setReturnKeyType:UIReturnKeyNext];  //键盘下一步Next
    [_email setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    [_email setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_email becomeFirstResponder]; //默认打开键盘
    [_email setFont:[UIFont systemFontOfSize:17]];
    //    [_email setDelegate:self];
    [_email setPlaceholder:@"用户名或电子邮箱"];
    [_email setText:@""];
    [_email setHighlighted:YES];
    [_eview addSubview:_email];
    
    //密码
    UILabel *_passwdLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 43, 45, 40)];
    [_passwdLab setText:@"密  码"];
    [_passwdLab setFont:lpFont];
    _passwdLab.highlighted = YES;
    _passwdLab.highlightedTextColor = [UIColor blackColor];
    [_passwdLab setBackgroundColor:[UIColor clearColor]];
    [_passwdLab setTextColor:[UIColor blackColor]];
    [_mainView addSubview:_passwdLab];
    
    _passwd = [[UITextField  alloc] initWithFrame:CGRectMake(padx, 43, 200, 40)];
    [_passwd setBackgroundColor:[UIColor clearColor]];
    [_passwd setKeyboardType:UIKeyboardTypeDefault];
    [_passwd setBorderStyle:UITextBorderStyleNone];
    [_passwd setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    [_passwd setReturnKeyType:UIReturnKeyDone]; //完成
    [_passwd setSecureTextEntry:YES]; //验证
    //    [_passwd setDelegate:self];
    [_passwd setTag:102];
    [_passwd setTextColor:[UIColor grayColor]];
    [_passwd setFont:lpFont];
    [_passwd setPlaceholder:@"密码"];
    [_passwd setText:@""];
    [_mainView addSubview:_passwd];
    
    //确认密码
    UILabel *_passwdAgainLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 83, 45, 40)];
    [_passwdAgainLab setText:@"密  码"];
    [_passwdAgainLab setFont:lpFont];
    _passwdAgainLab.highlighted = YES;
    _passwdAgainLab.highlightedTextColor = [UIColor blackColor];
    [_passwdAgainLab setBackgroundColor:[UIColor clearColor]];
    [_passwdAgainLab setTextColor:[UIColor blackColor]];
    [_mainView addSubview:_passwdAgainLab];
    
    _passwdAgain = [[UITextField  alloc] initWithFrame:CGRectMake(padx, 83, 200, 40)];
    [_passwdAgain setBackgroundColor:[UIColor clearColor]];
    [_passwdAgain setKeyboardType:UIKeyboardTypeDefault];
    [_passwdAgain setBorderStyle:UITextBorderStyleNone];
    [_passwdAgain setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    [_passwdAgain setReturnKeyType:UIReturnKeyDone]; //完成
    [_passwdAgain setSecureTextEntry:YES]; //验证
    //    [_passwd setDelegate:self];
    [_passwdAgain setTag:102];
    [_passwdAgain setTextColor:[UIColor grayColor]];
    [_passwdAgain setFont:lpFont];
    [_passwdAgain setPlaceholder:@"确认密码"];
    [_passwdAgain setText:@""];
    [_mainView addSubview:_passwdAgain];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirm.frame = CGRectMake(10, 150, 300, 40);
    confirm.userInteractionEnabled = YES;
    confirm.layer.cornerRadius = 8.0;
    confirm.tintColor = [UIColor whiteColor];
    [confirm setBackgroundColor:COLOR_LIGHT_RED];
    [confirm setTitle:@"注   册" forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [confirm addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
}

-(void)register{
    NSString *email = _email.text != nil ? _email.text : [NSString stringWithFormat:@""];
    NSString *password = _passwd.text != nil ? _passwd.text : [NSString stringWithFormat:@""];
    NSString *passwordAgain = _passwdAgain.text != nil ? _passwdAgain.text : [NSString stringWithFormat:@""];
    if (email.length > 0 && password.length > 0 && passwordAgain.length > 0) {
        if([password isEqualToString:passwordAgain]){
            NSString *devicetoken = @"506269fd32407631daabab6518ddcb1d6a7d2b6717a55c632596634308fa3529";
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            [parameters setValue:email forKey:@"email"];
            [parameters setValue:password forKey:@"password"];
            [parameters setValue:@"iphone" forKey:@"devicetype"];
            [parameters setValue:devicetoken forKey:@"devicetoken"];
            
            [LoginApi registerWithParameters:parameters withFinishBlock:^(id JSON, NSError *error) {
                if (!error) {
                    NSString *code = [NSString stringWithFormat:@"%@",[JSON valueForKey:@"code"]];
                    if ([code isEqualToString:@"0"]) {
                        NSDictionary *user = [JSON valueForKeyPath:@"user"];
                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"userid"] forKey:USER_DEFAULT_KEY_USERID];
                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"username"] forKey:USER_DEFAULT_KEY_USERNAME];
//                        [[NSUserDefaults standardUserDefaults] setValue:userphone forKey:USER_DEFAULT_KEY_USERPHONE];
//                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"avatar"] forKey:USER_DEFAULT_KEY_USERAVATAR];
//                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"background"] forKey:USER_DEFAULT_KEY_USERBACKGROUND];
//                        [[NSUserDefaults standardUserDefaults] setValue:[JSON valueForKey:@"accesstoken"] forKey:USER_DEFAULT_KEY_ACCESSTOKEN];
//                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"sex"] forKey:USER_DEFAULT_KEY_USERSEX];
//                        [[NSUserDefaults standardUserDefaults] setValue:[[user valueForKey:@"location"] description] forKey:USER_DEFAULT_KEY_USERLOCNAMES];
//                        [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"position"] forKey:USER_DEFAULT_KEY_USERPOSITION];
                    }else{
                        [[MBProgressShow shareInstance] showHUDModeText:[JSON valueForKey:@"msg"]];
                    }
                }else{
                    [[MBProgressShow shareInstance] showHUDModeText:@"网络异常"];
                }
            }];
        }else{
            [[MBProgressShow shareInstance] showHUDModeText:@"两次密码输入不同"];
        }
    }else{
        [[MBProgressShow shareInstance] showHUDModeText:@"邮箱和密码不能为空"];
    }
    
}

@end
