//
//  ViewHelper.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+ (void)initTextCompontUI:(id)textView
{
    [self initTextCompontUI:textView withColor:COLOR_TEXT_DEEP font:FONT_NORMAL];
}

+ (void)initTextCompontUI:(id)textView withFont:(UIFont *)font
{
    [self initTextCompontUI:textView withColor:COLOR_TEXT_DEEP font:font];
}

+ (void)initTextCompontUI:(id)textView withColor:(UIColor *)color
{
    [self initTextCompontUI:textView withColor:color font:FONT_NORMAL];
}

+ (void)initTextCompontUI:(id)textView withColor:(UIColor *)color font:(UIFont *)font
{
    if ([textView isKindOfClass:[UILabel class]]) {
        UILabel *view = (UILabel *)textView;
        view.textColor = color;
        view.font = font;
        view.backgroundColor = COLOR_BG_WHITE;
    }
    else if ([textView isKindOfClass:[UITextView class]]) {
        UITextView *view = (UITextView *)textView;
        view.textColor = color;
        view.font = font;
        view.backgroundColor = COLOR_BG_WHITE;
    }
    else if ([textView isKindOfClass:[UITextField class]]) {
        UITextField *view = (UITextField *)textView;
        view.textColor = color;
        view.font = font;
        view.backgroundColor = COLOR_BG_WHITE;
    }
}

+ (void)initTextCompontUI:(id)textView withView:(id)copyView
{
    UIColor *textColor = COLOR_TEXT_DEEP;
    UIFont *textFont = FONT_NORMAL;
    
    if ([copyView isKindOfClass:[UILabel class]]) {
        UILabel *view = (UILabel *)copyView;
        textColor = view.textColor;
        textFont = view.font;
    }
    else if ([copyView isKindOfClass:[UITextView class]]) {
        UITextView *view = (UITextView *)copyView;
        textColor = view.textColor;
        textFont = view.font;
    }
    else if ([copyView isKindOfClass:[UITextField class]]) {
        UITextField *view = (UITextField *)copyView;
        textColor = view.textColor;
        textFont = view.font;
    }
    [self initTextCompontUI:textView withColor:textColor font:textFont];
}

+ (UIView *)createLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_BG_COMMON;
    return lineView;
}

@end

@implementation ViewSizeHelper

//获取字符串的size
+(CGSize)getSizeWithText:(NSString*)text fontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]}];
    return size;
}

//获取字符串的size
+(CGSize)getSizeWithText:(NSString*)text font:(UIFont*)font
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: font}];
    return size;
}

+(CGSize)getSizeWithText:(NSString*)text boldfontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]}];
    return size;
}

//获取字符窜大小
+(CGSize)sizeWithString:(NSString*) string  font:(UIFont*)font size:(CGSize)size
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize textSize = [string boundingRectWithSize:size
                                           options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return textSize;
}

//获取字符窜大小
+(CGSize)sizeWithString:(NSString*) string  attribute:(NSDictionary*)attribute size:(CGSize)size
{
    CGSize textSize = [string boundingRectWithSize:size
                                           options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return textSize;
}

//获取NSAttributed字符窜大小
+(CGSize)sizeWithString:(NSAttributedString*) attrStr size:(CGSize)size
{
    CGSize textSize = [attrStr boundingRectWithSize:size
                                            options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                            context:nil].size;
    return textSize;
}

+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText font:(UIFont*)font
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize newSize = [strText boundingRectWithSize:constraint
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText attribute:(NSDictionary*)attribute
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    CGSize newSize = [strText boundingRectWithSize:constraint
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

+(float)heightForTextViewSize:(CGSize)size  withAttributeText: (NSAttributedString *) attributeStrText
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(size.width - fPadding, CGFLOAT_MAX);
    CGSize newSize = [attributeStrText boundingRectWithSize:constraint
                                                    options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                    context:nil].size;
    
    newSize.height+=16.0;
    return newSize.height;
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string textRange:(NSInteger)textRange {
    
    NSInteger rangeTeger = textRange;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"¥"];
    [attributedString addAttribute:NSForegroundColorAttributeName value:COLOR_TEXT_DEEP range:NSMakeRange(rangeTeger, range.location + 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:COLOR_NAVBAR_THEME range:NSMakeRange(range.location, string.length - range.location)];
    return attributedString;
}


@end

#define ERROR_VIEW_TAG         201601

@implementation ErrorViewHelper

+ (UILabel *)initErrorViewInView:(UIView *)view {
    [[view viewWithTag:ERROR_VIEW_TAG] removeFromSuperview];
    UILabel *errorView = [[UILabel alloc] initWithFrame:view.bounds];
    errorView.tag = ERROR_VIEW_TAG;
    errorView.textAlignment = NSTextAlignmentCenter;
    errorView.numberOfLines = 0;
    errorView.backgroundColor = [UIColor whiteColor];
    [view addSubview:errorView];
    
    return errorView;
}

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSString*)errorMsg clickBlock:(VoidBlock)block {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"报错啦~~~\n点击重新加载";
    errorView.textColor = [UIColor lightGrayColor];
    NSLog(@"%@",errorMsg);
    
    [errorView handleClick:^(UIView *view) {
        if (block) {
            block();
        }
    }];
    
    return errorView;
}

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSString*)errorMsg {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"报错啦~~~";
    errorView.textColor = [UIColor lightGrayColor];
    NSLog(@"%@",errorMsg);
    
    return errorView;
}

+ (void)removeErrorViewFromView:(UIView*)view  {
    [[view viewWithTag:ERROR_VIEW_TAG] removeFromSuperview];
}

+ (UIView*)showEmptyViewInView:(UIView*)view clickBlock:(VoidBlock)block {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"暂无数据\n点击重新加载";
    errorView.textColor = [UIColor lightGrayColor];
    
    [errorView handleClick:^(UIView *view) {
        if (block) {
            block();
        }
    }];
    
    return errorView;
}

+ (UIView*)showEmptyViewInView:(UIView*)view {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"暂无数据";
    errorView.textColor = [UIColor lightGrayColor];
    
    return errorView;
}

+ (UIView*)showErrorString:(NSString*)string inView:(UIView*)view {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.font = [UIFont systemFontOfSize:18.f];
    errorView.text = string;
    return errorView;
}


@end
