//
//  OrderDetailViewController.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/28.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCell.h"
//#import "OrderDetailsRequest.h"

@interface OrderDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *orderDetailTableView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *cellArray;
//@property(nonatomic,strong)OrderDetailsRequest *orderDetailsRequest;
@end

@implementation OrderDetailViewController

- (void)loadSubViews {
    [super loadSubViews];
    self.titleLabel.text = @"订单详细";
    [self.contentView addSubview:self.orderDetailTableView];
}

- (void)layoutConstraints {
    WS(weakSelf);
    [self.orderDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

- (void)loadData {
//    [self.orderDetailsRequest loadDataWithHUDOnView:self.orderDetailTableView];
    
    OrderModel *orderData = [[OrderModel alloc] init];
    orderData.order_no = @"SDEBK238582853924";
    orderData.status = OrderStatusWaitingPay;
    orderData.receiver = @"宇玄丶";
    orderData.receiver_phone = @"13666666666";
    orderData.amount = @"10000000.00";
    orderData.create_time = @"2017-03-24 09:09:09";
    orderData.send_time = @"aslflasf";
    orderData.payment_time = @"123124144";
    orderData.receiver_address = @"北京天安门广场";
    self.orderData = orderData;
    
    GoodsModel *goodsData = [[GoodsModel alloc] init];
    goodsData.name = @"这是上平名称";
    goodsData.img_url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490339743727&di=921466b975276b5abc5752d8ca088529&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg";
    goodsData.number = @"666";
    goodsData.price = @"88888";
    
    self.orderData.items = @[goodsData,goodsData,goodsData];
    
    
    
    self.dataArray = [NSMutableArray array];
    self.cellArray = [NSMutableArray array];
    
    [self.dataArray addObject:self.orderData];
    [self.cellArray addObject:[[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
    
    [self.dataArray addObject:self.orderData];
    [self.cellArray addObject:[[OrderDistributionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
    
    // 注意此处商品是一个数组，注意格式。
    [self.dataArray addObject:self.orderData.items.count?self.orderData.items:[NSArray array]];
    [self.cellArray addObject:[[OrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
    
    [self.dataArray addObject:self.orderData];
    [self.cellArray addObject:[[OrderCostDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
    
    [self.orderDetailTableView reloadData];
}

/*
#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request {
    if (request == self.orderDetailsRequest) {
        return @{@"order_id":self.orderData.order_id};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
    if (request == self.orderDetailsRequest) {
        self.orderData = ((OrderDetailsResponse *)request.responseData).data;
        
        self.dataArray = [NSMutableArray array];
        self.cellArray = [NSMutableArray array];
        
        [self.dataArray addObject:self.orderData];
        [self.cellArray addObject:[[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
        
        [self.dataArray addObject:self.orderData];
        [self.cellArray addObject:[[OrderDistributionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
        
        [self.dataArray addObject:self.orderData.items.count?self.orderData.items:[NSArray array]];
        [self.cellArray addObject:[[OrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
        
        [self.dataArray addObject:self.orderData];
        [self.cellArray addObject:[[OrderCostDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""]];
        
        [self.orderDetailTableView reloadData];
        
        return;
    }
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailCell *cell = self.cellArray[indexPath.row];
    [cell setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailCell *cell = self.cellArray[indexPath.row];
    return [cell cellAutoHeight:self.dataArray[indexPath.row] atIndexPath:indexPath];
}

#pragma mark - getters
- (UITableView *)orderDetailTableView {
    if (!_orderDetailTableView) {
        _orderDetailTableView = [[UITableView alloc] init];
        _orderDetailTableView.backgroundColor = COLOR_BG_COMMON;
        _orderDetailTableView.delegate = self;
        _orderDetailTableView.dataSource = self;
        _orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderDetailTableView.showsVerticalScrollIndicator = NO;
        _orderDetailTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    }
    return _orderDetailTableView;
}

//- (OrderDetailsRequest *)orderDetailsRequest {
//    if (!_orderDetailsRequest) {
//        _orderDetailsRequest = [[OrderDetailsRequest alloc] initWithDelegate:self paramSource:self];
//    }
//    return _orderDetailsRequest;
//}

@end
