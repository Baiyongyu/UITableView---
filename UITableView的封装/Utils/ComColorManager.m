//
//  ComColorManager.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import "ComColorManager.h"

@interface ComColorManager ()

@property (nonatomic,strong) NSMutableDictionary*                colorsDict;

@end

@implementation ComColorManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)defaultManager {
    static dispatch_once_t once;
    static ComColorManager * __singleton__;
    dispatch_once( &once, ^{
        __singleton__ = [[ComColorManager alloc] init];
    });
    return __singleton__;
}

- (id)init {
    self = [super init];
    if (self) {
        self.colorsDict = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onRecvMemoryWarning)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)onRecvMemoryWarning {
    [self.colorsDict removeAllObjects];
}

+ (UIColor*)colorWithHexString:(NSString *)hexColor
{
    if (!hexColor) {
        return [UIColor clearColor];
    }
    
    // 先读缓存
    ComColorManager *manager = [ComColorManager defaultManager];
    if (manager.colorsDict[hexColor]) {
        return manager.colorsDict[hexColor];
    }
    if ([manager.colorsDict count]>30) {
        [manager.colorsDict removeAllObjects];
    }
    
    // 缓存没有实际生成
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])  cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    UIColor *color = [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    [manager.colorsDict setObject:color forKey:hexColor];
    
    return color;
}

+ (UIColor*)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    NSString *key = [NSString stringWithFormat:@"%ld%f",(long)hex,alpha];
    ComColorManager *a = [ComColorManager defaultManager];
    if (a.colorsDict[key]) {
        return a.colorsDict[key];
    }
    if ([a.colorsDict count]>30) {
        [a.colorsDict removeAllObjects];
    }
    UIColor *color =  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
    [a.colorsDict setObject:color forKey:key];
    return color;
}

@end
