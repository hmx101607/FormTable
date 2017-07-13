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
    self.collectionView.backgroundColor = [UIColor redColor];
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
    itemCell.titleLabel.text = formItemModel.title;
    itemCell.titleLabel.textColor = formItemModel.textColor;
    itemCell.titleLabel.font = [UIFont systemFontOfSize:formItemModel.fontSize];
    itemCell.titleLabel.textAlignment = formItemModel.textAlignment;
    return itemCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //传入比值
    FTFormItemModel *formItemModel = self.formModel.formItemArray[indexPath.row];
    CGFloat margin = 1.f / [UIScreen mainScreen].scale;
    CGFloat total = self.formModel.formItemArray.count;
    return CGSizeMake((self.width - ((total - 0) * margin)) * (formItemModel.widthRate / self.formModel.widthRateTotal), self.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f / [UIScreen mainScreen].scale;
}


@end













