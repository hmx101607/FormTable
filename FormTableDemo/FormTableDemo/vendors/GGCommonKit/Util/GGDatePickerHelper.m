//
//  GGDatePickerHelper.m
//  GGCommonKit
//
//  Created by Ron on 9/26/14.
//  Copyright (c) 2014 HGG. All rights reserved.
//

#import "GGDatePickerHelper.h"

static GGDatePickerHelper *_helper;
static NSDateFormatter *g_dayDateFormatter;

@interface GGDatePickerHelper()

@property (nonatomic, strong) UIDatePicker *pickerView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, assign) NSInteger curRow;
@property (nonatomic, copy) DateBlock selectedDateBlock;
@property (nonatomic, strong) UIToolbar *pickerToobar;

@end

@implementation GGDatePickerHelper

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_dayDateFormatter = [[NSDateFormatter alloc] init];
        _helper = [GGDatePickerHelper new];
        _helper.pickerView = [UIDatePicker new];
        _helper.containView = [UIView new];
        _helper.blackView = [UIView new];
        _helper.pickerToobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    });
}

+ (void)showDatePickerWithMode:(UIDatePickerMode)mode maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate defaultDate:(NSDate *)defaultDate inView:(UIView *)view barTintColor:(UIColor *)barTintColor barButtonItemTintColor:(UIColor *)barButtonItemTintColor selectedClosure:(DateBlock)selectedClosure {
    CGFloat width = CGRectGetWidth(view.frame);
    _helper.containView.frame = CGRectMake(0, 0, width, 206);
    _helper.blackView.frame = view.bounds;
    _helper.blackView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tapOnBlackView = [[UITapGestureRecognizer alloc]initWithTarget:_helper action:@selector(cancelAction:)];
    [_helper.blackView addGestureRecognizer:tapOnBlackView];
    
    _helper.selectedDateBlock = selectedClosure;
    _helper.pickerView.frame = CGRectMake(0, 44, width, 162);
    _helper.pickerView.backgroundColor = [UIColor whiteColor];
    _helper.pickerView.datePickerMode = mode;
    if (defaultDate) {
        _helper.pickerView.date = defaultDate;
    }
    
    if (maxDate) {
        _helper.pickerView.maximumDate = maxDate;
    }
    
    if (minDate) {
        _helper.pickerView.minimumDate = minDate;
    }

    CGRect toolbarFrame = _helper.pickerToobar.frame;
    toolbarFrame.size.width = width;
    _helper.pickerToobar.frame = toolbarFrame;
    
    _helper.pickerToobar.barStyle = UIBarStyleDefault;
    _helper.pickerToobar.tintColor = [UIColor whiteColor];
    _helper.pickerToobar.barTintColor = barTintColor;
    [_helper.pickerToobar sizeToFit];
    
    [_helper.containView addSubview:_helper.pickerToobar];
    [_helper.containView addSubview:_helper.pickerView];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) style:UIBarButtonItemStylePlain target:_helper action:@selector(cancelAction:)];
    if (barButtonItemTintColor) {
        cancelBtn.tintColor = barButtonItemTintColor;
    }
  
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"确定", nil) style:UIBarButtonItemStylePlain target:_helper action:@selector(disMiss:)];
    if (barButtonItemTintColor) {
        doneBtn.tintColor = barButtonItemTintColor;
    }
    
    [_helper.pickerToobar setItems:@[cancelBtn,flexSpace,doneBtn]];
    
    [_helper showInView:view];
}

- (void)showInView:(UIView *)targetView
{
    [targetView addSubview:self.blackView];
    [targetView addSubview:self.containView];
    self.blackView.alpha = 0;
    CGRect containViewFrame = self.containView.frame;
    containViewFrame.origin.y = CGRectGetHeight(targetView.frame);
    self.containView.frame = containViewFrame;
    containViewFrame.origin.y = CGRectGetHeight(targetView.frame) - CGRectGetHeight(self.containView.frame);
    containViewFrame.size.height = 206;

    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.containView.frame = containViewFrame;
        self.blackView.alpha = 0.3;
    } completion:NULL];
}

- (void)dismissWithAniamtion{
    CGRect containViewFrame = self.containView.frame;
    containViewFrame.origin.y = CGRectGetHeight(self.blackView.superview.frame);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.blackView.alpha = 0;
        self.containView.frame = containViewFrame;
    } completion:^(BOOL finished) {
        [self.blackView removeFromSuperview];
        [self.containView removeFromSuperview];
    }];
}

- (void)cancelAction:(id)sender{
    if (self.selectedDateBlock) {
        self.selectedDateBlock(NO, nil);
    }
    [self dismissWithAniamtion];
}

- (void)disMiss:(id)sender{
    if (self.selectedDateBlock) {
        self.selectedDateBlock(YES, self.pickerView.date);
    }
    [self dismissWithAniamtion];
}

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat
{
    return [self stringFromDate:aDate format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    g_dayDateFormatter.dateFormat = dateFormat;
    [g_dayDateFormatter setTimeZone:timeZone];
    [g_dayDateFormatter setLocale:locale];
    NSString *localDateString = [g_dayDateFormatter stringFromDate:aDate];
    return localDateString;
}

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat
{
    return [self dateFromString:dateStr format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    [g_dayDateFormatter setDateFormat:dateFormat];
    [g_dayDateFormatter setTimeZone:timeZone];
    [g_dayDateFormatter setLocale:locale];
    NSDate *date = [g_dayDateFormatter dateFromString:dateStr];
    return date;
}

@end
