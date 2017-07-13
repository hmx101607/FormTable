//
//  FTFormModel.h
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import <Foundation/Foundation.h>

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
@end

@interface FTFormModel : NSObject

/** 行高 */
@property (assign, nonatomic) CGFloat rowHeight;
/** 宽度比率总和 */
@property (assign, nonatomic) CGFloat widthRateTotal;
/** item数据 */
@property (strong, nonatomic) NSArray <FTFormItemModel *> * formItemArray;

@end
