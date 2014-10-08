//
//  RDVFourViewController.m
//  RDVTabBarController
//
//  Created by Sun on 14-8-13.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import "RDVFourViewController.h"
#import "RDVTabBarController.h"
#import "TestAnimationViewController.h"
#import "YBYLoginViewController.h"
#import "YBYImportFile.h"
#import "PersonalDataViewController.h"

@interface RDVFourViewController ()
@property(strong,nonatomic) NSMutableDictionary *dict;
@end

@implementation RDVFourViewController
@synthesize dict = _dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.bounds style:UITableViewStyleGrouped];
    self.tableView.sectionFooterHeight = 0;
    _myArr = [[NSMutableArray alloc] init];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"setting" ofType:@"plist"]];
    for (NSDictionary *dict in array) {
        [_myArr addObject:dict];
    }
//    _myArr = @[
//               @[@"我的订单",@"我的积分",@"我的邀请"],
//               @[@"查找订单",@"邀请好友"],
//               @[@"意见反馈"],
//               ];
    
    if (self.rdv_tabBarController.tabBar.translucent) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0,
                                               0,
                                               CGRectGetHeight(self.rdv_tabBarController.tabBar.frame),
                                               0);
        
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }
}

/**
 *  头部显示 ，隐藏多余的下划线
 *
 *  @param tableView <#tableView description#>
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *headerview = [[UIView alloc] init];
    headerview.frame = CGRectMake(0, 0, 320, 100);
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background1.png"]];
    [headerview setBackgroundColor:bgColor];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_ACCESSTOKEN];
    if (accessToken == nil) {
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 45, 120, 30)];
        [loginBtn setTitle:@"点此登陆" forState:UIControlStateNormal];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.borderWidth = 1.0;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255, 255, 255, 1 });
        [loginBtn.layer setBorderColor:colorref];//边框颜色
        
        loginBtn.tintColor = [UIColor redColor];
        [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [headerview addSubview:loginBtn];
        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    }else{
        UIImageView *avatarIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 60, 60)];
        avatarIV.image = [UIImage imageNamed:@"defaultavator"];
        avatarIV.layer.cornerRadius = 30.0;
        avatarIV.layer.borderColor = [UIColor whiteColor].CGColor;
        avatarIV.layer.borderWidth = 2.0f;
        avatarIV.clipsToBounds = YES;
        [headerview addSubview:avatarIV];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 20, 195, 30)];
        nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_USERNAME];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor whiteColor];
        [headerview addSubview:nameLabel];
    
        UILabel *goldLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, 195, 30)];
        goldLabel.text = [NSString stringWithFormat:@"%@   金币",[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_USERJINBI]];
        goldLabel.font = [UIFont systemFontOfSize:14];
        goldLabel.textColor = [UIColor whiteColor];
        [headerview addSubview:goldLabel];
    
        UIImageView *rightIV = [[UIImageView alloc] init];
        UIImage *rightI = [UIImage imageNamed:@"card_arrows"];
        rightIV.frame = CGRectMake(320 - 10 - 20, (100 - 20)/2, 20, 20);
        [rightIV setImage:rightI];
        [headerview addSubview:rightIV];
        
        headerview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profile)];
        [headerview addGestureRecognizer:tapGesture];
    
    }
    [tableView setTableHeaderView:headerview];
    
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:53.0f/255.0f blue:61.0f/255.0f alpha:1];
    [tableView setTableFooterView:view];
}

-(void)login{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    YBYLoginViewController *tav = [[YBYLoginViewController alloc] init];
    [self.navigationController pushViewController:tav animated:YES];
}

-(void)profile{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    PersonalDataViewController *pdc = [[PersonalDataViewController alloc] init];
    [self.navigationController pushViewController:pdc animated:YES];
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _dict = [_myArr objectAtIndex:indexPath.section][indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _dict[@"title"];
    [cell.imageView setImage:[UIImage imageNamed:@"bag10_travell"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _myArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_myArr objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([[_myArr objectAtIndex:section] count] > 0) {
        return 15;
    }else{
        return 0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _dict = [_myArr objectAtIndex:indexPath.section][indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULT_KEY_ACCESSTOKEN];
    if (accessToken == nil) {
        YBYLoginViewController *tav = [[YBYLoginViewController alloc] init];
        [self.navigationController pushViewController:tav animated:YES];
    } else {
        Class c = NSClassFromString(_dict[@"controller"]);
        UIViewController *vc = [[c alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setExtraCellLineHidden:self.tableView];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

@end
