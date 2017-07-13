//
//  UIViewController+NavItem.h
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import <UIKit/UIKit.h>

#warning replace your own name
#define BackButtonImageName @"btn_common_back"
#define DefaultColorOfNavigationBar [UIColor whiteColor]
#define DefaultFontOfNavigationBarTitle [UIFont systemFontOfSize:17]
#define DefaultTextColorOfNavigationBarTitle [UIColor blackColor]
#define DefaultTextColorOfNavigationItem [UIColor blackColor]

@interface UIViewController (NavItem)

/**
 *  config back action of UINavigationItem
 *
 *  @param action block
 */
- (void)configNavigationBackAction:(voidBlock)action;
/**
 *  config left UINavigationItem, the object must be NSString or UIImage object
 *
 *  @param object must be NSString or UIImage object
 *  @param action block
 */
- (void)configNavigationLeftItemWith:(id)object andAction:(voidBlock)action;

/**
 *  config right UINavigationItem, the object must be NSString or UIImage object
 *
 *  @param object must be NSString or UIImage object
 *  @param action block
 */
- (void)configNavigationRightItemWith:(id)object andAction:(voidBlock)action;

/**
 *  config left UINavigationItem with text and font
 *
 *  @param text NSString object
 *  @param action block
 */
- (void)configNavigationLeftString:(NSString*)text textFont:(UIFont*)font andAction:(voidBlock)action;


/**
 *  config right UINavigationItem with text and font
 *
 *  @param text NSString object
 *  @param action block
 */
- (void)configNavigationRightString:(NSString*)text textFont:(UIFont*)font andAction:(voidBlock)action;

- (void)configNavigationBarTintColor:(UIColor*)color;

- (void)configNavigationBarTitleAppearance;

- (void)configDefaultNavigationBarStyle;

@end
