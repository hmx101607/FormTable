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
}

- (void)setupView {
    [self addSubview:self.titleLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _titleLabel;
}

@end
