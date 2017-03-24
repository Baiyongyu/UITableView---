//
//  AppDelegate.h
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTabBarController.h"
#import "AppNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppNavigationController *nav;
@property (strong, nonatomic) AppTabBarController *tabBarController;

- (void)loadLoginVC;
- (void)loadMainVC;

@end

