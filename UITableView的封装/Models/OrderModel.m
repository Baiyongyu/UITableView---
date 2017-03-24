//
//  OrderModel.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/28.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [GoodsModel class]};
}

@end


