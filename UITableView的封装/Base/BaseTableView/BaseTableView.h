//
//  BaseTableView.h
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageAPIRequest.h"
#import "BaseTableViewDataSource.h"
#import "BaseTableViewDelegate.h"

typedef void (^HeaderWithRefreshingBlock)();

@interface BaseTableView : UITableView

@property(nonatomic, strong) PageAPIRequest*    pageRequest;
@property(nonatomic, strong) NSMutableArray*    dataArray;
@property(nonatomic, strong) Class              listModelClass;
@property(nonatomic, strong) Class              tableViewCellClass;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;
@property(nonatomic, copy  ) CellHeightBlock    cellHeightBlock;
@property(nonatomic, copy  ) CellSelectBlock    cellSelectBlock;
@property(nonatomic, copy  ) CellCountBlock     cellCountBlock;
@property(nonatomic, copy  ) HeaderWithRefreshingBlock  headerWithRefreshingBlock;
@property(nonatomic, copy  ) EditActionsForRowAtIndexPath  editActionsForRowAtIndexPath;

@property(nonatomic, assign) BOOL           isPaging;
@property(nonatomic, assign) BOOL           isRefresh;
@property(nonatomic, assign) BOOL           isShowEmptyTip;
@property(nonatomic, assign) BOOL           isHeightCache;
@property(nonatomic, assign) BOOL           clearSeperatorInset;
@property(nonatomic, assign) BOOL           isShowOrHiddenEmptyTip;

- (void)loadDataFromServer;
- (void)reLoadDataFromServer;
- (void)loadSuccess;
- (void)loadFail:(NSString *)errorMsg;

@end
