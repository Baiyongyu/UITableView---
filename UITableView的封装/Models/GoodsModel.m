//
//  GoodsModel.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/25.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self yy_modelInitWithCoder:aDecoder];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cart_id":@"id"};
}

- (void)resetAllState:(BOOL)state {
    self.cellClickState = state;
}

@end
