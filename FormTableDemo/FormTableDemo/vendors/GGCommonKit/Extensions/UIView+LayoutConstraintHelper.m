//
//  UIView+LayoutConstraintHelper.m
//  jiibao2
//
//  Created by Ron on 9/5/14.
//  Copyright (c) 2014 HGG. All rights reserved.
//

#import "UIView+LayoutConstraintHelper.h"

@implementation UIView (LayoutConstraintHelper)

- (NSLayoutConstraint*)widthConstraint
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual && constraint.priority == UILayoutPriorityRequired) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)heightConstraint
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual && constraint.priority == UILayoutPriorityRequired) {
            return constraint;
        }
    }
    return nil;
}

@end
