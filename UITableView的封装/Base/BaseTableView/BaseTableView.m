//
//  BaseTableView.m
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import "BaseTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "BaseTableViewCell.h"
//#import "ViewHelper.h"
#import "MBProgressHUD.h"

#define CellReuseIdentifier @"Cell"

@interface BaseTableView() <APIManagerApiCallBackDelegate>

@property(nonatomic, strong) BaseTableViewDataSource     *tableDataSource;
@property(nonatomic, strong) BaseTableViewDelegate       *tableDelegate;
@property(nonatomic, strong) MJRefreshNormalHeader       *comHeader;
@property(nonatomic, strong) MJRefreshAutoNormalFooter   *comFooter;

@property(nonatomic, strong) BaseTableViewCell       *cellHeight;      // 只创建一个cell用作测量高度
@property(nonatomic, strong) NSMutableDictionary     *cellHeightCache;  // 行高缓存

@end

@implementation BaseTableView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.dataSource = self.tableDataSource;
    self.delegate = self.tableDelegate;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
}

- (BaseTableViewDataSource *)tableDataSource {
    if (!_tableDataSource) {
        __weak typeof(self) weakSelf = self;
        _tableDataSource = [[BaseTableViewDataSource alloc] initWithCellIdentifier:CellReuseIdentifier cellConfigureBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
            if ([cell isKindOfClass:[BaseTableViewCell class]]) {
                BaseTableViewCell *comCell = (BaseTableViewCell *)cell;
                comCell.item = item;
                comCell.indexPath = indexPath;
                [comCell setCellData:item atIndexPath:indexPath];
            }
            if (weakSelf.cellConfigureBlock) {
                weakSelf.cellConfigureBlock(cell, item, indexPath);
            }
        }];
    }
    return _tableDataSource;
}

- (BaseTableViewDelegate *)tableDelegate {
    if (!_tableDelegate) {
        __weak typeof(self) weakSelf = self;
        _tableDelegate = [[BaseTableViewDelegate alloc] init];
        _tableDelegate.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            // 先取缓存
            if (weakSelf.isHeightCache && [weakSelf.cellHeightCache.allKeys containsObject:@(indexPath.row)]) {
                CGFloat height = [weakSelf.cellHeightCache[@(indexPath.row)] floatValue];
                return height;
            }
            
            CGFloat cellHeight = TableViewCellDefaultHeight;
            if (weakSelf.cellHeightBlock) {
                cellHeight = weakSelf.cellHeightBlock(tableView, indexPath);
            }
            else {
                if ([weakSelf.cellHeight isKindOfClass:[BaseTableViewCell class]]) {
                    if (weakSelf.dataArray.count) {
                        cellHeight = [weakSelf.cellHeight cellHeight:weakSelf.dataArray[indexPath.row] atIndexPath:indexPath];
                    } else {
                        cellHeight = [weakSelf.cellHeight cellHeight:weakSelf.pageRequest.listArray[indexPath.row] atIndexPath:indexPath];
                    }
                }
            }
            
            // 缓存height
            if (weakSelf.isHeightCache) {
                [weakSelf.cellHeightCache setObject:@(cellHeight) forKey:@(indexPath.row)];
            }
            
            return cellHeight;
        };
        _tableDelegate.cellSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(tableView, indexPath);
            }
        };
        
        _tableDelegate.editActionsForRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.editActionsForRowAtIndexPath) {
                return weakSelf.editActionsForRowAtIndexPath(tableView,indexPath);
            }
            return [NSArray array];
        };
    }
    return _tableDelegate;
}

