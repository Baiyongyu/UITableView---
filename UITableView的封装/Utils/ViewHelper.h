//
//  ViewHelper.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewHelper : NSObject

+ (void)initTextCompontUI:(id)textView;
+ (void)initTextCompontUI:(id)textView withColor:(UIColor *)color font:(UIFont *)font;
+ (void)initTextCompontUI:(id)textView withFont:(UIFont *)font;
+ (void)initTextCompontUI:(id)textView withColor:(UIColor *)color;
+ (void)initTextCompontUI:(id)textView withView:(id)copyView;

+ (UIView *)createLineView;

@end

@interface ViewSizeHelper : NSObject

//获取字符窜大小
+(CGSize)getSizeWithText:(NSString*)text fontSize:(int)fontSize;
+(CGSize)getSizeWithText:(NSString*)text font:(UIFont*)font;
+(CGSize)getSizeWithText:(NSString*)text boldfontSize:(int)fontSize;
+(CGSize)sizeWithString:(NSString*) string  font:(UIFont*)font size:(CGSize)size;
+(CGSize)sizeWithString:(NSString*) string  attribute:(NSDictionary*)attribute size:(CGSize)size;
+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText font:(UIFont*)font;
+(float)heightForTextViewSize:(CGSize)size  WithText: (NSString *) strText attribute:(NSDictionary*)attribute;
+(float)heightForTextViewSize:(CGSize)size  withAttributeText: (NSAttributedString *) attributeStrText;
//获取NSAttributed字符窜大小
+(CGSize)sizeWithString:(NSAttributedString*)attrStr size:(CGSize)size;
+ (NSAttributedString *)attributedStringWithString:(NSString *)string textRange:(NSInteger)textRange;
@end

@interface ErrorViewHelper : NSObject

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSString*)errorMsg;

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSString*)errorMsg clickBlock:(VoidBlock)block;

+ (void)removeErrorViewFromView:(UIView*)view;

+ (UIView*)showEmptyViewInView:(UIView*)view;

+ (UIView*)showEmptyViewInView:(UIView*)view clickBlock:(VoidBlock)block;

+ (UIView*)showErrorString:(NSString*)string inView:(UIView*)view;

@end
