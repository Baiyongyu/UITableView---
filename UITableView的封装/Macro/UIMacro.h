//
//  UIMacro.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

//-----------------------------------  设备的宽高  ------------------------------------
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define XNWidth_Scale        [UIScreen mainScreen].bounds.size.width/375.0f

#define XNColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#define NavigationBarHeight 64.0
//-----------------------------------  颜色  ------------------------------------
#define HEXCOLOR(rgbValue)  [ComColorManager colorWithHex:rgbValue alpha:1.f]
#define HEXCOLORA(rgbValue,a) [ComColorManager colorWithHex:rgbValue alpha:a]
#define color(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

//R G B 颜色
#define DWQRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//R G B A 颜色
#define DWQRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

#define COLOR_NAVBAR_THEME          HEXCOLOR(0x6d9fdc)
#define COLOR_TABBAR_THEME          HEXCOLOR(0x32abff)
#define COLOR_THEME                 HEXCOLOR(0x6d9fdc)
#define COLOR_BTN                   HEXCOLOR(0x6d9fdc)
#define COLOR_BTN_red               HEXCOLOR(0xff6769)
#define COLOR_BG_COMMON             HEXCOLOR(0xF2F2F2)
#define COLOR_BG_THEME              HEXCOLOR(0xff520c)
#define COLOR_BG_THEME_DEEP         HEXCOLOR(0x1680ad)
#define COLOR_BG_GRAY               HEXCOLOR(0xe6e6e6)
#define COLOR_BG_WHITE              [UIColor whiteColor]
#define COLOR_BG_COVER              [UIColor colorWithWhite:0 alpha:0.3]
#define COLOR_BG_ORANGE             HEXCOLOR(0xef49333)
#define COLOR_BG_GREEN              HEXCOLOR(0x0F824B)
#define COLOR_BG_BLUE               HEXCOLOR(0xA2B5CD)

#define COLOR_BG_FOOT               HEXCOLOR(0xcee7f5)
#define COLOR_BG_FOOT_TITLE         HEXCOLOR(0x6e9fd9)

#define COLOR_TEXT_THEME            HEXCOLOR(0xff520c)
#define COLOR_TEXT_DEEP             [UIColor blackColor]
#define COLOR_TEXT_DARK_GRAY        HEXCOLOR(0x222222)
#define COLOR_TEXT_LIGHT            [UIColor lightGrayColor]
#define COLOR_TEXT_Little_Light     HEXCOLOR(0x7a7a7a)
#define COLOR_TEXT_WHITE            [UIColor whiteColor]
#define COLOR_TEXT_WHITE_LIGHT      HEXCOLOR(0xe5e5e5)
#define COLOR_TEXT_GRAY_LIGHT       HEXCOLOR(0x999999)
#define COLOR_TEXT_RED              HEXCOLOR(0xff0000)
#define COLOR_TEXT_RED_LIGHT        HEXCOLOR(0xF35227)

//#define COLOR_LINE                  HEXCOLOR(0xD5D5D5)
#define COLOR_LINE                  HEXCOLOR(0x6d9fdc)
#define COLOR_LINE_DEEP             HEXCOLOR(0x999999)

#define COLOR_BORDER                HEXCOLOR(0xe6e6e6)

#define COLOR_TEXT_000000           HEXCOLOR(0x000000)
#define COLOR_TEXT_111111           HEXCOLOR(0x111111)
#define COLOR_TEXT_222222           HEXCOLOR(0x222222)

//***********************手机型号************************//
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

//-----------------------------------  font  ------------------------------------
#define FONT_LARGE      ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:18]:\
                        [UIFont systemFontOfSize:18]
#define FONT_NORMAL     ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:14]:\
                        [UIFont systemFontOfSize:14]
#define FONT_MID        ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:12]:\
                        [UIFont systemFontOfSize:12]
#define FONT_SMALL      ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:10]:\
                        [UIFont systemFontOfSize:12]
#define FONT(a)         ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:a]:\
                        [UIFont systemFontOfSize:a]

//-----------------------------------  margin  ------------------------------------
#define MARGIN_SPACE    10
#define CELL_HEIGHT     44.0

//-----------------------------------  图片  ------------------------------------
#define IMAGE_PLACEHOLDER [UIImage imageNamed:@"ic_default_image"]
#define IMAGE_AVATAR_PLACEHOLDER [UIImage imageNamed:@"placeholder.jpg"]
#define IMAGE_HUD_SUCCESS [UIImage imageNamed:@"ic_hud_success"]

//-----------------------------------  旋转角度  ------------------------------------
#define DegreesToRadians(degrees)             degrees*M_PI/180
#define RadiansToDegrees(radians)             radians*180/M_PI


#endif /* UIMacro_h */
