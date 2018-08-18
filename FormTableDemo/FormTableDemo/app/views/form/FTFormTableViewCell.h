//
//  FTFormTableViewCell.h
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import <UIKit/UIKit.h>
#import "FTFormModel.h"

#define kFormTitle @"kFormTitle"
#define kFormIndex @"kFormIndex"
#define kFormItemArray @"kFormItemArray"
#define kClickFormItemNotification @"kClickFormItemNotification"


@interface FTFormTableViewCell : UITableViewCell

/** <##> */
@property (strong, nonatomic) FTFormModel*formModel;

@end
