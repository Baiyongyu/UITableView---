//
//  OrderDetailCell.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/28.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "OrderDetailCell.h"

@interface OrderDetailBaseCell ()

@end

@implementation OrderDetailBaseCell

- (instancetype)init {
    self = [super init];
    if (self) {
        WS(weakSelf);
        [self addSubview:self.textLabel];
        [self addSubview:self.detailTextLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_SPACE);
            make.right.mas_equalTo(weakSelf).offset(-10);
            make.top.bottom.equalTo(weakSelf);
        }];
        [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf).offset(-MARGIN_SPACE);
            make.left.mas_greaterThanOrEqualTo(weakSelf.textLabel);
        }];
    }
    return self;
}

#pragma mark - getters
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = FONT_NORMAL;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UILabel *)detailTextLabel {
    if (!_detailTextLabel) {
        _detailTextLabel = [[UILabel alloc] init];
        _detailTextLabel.font = FONT_NORMAL;
        _detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailTextLabel;
}

@end

@interface OrderDetailCell ()

@end

@implementation OrderDetailCell

- (void)buildCellView {
    WS(weakSelf);
    [self.contentView addSubview:self.titleCell];
    [self.titleCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - getters
- (OrderDetailBaseCell *)titleCell {
    if (!_titleCell) {
        _titleCell = [[OrderDetailBaseCell alloc] init];
        _titleCell.textLabel.font = FONT_NORMAL;
        _titleCell.textLabel.textColor = COLOR_TEXT_DEEP;
        [_titleCell addLineOnBottom];
    }
    return _titleCell;
}

@end



@interface OrderInfoCell ()
@property(nonatomic,strong)OrderDetailBaseCell *orderLabelCell;
@property(nonatomic,strong)OrderDetailBaseCell *dealTimeCell;
@property(nonatomic,strong)OrderDetailBaseCell *orderStatusCell;
@end

@implementation OrderInfoCell

- (void)buildCellView {
    [super buildCellView];
    
    self.titleCell.textLabel.text = @"订单信息";
    WS(weakSelf);
    [self.contentView addSubview:self.orderLabelCell];
    [self.orderLabelCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.titleCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.dealTimeCell];
    [self.dealTimeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.orderLabelCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.orderStatusCell];
    [self.orderStatusCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.dealTimeCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIView *bottomSeperator = [[UIView alloc] init];
    bottomSeperator.backgroundColor = COLOR_BG_COMMON;
    [self.contentView addSubview:bottomSeperator];
    [bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderStatusCell.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    OrderModel *orderData = (OrderModel *)item;
    
    self.orderLabelCell.textLabel.text = [NSString stringWithFormat:@"订单编号：%@", orderData.order_no];
    self.dealTimeCell.textLabel.text = [NSString stringWithFormat:@"成交时间：%@", orderData.create_time];
    
    NSString *orderStatus = @"";
    switch (orderData.status) {
        case OrderStatusWaitingPay:       //待付款
        {
            orderStatus = @"待付款";
            break;
        }
            
        case OrderStatusWaitingSend:    //待发货
        {
            orderStatus = @"待发货";
            break;
        }
        case OrderStatusWaitingReceiving: //待收货
        {
            orderStatus = @"待收货";
            break;
        }
        case OrderStatusWaitingEvaluate:  //待评价
        {
            orderStatus = @"待评价";
            break;
        }
        case OrderStatusDealSuccess:  //交易成功
        {
            orderStatus = @"交易成功";
            break;
        }
        case OrderStatusrRefund:  //退款
        {
            orderStatus = @"退款";
            break;
        }
        default:
            break;
    }
    self.orderStatusCell.textLabel.text = [NSString stringWithFormat:@"订单状态：%@", orderStatus];
}

- (OrderDetailBaseCell *)orderLabelCell {
    if (!_orderLabelCell) {
        _orderLabelCell = [[OrderDetailBaseCell alloc] init];
        _orderLabelCell.textLabel.font = FONT_NORMAL;
        _orderLabelCell.textLabel.textColor = COLOR_TEXT_DEEP;
        _orderLabelCell.detailTextLabel.textColor = COLOR_TEXT_RED;
    }
    return _orderLabelCell;
}

- (OrderDetailBaseCell *)dealTimeCell {
    if (!_dealTimeCell) {
        _dealTimeCell = [[OrderDetailBaseCell alloc] init];
        _dealTimeCell.textLabel.font = FONT_NORMAL;
        _dealTimeCell.textLabel.textColor = COLOR_TEXT_DEEP;
        _dealTimeCell.detailTextLabel.textColor = COLOR_TEXT_RED;
    }
    return _dealTimeCell;
}

- (OrderDetailBaseCell *)orderStatusCell {
    if (!_orderStatusCell) {
        _orderStatusCell = [[OrderDetailBaseCell alloc] init];
        _orderStatusCell.textLabel.font = FONT_NORMAL;
        _orderStatusCell.textLabel.textColor = COLOR_TEXT_DEEP;
        _orderStatusCell.detailTextLabel.textColor = COLOR_TEXT_RED;
    }
    return _orderStatusCell;
}

@end



@interface OrderDistributionCell ()
@property(nonatomic,strong)OrderDetailBaseCell *receiverCell;
@property(nonatomic,strong)OrderDetailBaseCell *addressCell;
@end

@implementation OrderDistributionCell

- (void)buildCellView {
    [super buildCellView];
    
    self.titleCell.textLabel.text = @"配送信息";
    WS(weakSelf);
    [self.contentView addSubview:self.receiverCell];
    [self.receiverCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.titleCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.addressCell];
    [self.addressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(0);
        make.top.equalTo(weakSelf.receiverCell.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    
    UIView *bottomSeperator = [[UIView alloc] init];
    bottomSeperator.backgroundColor = COLOR_BG_COMMON;
    [self.contentView addSubview:bottomSeperator];
    [bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.addressCell.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(call)];
    self.receiverCell.detailTextLabel.userInteractionEnabled = YES;
    [self.receiverCell.detailTextLabel addGestureRecognizer:tapGesture];
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    OrderModel *orderInfoModel = (OrderModel *)item;
    self.item = item;
    
    self.receiverCell.textLabel.text = [NSString stringWithFormat:@"收货人：%@", orderInfoModel.receiver];
    self.receiverCell.detailTextLabel.text = orderInfoModel.receiver_phone;
    self.addressCell.textLabel.text = [NSString stringWithFormat:@"收货地址：%@", orderInfoModel.receiver_address];
}

#pragma mark - actions
- (void)call {
    OrderModel *orderData = (OrderModel *)self.item;
//    [CommonUtils call:orderData.receiver_phone];
    return;
}

#pragma mark - getters
- (OrderDetailBaseCell *)receiverCell {
    if (!_receiverCell) {
        _receiverCell = [[OrderDetailBaseCell alloc] init];
        _receiverCell.textLabel.font = FONT_NORMAL;
        _receiverCell.textLabel.textColor = COLOR_TEXT_DEEP;
        _receiverCell.detailTextLabel.textColor = COLOR_NAVBAR_THEME;
    }
    return _receiverCell;
}

- (OrderDetailBaseCell *)addressCell {
    if (!_addressCell) {
        _addressCell = [[OrderDetailBaseCell alloc] init];
        _addressCell.textLabel.font = FONT_NORMAL;
        _addressCell.textLabel.textColor = COLOR_TEXT_DEEP;
    }
    return _addressCell;
}

@end


@interface OrderGoodsCell ()
@property(nonatomic,strong)UIView *topSeperator;
//商品清单
@property(nonatomic,strong)UILabel *orderLabel;
@property(nonatomic,strong)UIView *lineView1;
@end

@implementation OrderGoodsCell

- (void)buildCellView {
    [super buildCellView];
    self.backgroundColor = COLOR_BG_WHITE;
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *goodsArray = (NSArray *)item;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    WS(weakSelf);
    
    //商品清单
    [self.contentView addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(44);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
    
    //线
    UIView *lineView = [ViewHelper createLineView];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.orderLabel.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *goodsViewCell = nil;
    
    for (int i = 0; i < goodsArray.count; i++) {
        
        GoodsModel *goodsData = goodsArray[i];
        
        UIView *goodsCell = [[UIView alloc] init];
        [self.contentView addSubview:goodsCell];
        
        //商品图片
        UIImageView *goodsImgView = [[UIImageView alloc] init];
        goodsImgView.contentMode = UIViewContentModeScaleAspectFit;
        goodsImgView.clipsToBounds = YES;
        goodsImgView.layer.borderColor = COLOR_LINE.CGColor;
        goodsImgView.layer.borderWidth = 0.5;
        [goodsCell addSubview:goodsImgView];
        [goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.width.height.mas_equalTo(60);
        }];
        [goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsData.img_url] placeholderImage:IMAGE_PLACEHOLDER];
        
        //商品名称
        UILabel *goodsNameLabel = [[UILabel alloc] init];
        goodsNameLabel.font = FONT_NORMAL;
        goodsNameLabel.numberOfLines = 2;
        [goodsCell addSubview:goodsNameLabel];
        [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImgView.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.top.mas_equalTo(10);
        }];
        goodsNameLabel.preferredMaxLayoutWidth = (SCREEN_WIDTH - MARGIN_SPACE * 9);
        [goodsNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        goodsNameLabel.text = [NSString stringWithFormat:@"%@",goodsData.name];
    
        //数量
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = FONT_NORMAL;
        countLabel.textAlignment = NSTextAlignmentLeft;
        [goodsCell addSubview:countLabel];
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.width.mas_greaterThanOrEqualTo(20);
            make.bottom.mas_equalTo(goodsImgView);
        }];
        countLabel.text = [NSString stringWithFormat:@"x%d", goodsData.number.intValue];
        
        //价格和规格
        UILabel *priceAndSkuLabel = [[UILabel alloc] init];
        priceAndSkuLabel.font = FONT_NORMAL;
        priceAndSkuLabel.textColor = COLOR_TEXT_LIGHT;
        priceAndSkuLabel.textAlignment = NSTextAlignmentLeft;
        [goodsCell addSubview:priceAndSkuLabel];
        [priceAndSkuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImgView.mas_right).offset(10);
            make.right.equalTo(countLabel.mas_left).offset(-10);
            make.bottom.mas_equalTo(goodsImgView);
        }];
        priceAndSkuLabel.text = [NSString stringWithFormat:@"￥%.2f件    规格：%@kg/袋", goodsData.number.doubleValue, goodsData.price];

        
        //线
        UIView *lineView1 = [ViewHelper createLineView];
        [goodsCell addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.contentView);
            make.top.mas_equalTo(goodsImgView.mas_bottom).offset(10);
            make.height.mas_equalTo(0.5);
        }];
        if (i == 0) {
            [goodsCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.left.right.equalTo(weakSelf.contentView);
                make.height.mas_equalTo(80);
            }];
        } else {
            __weak typeof(goodsViewCell)weakFormerCell = goodsViewCell;
            [goodsCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakFormerCell.mas_bottom);
                make.left.right.equalTo(weakSelf.contentView);
                make.height.mas_equalTo(80);
            }];
        }
        goodsViewCell = goodsCell;
    }

    __weak typeof(goodsViewCell)weakFormerCell = goodsViewCell;
    UIView *bottomSeperator = [[UIView alloc] init];
    bottomSeperator.backgroundColor = COLOR_BG_COMMON;
    [self.contentView addSubview:bottomSeperator];
    [bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        if (weakFormerCell) {
            make.top.mas_equalTo(weakFormerCell.mas_bottom);
        } else {
            make.top.mas_equalTo(lineView.mas_bottom);
        }
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = FONT_NORMAL;
        _orderLabel.textColor = COLOR_TEXT_DEEP;
        _orderLabel.text = @"商品清单";
    }
    return _orderLabel;
}

