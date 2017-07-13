//
//  UITableViewCell+Utils.m
//  GGCommonKit
//
//  Created by Ron on 11/3/15.
//  Copyright (c) 2015 HGG. All rights reserved.
//

#import "UITableViewCell+Utils.h"

@implementation UITableViewCell(Utils)

+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
}

@end
