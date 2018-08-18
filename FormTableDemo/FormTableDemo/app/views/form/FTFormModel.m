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
        self.backgroundColor = [UIColor clearColor];
        
        self.subTextColor = [UIColor blackColor];
        self.subFontSize = 15.f;
    }
    return self;
}

@end

@implementation FTFormModel

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.separateLineWidth = SCREEN_WIDTH;
        self.rowHeight = 44.f;
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (CGFloat)widthRateTotal {
    CGFloat rateTotal = 0;
    for (FTFormItemModel *item in self.formItemArray) {
        rateTotal += item.widthRate;
    }
    _widthRateTotal = rateTotal;
    return _widthRateTotal;
}

- (CGFloat)subWidthRateTotalWithArray:(NSArray *)array {
    CGFloat rateTotal = 0;
    for (FTFormItemModel *item in array) {
        rateTotal += item.widthRate;
    }
    _widthRateTotal = rateTotal;
    return _widthRateTotal;
}

@end