- (MJRefreshNormalHeader *)comHeader {
    if (!_comHeader) {
        __weak typeof(self) weakSelf = self;
        _comHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (self.isHeightCache) {
                [self.cellHeightCache removeAllObjects];
            }
            if (self.headerWithRefreshingBlock) {
                self.headerWithRefreshingBlock();
            } else {
//                [ErrorViewHelper removeErrorViewFromView:self.superview];
                self.pageRequest.moreData = NO;
                [weakSelf.pageRequest reload];
            }
        }];
        [_comHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [_comHeader setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [_comHeader setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        _comHeader.stateLabel.font = [UIFont systemFontOfSize:14];
        _comHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _comHeader;
}

- (MJRefreshAutoNormalFooter *)comFooter {
    if (!_comFooter) {
        __weak typeof(self) weakSelf = self;
        _comFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.pageRequest loadDataWithHUDOnView:nil];
        }];
        [_comFooter setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [_comFooter setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_comFooter setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
        _comFooter.stateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _comFooter;
}

- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
    if (request==self.pageRequest) {
        [self loadSuccess];
        return;
    }
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
    if (request==self.pageRequest) {
        [self loadFail:request.msg];
        return;
    }
}

- (void)setTableViewCellClass:(Class)tableViewCellClass {
    _tableViewCellClass = tableViewCellClass;
    [self registerClass:_tableViewCellClass forCellReuseIdentifier:CellReuseIdentifier];
    
    self.cellHeight = [self dequeueReusableCellWithIdentifier:CellReuseIdentifier];
}

- (void)setPageRequest:(PageAPIRequest *)pageRequest {
    if (_pageRequest == pageRequest) {
        return;
    }
    
    _pageRequest = pageRequest;
    self.tableDataSource.items = _pageRequest.listArray;
    self.isPaging = YES;
    self.isRefresh = YES;
    self.isShowEmptyTip = YES;
    _pageRequest.delegate = self;
    
    [self loadDataFromServer];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    if (_dataArray == dataArray) {
        return;
    }
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    _dataArray = dataArray;
    self.tableDataSource.items = _dataArray;
    self.isPaging = NO;
    self.isRefresh = NO;
    self.isShowEmptyTip = YES;
}

- (void)setClearSeperatorInset:(BOOL)clearSeperatorInset {
    self.tableDelegate.clearSeperatorInset = clearSeperatorInset;
}

- (void)setCellConfigureBlock:(CellConfigureBlock)cellConfigureBlock {
    if (_cellConfigureBlock == cellConfigureBlock) {
        return;
    }
    _cellConfigureBlock = cellConfigureBlock;
    self.cellHeight.cellConfigureBlock = _cellConfigureBlock;
}

- (void)setCellCountBlock:(CellCountBlock)cellCountBlock {
    if (_cellCountBlock == cellCountBlock) {
        return;
    }
    _cellCountBlock = cellCountBlock;
    self.tableDataSource.cellCountBlock = cellCountBlock;
}

- (NSMutableDictionary *)cellHeightCache {
    if (!_cellHeightCache) {
        _cellHeightCache = [NSMutableDictionary dictionary];
    }
    return _cellHeightCache;
}

- (void)setIsHeightCache:(BOOL)isHeightCache {
    _isHeightCache = isHeightCache;
    if (_isHeightCache) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self.cellHeightCache
                                                 selector:@selector(removeAllObjects)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
}

- (void)reLoadDataFromServer {
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    UIView *hudSuperView = nil;
    if ([self viewController] && [[self viewController] isKindOfClass:[BaseViewController class]]) {
        BaseViewController *superVC = (BaseViewController *)[self viewController];
        hudSuperView = superVC.contentView;
    } else if (topMostViewController() && [topMostViewController() isKindOfClass:[BaseViewController class]]){
        hudSuperView = ((BaseViewController *)topMostViewController()).contentView;
    } else {
        hudSuperView = self.superview;
    }
    [self.pageRequest reloadOnView:hudSuperView];
}

- (void)loadDataFromServer {
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
    UIView *hudSuperView = nil;
    if ([self viewController] && [[self viewController] isKindOfClass:[BaseViewController class]]) {
        BaseViewController *superVC = (BaseViewController *)[self viewController];
        hudSuperView = superVC.contentView;
    } else if (topMostViewController() && [topMostViewController() isKindOfClass:[BaseViewController class]]){
        hudSuperView = ((BaseViewController *)topMostViewController()).contentView;
    } else {
        hudSuperView = self.superview;
    }
    [self.pageRequest reloadOnView:hudSuperView];
}

- (void)loadFail:(NSString *)errorMsg {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self reloadData];
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
    
    if (self.isShowEmptyTip) {
        __weak typeof(self) weakSelf = self;
//        [ErrorViewHelper showErrorViewInView:self.superview withError:errorMsg clickBlock:^{
//            [weakSelf reLoadDataFromServer];
//        }];
    }
}

- (void)loadSuccess {
//    [ErrorViewHelper removeErrorViewFromView:self.superview];
    
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (!self.pageRequest.moreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    [self reloadData];
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
    
    if ([self.pageRequest.listArray count] == 0) {
        if (self.isShowEmptyTip) {
            if (self.isShowOrHiddenEmptyTip) {
//                [ErrorViewHelper showEmptyViewInView:self.superview];
            }
        }
    }
}

- (void)setIsPaging:(BOOL)isPaging {
    _isPaging = isPaging;
    self.mj_footer = _isPaging ? self.comFooter : nil;
    self.mj_footer.hidden = YES;
}

- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    self.mj_header = _isRefresh ? self.comHeader : nil;
}


@end
