//
//  BaseTableViewDataSource.h
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(UITableViewCell *cell, id data, NSIndexPath *indexPath);
typedef NSInteger (^CellCountBlock)(UITableView *tableView, NSInteger section);

@interface BaseTableViewDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray *items;

@property(nonatomic, copy)CellCountBlock cellCountBlock;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
                    cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

@end
