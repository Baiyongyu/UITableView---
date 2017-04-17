# UITableView---
UITableView的封装-使用起来超简单

>在一个项目中，使用最多的还要数tableView，更有甚者几乎每个界面都是tableView，那么多协议方法，如果每个界面都写一遍，是不是会很恶心，造成大量的代码冗余。索性、封装起来，调用起来非常方便、代码看起来简洁，干净。

上图：

![UITableView的封装](http://upload-images.jianshu.io/upload_images/2381595-cc9de9367d9dd969.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

1、不在继承UITableVIewCell，改成继承自BaseTableViewCell
```
@interface ShopCell : BaseTableViewCell
@property(nonatomic,strong)GoodsModel *goodsData;
@property(nonatomic,weak)id<GoodsEditeDelegate>delegate;
@end
```
2、cell的赋值操作
```
- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *goodsData = (GoodsModel *)item;
    、、、
}
```
3、Controller里面
```
1>定义一个tableView，注意是：BaseTableView
@property(nonatomic,strong)BaseTableView *shopTableView;

2>初始化tableView，写各种代理方法
- (BaseTableView *)shopTableView {
    if (!_shopTableView) {
        _shopTableView = [[BaseTableView alloc] init];
        // 加载的cell
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
        // GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
        // detailVC.goodsData = weakSelf.shopTableView.dataArray[indexPath.row];
        //  [AppCommon pushViewController:detailVC animated:YES];
        };
        
        // 侧滑 （可添加多个，写到return返回的数组即可）
        _shopTableView.editActionsForRowAtIndexPath = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
          // AlertViewController ：我自己封装的：http://www.jianshu.com/p/418fe079d356
          // ComAlertView *alertView = [[ComAlertView alloc]initWithTitle:@"删除商品" message:@"确定要删除宝贝吗？删除之后无法修改了哦~" sureBtn:@"确定" cancleBtn:@"取消"];
          //  alertView.resultIndex = ^(NSInteger index){
                // weakSelf.currentIndexPath = indexPath;
                // [weakSelf.deleteCartRequest loadDataWithHUDOnView:nil];  
          //  };
          //   [alertView showAlertView];
            }];
            deleteAction.backgroundColor = [UIColor redColor];
            return @[deleteAction];
        };
    }
    return _shopTableView;
}
```

4、将数据源，赋值给tableView的数据源
```
#pragma mark - 此demo，由于是假数据，所以当真实数据的情况下，不要忘了[tableView reload]操作。
- (void)loadData {
    GoodsModel *goodsData = [[GoodsModel alloc] init];
    goodsData.name = @" Title";
    goodsData.img_url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490339743727&di=921466b975276b5abc5752d8ca088529&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg";
    self.shopTableView.dataArray = [@[goodsData,goodsData,goodsData,goodsData,goodsData,goodsData] mutableCopy];
}
```

哪里有不合适的地方，欢迎各位大神指正，谢谢。
感觉不错的小伙伴记得来个star哈。^_^
