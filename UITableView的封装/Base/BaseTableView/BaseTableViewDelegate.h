//
//  BaseTableViewDelegate.h
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^CellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSArray * (^EditActionsForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

@interface BaseTableViewDelegate : NSObject <UITableViewDelegate>

@property(nonatomic, copy  ) CellHeightBlock cellHeightBlock;
@property(nonatomic, copy  ) CellSelectBlock cellSelectBlock;
@property(nonatomic, copy  ) EditActionsForRowAtIndexPath editActionsForRowAtIndexPath;

@property(nonatomic, assign) BOOL clearSeperatorInset;

@end
