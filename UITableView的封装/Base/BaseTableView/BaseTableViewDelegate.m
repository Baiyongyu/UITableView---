//
//  BaseTableViewDelegate.m
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import "BaseTableViewDelegate.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewDelegate()

@property(nonatomic,copy)NSString *cellIdentifier;

@end

@implementation BaseTableViewDelegate

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellSelectBlock) {
        _cellSelectBlock(tableView, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellHeightBlock) {
        return _cellHeightBlock(tableView, indexPath);
    }
    return TableViewCellDefaultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editActionsForRowAtIndexPath) {
        return self.editActionsForRowAtIndexPath(tableView,indexPath);
    }
    return [NSArray array];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.clearSeperatorInset) {
        return;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
