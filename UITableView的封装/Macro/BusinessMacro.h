//
//  BusinessMacro.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#ifndef BusinessMacro_h
#define BusinessMacro_h

//----------------------------------- 订单状态 ------------------------------------
typedef NS_ENUM (NSInteger, OrderStatus){
    OrderStatusWaitingPay           = 0,    //待付款
    OrderStatusWaitingSend,                 //待发货
    OrderStatusWaitingReceiving,            //待收货
    OrderStatusWaitingEvaluate,             //待评价
    OrderStatusDealSuccess,                 //交易成功
    OrderStatusrRefund                      //退款
};

#endif /* BusinessMacro_h */
