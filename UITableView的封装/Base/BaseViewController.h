//
//  BaseViewController.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView *contentView;

- (void)leftBtnAction;
- (void)rightBtnAction;
- (void)loadSubViews;
- (void)layoutConstraints;
- (void)loadData;

@end
