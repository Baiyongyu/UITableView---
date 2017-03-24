//
//  AppTabBarController.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import "AppTabBarController.h"
#import "HomeViewController.h"//首页
#import "MineViewController.h"//个人中心
#import "NotificationViewController.h"//消息
#import "OrderDetailViewController.h"//订单详情

@interface AppTabBarController ()

@end

@implementation AppTabBarController

- (instancetype)init {
    
    if (self = [super init]) {
        // 首页
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.tabBarItem.title = @"首页";
        homeVC.tabBarItem.image = [UIImage imageNamed:@"ic_home_normal"];
        homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_home_selected"];
        
        // 购物车
        OrderDetailViewController *shopVC = [[OrderDetailViewController alloc] init];
        shopVC.tabBarItem.title = @"订单";
        shopVC.tabBarItem.image = [UIImage imageNamed:@"ic_cart_normal"];
        shopVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_cart_selected"];
        
        // 消息
        NotificationViewController *messageVC = [[NotificationViewController alloc] init];
        messageVC.tabBarItem.title = @"消息";
        messageVC.tabBarItem.image = [UIImage imageNamed:@"ic_message_normal"];
        messageVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_message_selected"];
        
        
        // 我的
        MineViewController *mineVC = [[MineViewController alloc] init];
        mineVC.tabBarItem.title = @"个人中心";
        mineVC.tabBarItem.image = [UIImage imageNamed:@"ic_mine_normal"];
        mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_mine_selected"];
        
        self.viewControllers = @[homeVC ,shopVC, messageVC, mineVC];
    }
    return self;
}

@end
