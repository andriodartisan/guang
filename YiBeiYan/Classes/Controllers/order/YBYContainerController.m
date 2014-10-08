//
//  RNContainerController.m
//  TestingSearchBar
//
//  Created by Ryan Nystrom on 5/19/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "YBYContainerController.h"
#import "YBYSearchOrderTableViewController.h"

@interface YBYContainerController ()

@property (nonatomic, strong) YBYSearchOrderTableViewController *tableViewController;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation YBYContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查找订单";
    
    self.tableViewController = [[YBYSearchOrderTableViewController alloc] init];
    [self rn_addChildViewController:self.tableViewController];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.tableViewController.searchBar contentsController:self];
    for(id cc in [self.searchController.searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableViewController.view.frame = self.view.bounds;
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

- (void)rn_addChildViewController:(UIViewController *)controller {
    [controller beginAppearanceTransition:YES animated:NO];
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:controller];
    [controller endAppearanceTransition];
}

- (void)rn_removeChildViewController:(UIViewController *)controller {
    if ([self.childViewControllers containsObject:controller]) {
        [controller beginAppearanceTransition:NO animated:NO];
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
        [controller didMoveToParentViewController:nil];
        [controller endAppearanceTransition];
    }
}

@end
