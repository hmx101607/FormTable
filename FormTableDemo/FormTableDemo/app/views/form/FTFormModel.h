//
//  FTFormModel.h
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,  FTFormItemType) {
    FTFormItemTypeText,
    FTFormItemTypeImage
};

@interface FTFormItemModel: NSObject

/** 显示内容 */
@property (strong, nonatomic) NSString *title;
/** 字体颜色 */
@property (strong, nonatomic) UIColor *textColor;
/** 字体大小 （默认12）*/
@property (assign, nonatomic) CGFloat fontSize;
/** 位置：居中，靠左，靠右等（默认居中） */
@property (assign, nonatomic) NSTextAlignment textAlignment;
/** 宽度比率，默认为：1 （假设比率为1，一行总共4个数据，则宽度为 ） 0.25 * SCREEN_WIDTH */
@property (assign, nonatomic) CGFloat widthRate;
/** 背景色 */
@property (strong, nonatomic) UIColor *backgroundColor;
/** 文字或图片 */
@property (assign, nonatomic) FTFormItemType formItemType;

#pragma mark - ################内容的展开################
/** 次级内容 */
@property (strong, nonatomic) NSString *subTitle;
/** 次级字体颜色 */
@property (strong, nonatomic) UIColor *subTextColor;
/** 次级字体大小 （默认12）*/
@property (assign, nonatomic) CGFloat subFontSize;
/** 是否允许点击 */
@property (assign, nonatomic, getter=isAllowTap) BOOL allowTap;

@property (assign, nonatomic, getter=isNextPage) BOOL nextPage;

@end

@interface FTFormModel : NSObject

/** 行高:默认44 */
@property (assign, nonatomic) CGFloat rowHeight;
/** 宽度比率总和 */
@property (assign, nonatomic) CGFloat widthRateTotal;
/** 背景色 */
@property (strong, nonatomic) UIColor *backgroundColor;
/** 边距 */
@property (nonatomic) UIEdgeInsets edgeInsets;
/** 分隔线长度：为0时则达到隐藏分隔线的效果，默认占满整行 */
@property (assign, nonatomic, ) CGFloat separateLineWidth;
/** item数据 */
@property (strong, nonatomic) NSArray <FTFormItemModel *> *formItemArray;
/** 属于第几条数据 */
@property (assign, nonatomic) NSInteger index;

#pragma mark - ################内容的展开################
/** sub宽度比率总和 */
@property (assign, nonatomic) CGFloat subWidthRateTotal;
/** 内边距 */
@property (nonatomic) UIEdgeInsets subEdgeInsets;
/** 子项集合 */
@property (strong, nonatomic) NSArray <FTFormItemModel *> *subItemArray;
/** 选中状态 */
@property (assign, nonatomic, getter=isSelectedStatus) BOOL selectedStatus;

- (CGFloat)subWidthRateTotalWithArray:(NSArray *)rateArray;
@end
