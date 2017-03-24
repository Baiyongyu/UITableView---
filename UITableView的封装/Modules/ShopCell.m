//
//  ShopCell.m
//  ANT_NH
//
//  Created by KevinCao on 2016/12/23.
//  Copyright © 2016年 qianmo. All rights reserved.
//

#import "ShopCell.h"

@interface ShopCell ()
@property(nonatomic,strong)UILabel *shopTitleLabel;
@property(nonatomic,strong)UIView *titleBottomLine;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UILabel *moreLabel;
@property(nonatomic,strong)UIImageView *shopImageView;
@property(nonatomic,strong)UIButton *butButton;
@property(nonatomic,strong)UIButton *addCartButton;
@property(nonatomic,strong)UIView *bottomSeperator;
@end

@implementation ShopCell

#pragma makr - 因为cell是继承的BaseTableViewCell，所有创建的cell，要写在buildCellView里面

- (void)buildCellView {
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    [self.contentView addSubview:self.shopTitleLabel];
    [self.shopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    
    [self.contentView addSubview:self.titleBottomLine];
    [self.titleBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleBottomLine.mas_right);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(self.line).offset(-5);
    }];
    
    [self.contentView addSubview:self.shopImageView];
    [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
        make.height.mas_equalTo(230);
    }];
    
    [self.contentView addSubview:self.bottomSeperator];
    [self.bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
    
    [self.contentView addSubview:self.butButton];
    [self.butButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopImageView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(80);
        make.bottom.equalTo(self.bottomSeperator).offset(-15);
    }];
    
    [self.contentView addSubview:self.addCartButton];
    [self.addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopImageView.mas_bottom).offset(5);
        make.right.equalTo(self.butButton.mas_left).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(80);
        make.bottom.equalTo(self.bottomSeperator).offset(-15);
    }];
}

#pragma mark - 赋值操作，统一写成这样的模式，跟setModel是一个意思。因为封装的UITableView里面，赋值写的是这个方法。

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *goodsData = (GoodsModel *)item;
    self.goodsData = goodsData;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"标题" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:COLOR_NAVBAR_THEME}];
    NSAttributedString *totalTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", goodsData.name] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:COLOR_TEXT_DEEP}];
    
    [text appendAttributedString:totalTitle];
    self.shopTitleLabel.attributedText = text;
    
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:goodsData.img_url] placeholderImage:IMAGE_PLACEHOLDER];
}

- (void)buyAction {
    if ([self.delegate respondsToSelector:@selector(editGoodsData:editType:)]) {
        [self.delegate editGoodsData:self.goodsData editType:GoodsEditTypeBuy];
    }
}

- (void)addCartAction {
    if ([self.delegate respondsToSelector:@selector(editGoodsData:editType:)]) {
        [self.delegate editGoodsData:self.goodsData editType:GoodsEditTypeAdd];
    }
}

#pragma mark - getters and setters
- (UILabel *)shopTitleLabel {
    if (!_shopTitleLabel) {
        _shopTitleLabel = [[UILabel alloc] init];
        _shopTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        _shopTitleLabel.numberOfLines = 1;
        _shopTitleLabel.textColor = COLOR_TEXT_DARK_GRAY;
    }
    return _shopTitleLabel;
}
- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.text = @"M O R E";
        _moreLabel.font = [UIFont boldSystemFontOfSize:13];
        _moreLabel.textColor = COLOR_NAVBAR_THEME;
    }
    return _moreLabel;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COLOR_BG_COMMON;
    }
    return _line;
}

- (UIView *)titleBottomLine {
    if (!_titleBottomLine) {
        _titleBottomLine = [[UIView alloc] init];
        _titleBottomLine.backgroundColor = COLOR_NAVBAR_THEME;
    }
    return _titleBottomLine;
}

- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.clipsToBounds = YES;
        _shopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _shopImageView;
}

- (UIButton *)butButton {
    if (!_butButton) {
        _butButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_butButton layoutButtonWithEdgeInsetsStyle:AppButtonEdgeInsetsStyleRight imageTitleSpace:0];
        [_butButton setImage:[UIImage imageNamed:@"ic_cart"] forState:UIControlStateNormal];
        [_butButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_butButton setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
        [_butButton.titleLabel setFont:FONT(10)];
        _butButton.backgroundColor = COLOR_BG_ORANGE;
        _butButton.layer.cornerRadius = 15.0f;
        _butButton.clipsToBounds = YES;
        [_butButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _butButton;
}

- (UIButton *)addCartButton {
    if (!_addCartButton) {
        _addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_addCartButton layoutButtonWithEdgeInsetsStyle:AppButtonEdgeInsetsStyleRight imageTitleSpace:0];
        [_addCartButton setImage:[UIImage imageNamed:@"ic_cart"] forState:UIControlStateNormal];
        [_addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addCartButton setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
        [_addCartButton.titleLabel setFont:FONT(10)];
        _addCartButton.backgroundColor = COLOR_BG_ORANGE;
        _addCartButton.layer.cornerRadius = 15.0f;
        _addCartButton.clipsToBounds = YES;
        [_addCartButton addTarget:self action:@selector(addCartAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCartButton;
}

- (UIView *)bottomSeperator {
    if (!_bottomSeperator) {
        _bottomSeperator = [[UIView alloc] init];
        _bottomSeperator.backgroundColor = COLOR_BG_COMMON;
    }
    return _bottomSeperator;
}

@end
