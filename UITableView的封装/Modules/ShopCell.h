//
//  ShopCell.h
//  ANT_NH
//
//  Created by KevinCao on 2016/12/23.
//  Copyright © 2016年 qianmo. All rights reserved.
//

typedef NS_ENUM(NSInteger, GoodsEditType) {
    GoodsEditTypeAdd,           //加入购物车
    GoodsEditTypeBuy            //立即购买
};

#import "BaseTableViewCell.h"

@protocol GoodsEditeDelegate <NSObject>
/**
 *  点击商品操作
 *
 *  @param goodsData  商品信息
 *  @param editType   商品操作类型
 */
- (void)editGoodsData:(GoodsModel *)goodsData editType:(GoodsEditType)editType;
@end

@interface ShopCell : BaseTableViewCell
@property(nonatomic,strong)GoodsModel *goodsData;
@property(nonatomic,weak)id<GoodsEditeDelegate>delegate;
@end
