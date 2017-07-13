//
//  UIView+Create.m
//  NissanApp
//
//  Created by Ron on 14-3-22.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import "UIView+Create.h"

@implementation UIView(Create)

+ (id)loadFromNib
{
    NSString *xibName = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject];
    
}

@end
