//
//  BaseViewController.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/2/23.
//  Copyright © 2016年 北京116工作室. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - life style
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_BG_COMMON;
    [self loadSubViews];
    [self.view bringSubviewToFront:self.navBar];
    [self layoutConstraints];
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadSubViews
{
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navBar];
    [self.navBar addSubview:self.leftBtn];
    [self.navBar addSubview:self.rightBtn];
    self.leftBtn.hidden = (self.navigationController.childViewControllers.count<=1);
    self.rightBtn.hidden = YES;
    [self.navBar addSubview:self.titleLabel];
    [self layoutNavigationBar];
}

- (void)layoutNavigationBar
{
    WS(weakSelf);
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.navBar).offset(0);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.navBar);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right).offset(5);
        make.right.mas_equalTo(weakSelf.rightBtn.mas_left).offset(-5);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.view setNeedsLayout];
}

- (void)layoutConstraints
{
    
}

- (void)loadData
{
    
}

#pragma mark - actions
- (void)leftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction
{
    
}

#pragma mark - getters and setters
- (UIView *)navBar
{
    if (!_navBar) {
        _navBar= [[UIView alloc] init];
        _navBar.backgroundColor = COLOR_NAVBAR_THEME;
    }
    return _navBar;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = FONT(15);
        [_leftBtn setContentMode:UIViewContentModeCenter];
        _leftBtn.imageView.layer.masksToBounds = YES;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"fm_share_20x20_"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = FONT(15);
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_rightBtn setContentMode:UIViewContentModeCenter];
    }
    return _rightBtn;
}

- (UIView *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = COLOR_TEXT_WHITE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.scrollEnabled = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.scrollsToTop = NO;
    }
    return _contentView;
}


@end
