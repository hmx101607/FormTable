//
//  FTFormTableViewCell.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormTableViewCell.h"
#import "FTFormItemCollectionViewCell.h"

@interface FTFormTableViewCell()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation FTFormTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setFormModel:(FTFormModel *)formModel {
    _formModel = formModel;
    self.collectionView.backgroundColor = formModel.backgroundColor;
    self.collectionView.contentInset = formModel.edgeInsets;
    [self.collectionView reloadData];
}

- (void)setupView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[FTFormItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FTFormItemCollectionViewCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.formModel.formItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FTFormItemCollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FTFormItemCollectionViewCell class]) forIndexPath:indexPath];
    FTFormItemModel *formItemModel = self.formModel.formItemArray[indexPath.row];
    if (formItemModel.formItemType == FTFormItemTypeText) {
        itemCell.iconImageView.hidden = YES;
        itemCell.titleLabel.hidden = NO;
        itemCell.titleLabel.text = formItemModel.title;
        itemCell.titleLabel.textColor = formItemModel.textColor;
        itemCell.titleLabel.font = [UIFont systemFontOfSize:formItemModel.fontSize];
        itemCell.titleLabel.textAlignment = formItemModel.textAlignment;
        itemCell.titleLabel.numberOfLines = 0;
    } else {
        itemCell.iconImageView.image = [UIImage imageNamed:formItemModel.title];
        itemCell.iconImageView.hidden = NO;
        itemCell.titleLabel.hidden = YES;
    }
    
    itemCell.backgroundColor = formItemModel.backgroundColor;
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.formModel.index != 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kClickFormItemNotification object:nil userInfo:@{kFormIndex : @(self.formModel.index), kFormItemArray : self.formModel.formItemArray}];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //传入比值
    FTFormItemModel *formItemModel = self.formModel.formItemArray[indexPath.row];
    CGFloat padding = 0;
    CGFloat margin = self.formModel.edgeInsets.left - self.formModel.edgeInsets.right;
    CGFloat total = self.formModel.formItemArray.count;
    return CGSizeMake((self.width - ((total - 0) * padding) - margin) * (formItemModel.widthRate / self.formModel.widthRateTotal), self.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 1.f / [UIScreen mainScreen].scale;
    return 0;
}


@end













