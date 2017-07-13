//
//  FTFormModel.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormModel.h"

@implementation FTFormItemModel

- (instancetype)init {
    if (self = [super init]) {
        self.textColor = [UIColor blackColor];
        self.fontSize = 15.f;
        self.textAlignment = NSTextAlignmentCenter;
        self.widthRate = 1;
    }
    return self;
}

@end

@implementation FTFormModel

- (CGFloat)widthRateTotal {
    CGFloat rateTotal = 0;
    for (FTFormItemModel *item in self.formItemArray) {
        rateTotal += item.widthRate;
    }
    _widthRateTotal = rateTotal;
    return _widthRateTotal;
}

@end
