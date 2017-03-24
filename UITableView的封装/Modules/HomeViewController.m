//
//  HomeViewController.m
//  UITableView的封装
//
//  Created by 宇玄丶 on 2017/3/24.
//  Copyright © 2017年 北京116工作室. All rights reserved.
//

#import "HomeViewController.h"
#import "ShopCell.h"

@interface HomeViewController () <GoodsEditeDelegate>
@property(nonatomic,strong)BaseTableView *shopTableView;
@end

@implementation HomeViewController

- (void)loadSubViews {
    [super loadSubViews];
    self.titleLabel.text = @"UITbaleView的封装";
    [self.contentView addSubview:self.shopTableView];
}

- (void)layoutConstraints {
    [self.shopTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}


#pragma mark - 将请求的数据源，赋值给self.shopTableView.dataArray的数据源，因为BaseTableView里面已经写了 数据源，所有直接赋值即可。 

#pragma mark - 此demo，由于是假数据，所以当真实数据的情况下，不要忘了[tableView reload]操作。
- (void)loadData {
    GoodsModel *goodsData = [[GoodsModel alloc] init];
    goodsData.name = @" Title";
    goodsData.img_url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490339743727&di=921466b975276b5abc5752d8ca088529&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg";
    self.shopTableView.dataArray = [@[goodsData,goodsData,goodsData,goodsData,goodsData,goodsData] mutableCopy];
}

#pragma mark - 如果换成数据请求，写成这样即可，具体实现，请看：http://www.jianshu.com/p/809ddb0b745e

#pragma makr - 这样就是网络层的抽离，结合tableView,使用起来简直爽的不要不要的，简单、实用、快速。

/*
#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request {
    if (request == self.addCartRequest) {
        return @{@"goods_id":self.operatingGoods.goods_id,
                 @"number":@"1"};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
    if (request == self.goodsListRequest) {
        self.shopTableView.dataArray = [[request.responseData valueForKey:@"data"] mutableCopy];
        [self.shopTableView reloadData];
        return;
    }
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
}
*/



#pragma mark - 因为cell的样式只有一种，使用起来非常方便，免去了一大堆协议，更多方法，查看封装的方法就行，也可根据需求自行添加； 不太使用分组显示，所以在每个cell的下面加了一个10像素的view替代。因为tableview的代理方法， 
// - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   // return 0.01;
// }
// 我设置的是0.01，根据需要自己调整吧 。


#pragma mark  - 建议将控件写成懒加载的模式，一是为了性能，二是可缩起， 这样整个控制器看其起来就会显得非常简洁。维护起来也方便。
- (BaseTableView *)shopTableView {
    if (!_shopTableView) {
        _shopTableView = [[BaseTableView alloc] init];
        _shopTableView.tableViewCellClass = [ShopCell class];
        _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _shopTableView.clearSeperatorInset = YES;
        _shopTableView.isHeightCache = YES;
        _shopTableView.showsVerticalScrollIndicator = NO;
        WS(weakSelf);
        // 可以理解为cell的复用池
        _shopTableView.cellConfigureBlock = ^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
            ((ShopCell *)cell).delegate = weakSelf;
        };
        // 点击cell跳转  （didSelectRowAtIndexPath）
        _shopTableView.cellSelectBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
//            GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
//            detailVC.goodsData = weakSelf.shopTableView.dataArray[indexPath.row];
//            [AppCommon pushViewController:detailVC animated:YES];
        };
        
        // 侧滑 （可添加多个，写到return返回的数组即可）
        _shopTableView.editActionsForRowAtIndexPath = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                // AlertViewController ：我自己封装的：http://www.jianshu.com/p/418fe079d356
//                ComAlertView *alertView = [[ComAlertView alloc]initWithTitle:@"删除商品" message:@"确定要删除宝贝吗？删除之后无法修改了哦~" sureBtn:@"确定" cancleBtn:@"取消"];
//                alertView.resultIndex = ^(NSInteger index){
//                    weakSelf.currentIndexPath = indexPath;
//                    [weakSelf.deleteCartRequest loadDataWithHUDOnView:nil];
//                };
//                [alertView showAlertView];
            }];
            deleteAction.backgroundColor = [UIColor redColor];
            return @[deleteAction];
        };
    }
    return _shopTableView;
}

@end
