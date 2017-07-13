//
//  FTFormView.h
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import <UIKit/UIKit.h>
#import "FTFormModel.h"

@interface FTFormView : UIView

/** 表格数据 */
@property (strong, nonatomic) NSArray <FTFormModel *>*formModelArray;

@end
