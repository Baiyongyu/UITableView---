//
//  GoodsModel.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/25.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
//购物车id
@property(nonatomic,copy)NSString *cart_id;
//商品id
@property(nonatomic,copy)NSString *goods_id;
//图片链接
@property(nonatomic,copy)NSString *img_url;
//价格
@property(nonatomic,copy)NSString *price;
//名字
@property(nonatomic,copy)NSString *name;
//商品数量
@property(nonatomic,copy)NSString *goods_number;
@property(nonatomic,copy)NSString *number;
//库存
@property(nonatomic,copy)NSString *stock;


//评价条数
@property(nonatomic,copy)NSString *comment_count;
//商品详情
@property(nonatomic,copy)NSString *content;
//可否购买，0=不可购买，1=可购买
@property(nonatomic,copy)NSString *is_supplied;
//是否打折，0=不打折，1=打折
@property(nonatomic,copy)NSString *is_discounted;
//折扣，80%
@property(nonatomic,copy)NSString *discount;

@property(nonatomic,copy)NSString *goods_status;

//运费
@property(nonatomic,copy)NSString *postage_price;

//是否选中
@property(nonatomic,assign)NSInteger cellClickState;
- (void)resetAllState:(BOOL)state;

@end
