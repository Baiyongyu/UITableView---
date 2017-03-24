//
//  OrderDetailCell.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/28.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrderDetailBaseCell : UIView
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UILabel *detailTextLabel;
@end


#pragma mark - 基类
@interface OrderDetailCell : BaseTableViewCell
//标题
@property(nonatomic,strong)OrderDetailBaseCell *titleCell;
@end

//订单信息
@interface OrderInfoCell : OrderDetailCell

@end


//配送信息
@interface OrderDistributionCell : OrderDetailCell

@end

//商品清单
@interface OrderGoodsCell : OrderDetailCell

@end

//费用明细
@interface OrderCostDetailCell : OrderDetailCell

@end

