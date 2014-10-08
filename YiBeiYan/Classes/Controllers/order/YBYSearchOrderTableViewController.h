//
//  YBYSearchOrderTableViewController.h
//  YiBeiYan
//
//  Created by next on 14-10-8.
//  Copyright (c) 2014年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBYSearchOrderTableViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end
