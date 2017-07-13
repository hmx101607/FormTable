//
//  GGDatePickerHelper.h
//  GGCommonKit
//
//  Created by Ron on 9/26/14.
//  Copyright (c) 2014 HGG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// ---------------------- NSDateFormatter ------------------
#define DATEFORMATTER_RFC3339 @"yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
#define DATEFORMATTER_ISO8601 @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"

typedef void(^DateBlock)(BOOL isComfirm, NSDate *date);

@interface GGDatePickerHelper : NSObject

+ (void)showDatePickerWithMode:(UIDatePickerMode)mode maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate defaultDate:(NSDate *)defaultDate inView:(UIView *)view barTintColor:(UIColor *)barTintColor barButtonItemTintColor:(UIColor *)barButtonItemTintColor selectedClosure:(DateBlock)selectedClosure;

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat;

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat;

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

@end