@end

@interface OrderCostDetailCell ()
@property(nonatomic,strong)OrderDetailBaseCell *totalPriceCell;
@property(nonatomic,strong)OrderDetailBaseCell *freightPriceCell;
@property(nonatomic,strong)OrderDetailBaseCell *shoulePayPriceCell;
@property(nonatomic,strong)OrderDetailBaseCell *discountTicketCell;
@property(nonatomic,strong)OrderDetailBaseCell *cashCell;
@end

@implementation OrderCostDetailCell

- (void)buildCellView {
    [super buildCellView];
    
    self.titleCell.textLabel.text = @"费用明细";
    WS(weakSelf);
    [self.contentView addSubview:self.totalPriceCell];
    [self.totalPriceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.titleCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.freightPriceCell];
    [self.freightPriceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.totalPriceCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.shoulePayPriceCell];
    [self.shoulePayPriceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.freightPriceCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.discountTicketCell];
    [self.discountTicketCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.shoulePayPriceCell.mas_bottom);
        make.height.mas_equalTo(44);
    }];

    [self.contentView addSubview:self.cashCell];
    [self.cashCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.discountTicketCell.mas_bottom);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(weakSelf.contentView);
    }];
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    OrderModel *orderData = (OrderModel *)item;
    
    self.totalPriceCell.textLabel.text = [NSString stringWithFormat:@"商品金额：¥ %.2f", orderData.goods_total_amount.doubleValue];
    self.freightPriceCell.textLabel.text = [NSString stringWithFormat:@"运费金额：¥ %.2f", orderData.freight.doubleValue];
    self.shoulePayPriceCell.textLabel.text = [NSString stringWithFormat:@"应付金额：¥ %.2f", orderData.amount.doubleValue + orderData.freight.doubleValue];
    self.discountTicketCell.textLabel.text = [NSString stringWithFormat:@"折 扣 券：¥ %@", orderData.discount_amount];
    self.cashCell.textLabel.text = [NSString stringWithFormat:@"实付金额：¥ %.2f", orderData.pay_amount.doubleValue];
}

#pragma mark - getters
- (OrderDetailBaseCell *)totalPriceCell {
    if (!_totalPriceCell) {
        _totalPriceCell = [[OrderDetailBaseCell alloc] init];
    }
    return _totalPriceCell;
}

- (OrderDetailBaseCell *)freightPriceCell {
    if (!_freightPriceCell) {
        _freightPriceCell = [[OrderDetailBaseCell alloc] init];
    }
    return _freightPriceCell;
}

- (OrderDetailBaseCell *)shoulePayPriceCell {
    if (!_shoulePayPriceCell) {
        _shoulePayPriceCell = [[OrderDetailBaseCell alloc] init];
    }
    return _shoulePayPriceCell;
}

- (OrderDetailBaseCell *)discountTicketCell {
    if (!_discountTicketCell) {
        _discountTicketCell = [[OrderDetailBaseCell alloc] init];
    }
    return _discountTicketCell;
}


- (OrderDetailBaseCell *)cashCell {
    if (!_cashCell) {
        _cashCell = [[OrderDetailBaseCell alloc] init];
    }
    return _cashCell;
}

@end
