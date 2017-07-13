//
//  UILabel+FormattedText.h
//  GGCommonKit
//
//  Created by Ron on 14-3-22.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FormattedText)

- (void)addAttributes:(NSDictionary *)attributes range:(NSRange)range;
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;
- (void)setFont:(UIFont *)font range:(NSRange)range;
- (void)setLineSpace:(CGFloat)space;

- (CGFloat)contentHeight NS_AVAILABLE_IOS(7_0);

@end
