//
//  YBYLoginViewController.m
//  YiBeiYan
//
//  Created by next on 14-9-26.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "YBYLoginViewController.h"
#import "YBYImportFile.h"
#import "YBYRegisterViewController.h"
#import "LoginApi.h"

@interface YBYLoginViewController ()
@property(nonatomic) CGRect vFrame;
@property(strong,nonatomic) UITextField *email;
@property(strong,nonatomic) UITextField *passwd;
@property(strong,nonatomic) UIView *mainView;
@end

@implementation YBYLoginViewController
@synthesize vFrame = _vFrame;
@synthesize email = _email;
@synthesize passwd =_passwd;
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
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"瑞贝账号登陆"];
    [self addNavBar];
    [self addInput];
}

#pragma mark addNavBar
-(void) addNavBar
{
    //返回按钮
//    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//    [btnLeft setBackgroundImage:[UIImage imageNamed:@"item_back.png"] forState:UIControlStateNormal];
//    [btnLeft setBackgroundImage:[UIImage imageNamed:@"item_back@2x.png"] forState:UIControlStateHighlighted];
//    [btnLeft setTag:101];
//    [btnLeft.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//    [btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *navBarBack = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
//    
//    [self.navigationItem setLeftBarButtonItem:navBarBack];
    
    //右侧完成
    UIBarButtonItem *navBarFinish = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(toRegister)];
    navBarFinish.tag = 102;
    self.navigationItem.rightBarButtonItem = navBarFinish;
}

#pragma mark addView
//创建输入框
- (void)addInput
{
    //基本参数定义
    CGFloat padx   = 80.0f;
    _vFrame        = CGRectMake(10, 14, 300, 80);
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
    [_passwd setText:@""];
    [_mainView addSubview:_passwd];
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirm.frame = CGRectMake(10, 110, 300, 40);
    confirm.userInteractionEnabled = YES;
    confirm.layer.cornerRadius = 8.0;
    confirm.tintColor = [UIColor whiteColor];
    [confirm setBackgroundColor:COLOR_LIGHT_RED];
    [confirm setTitle:@"登   陆" forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [confirm addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
}

-(void)login{
    NSString *email = _email.text != nil ? _email.text : [NSString stringWithFormat:@""];
    NSString *password = _passwd.text != nil ? _passwd.text : [NSString stringWithFormat:@""];
    if (email.length > 0 && password.length > 0) {
        NSString *devicetoken = @"506269fd32407631daabab6518ddcb1d6a7d2b6717a55c632596634308fa3529";
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:email forKey:@"username"];
        [parameters setValue:password forKey:@"password"];
        [parameters setValue:@"iphone" forKey:@"devicetype"];
        [parameters setValue:devicetoken forKey:@"devicetoken"];
        
        [LoginApi loginWithParameters:parameters withFinishBlock:^(id JSON, NSError *error) {
            if (!error) {
                NSString *code = [NSString stringWithFormat:@"%@",[JSON valueForKey:@"code"]];
                NSLog(@"login %@",JSON);
                if ([code isEqualToString:@"0"]) {
                    NSDictionary *user = [JSON valueForKeyPath:@"data"];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"uid"] forKey:USER_DEFAULT_KEY_USERID];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"username"] forKey:USER_DEFAULT_KEY_USERNAME];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"alipay"] forKey:USER_DEFAULT_KEY_USERALIPAY];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"avatar"] forKey:USER_DEFAULT_KEY_USERAVATAR];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"email"] forKey:USER_DEFAULT_KEY_USEREMAIL];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"income"] forKey:USER_DEFAULT_KEY_USERINCOME];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"jinbi"] forKey:USER_DEFAULT_KEY_USERJINBI];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"sex"] forKey:USER_DEFAULT_KEY_USERSEX];
                    [[NSUserDefaults standardUserDefaults] setValue:[user valueForKey:@"status"] forKey:USER_DEFAULT_KEY_USERSTATUS];
                    [[NSUserDefaults standardUserDefaults] setValue:[JSON valueForKey:@"accesstoken"] forKey:USER_DEFAULT_KEY_ACCESSTOKEN];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [[MBProgressShow shareInstance] showHUDModeText:[JSON valueForKey:@"msg"]];
                }
            }else{
                [[MBProgressShow shareInstance] showHUDModeText:@"网络异常"];
            }
        }];
    }else{
        [[MBProgressShow shareInstance] showHUDModeText:@"邮箱和密码不能为空"];
    }
    
}

-(void)toRegister{
    YBYRegisterViewController *registers = [[YBYRegisterViewController alloc] init];
    [self.navigationController pushViewController:registers animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
