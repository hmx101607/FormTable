//
//  UIStoryboard+Addition.m
//  YouYanChuApp
//
//  Created by Ron on 13-12-31.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "UIStoryboard+Addition.h"

@implementation UIStoryboard(Addition)

+ (UIStoryboard*)fromName:(NSString*)name
{
    return [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
}

@end
