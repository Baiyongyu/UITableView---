//
//  AppTabBarController.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

typedef NS_ENUM(NSInteger,TabBarIndex) {
    TabBarIndexHome,        //首页
    TabBarIndexCart,        //购物车
    TabBarIndexMessage,     //消息
    TabBarIndexMine         //个人中心
};

#import <UIKit/UIKit.h>

@interface AppTabBarController : UITabBarController

@end
