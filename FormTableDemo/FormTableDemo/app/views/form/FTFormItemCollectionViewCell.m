//
//  FTFormItemCollectionViewCell.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormItemCollectionViewCell.h"

@interface FTFormItemCollectionViewCell ()


@end

@implementation FTFormItemCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.iconImageView.frame = self.bounds;
}

- (void)setupView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImageView];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.hidden = YES;
    }
    return _iconImageView;
}

@end
