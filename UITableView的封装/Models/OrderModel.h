//
//  OrderModel.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/28.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
//订单状态
@property(nonatomic,assign)OrderStatus status;
//id
@property(nonatomic,copy)NSString *order_id;
//编号
@property(nonatomic,copy)NSString *order_no;

//用户id，用于发送消息
@property(nonatomic,copy)NSString *user_id;
//用户手机号
@property(nonatomic,copy)NSString *username;
//昵称
@property(nonatomic,copy)NSString *nickname;


//收货人
@property(nonatomic,copy)NSString *receiver;
//电话
@property(nonatomic,copy)NSString *receiver_phone;
//收货地址
@property(nonatomic,copy)NSString *receiver_address;


//商品数组
@property(nonatomic,strong)NSArray *items;


//订单总金额
@property(nonatomic,copy)NSString *amount;
//商品总数
@property(nonatomic,copy)NSString *goods_count;
//运费
@property(nonatomic,copy)NSString *freight;


//实付金额
@property(nonatomic,copy)NSString *pay_amount;
//支付单号
@property(nonatomic,copy)NSString *pay_no;
//支付类型，1=支付宝，2=微信
@property(nonatomic,copy)NSString *pay_type;
//快递单号
@property(nonatomic,copy)NSString *express_no;
//快递公司
@property(nonatomic,copy)NSString *express_name;
//商品金额，没有减去优惠的价格
@property(nonatomic,copy)NSString *goods_total_amount;
//折扣券
@property(nonatomic,copy)NSString *discount_amount;
//节约水
@property(nonatomic,copy)NSString *save_water;
//是否被删除，0=未删除，1=已删除
@property(nonatomic,copy)NSString *is_deleted;


//下单时间(未确认状态显示下单时间)
@property(nonatomic,copy)NSString *create_time;
//已确认状态显示确认时间
@property(nonatomic,copy)NSString *accept_time;
//付款时间
@property(nonatomic,copy)NSString *payment_time;
//成交时间
@property(nonatomic,copy)NSString *done_time;
//发货时间
@property(nonatomic,copy)NSString *send_time;

//提成
@property(nonatomic,copy)NSString *bonus;

@end


