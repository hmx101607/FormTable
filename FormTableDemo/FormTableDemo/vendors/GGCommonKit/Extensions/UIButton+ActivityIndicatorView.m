//
//  UIButton+ActivityIndicatorView.m
//  mindate
//
//  Created by James on 9/1/14.
//  Copyright (c) 2014 HGG. All rights reserved.
//

#import "UIButton+ActivityIndicatorView.h"
#import <objc/runtime.h>
#import "UIView+Utils.h"

@implementation UIButton (ActivityIndicatorView)

- (void)setIndicatorView:(UIActivityIndicatorView *)indicatorView  {
    objc_setAssociatedObject(self, @selector(indicatorView), indicatorView, OBJC_ASSOCIATION_RETAIN);
}
- (UIActivityIndicatorView *)indicatorView {
    return objc_getAssociatedObject(self, @selector(indicatorView));
}

- (void)setOriginalTitle:(NSString *)originalTitle {
    objc_setAssociatedObject(self, @selector(originalTitle), originalTitle, OBJC_ASSOCIATION_COPY);
}

- (NSString *)originalTitle {
    return objc_getAssociatedObject(self, @selector(originalTitle));
}

- (void)startAnimating {
    self.originalTitle = [self titleForState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateNormal];
    self.indicatorView = [[UIActivityIndicatorView alloc] init];
    [self addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    self.enabled = NO;
    self.indicatorView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

- (void)stopAnimating {
    [self.indicatorView stopAnimating];
    [self setTitle:self.originalTitle forState:UIControlStateNormal];
    self.enabled = YES;
}

@end
