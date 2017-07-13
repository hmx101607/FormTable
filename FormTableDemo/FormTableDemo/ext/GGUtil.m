//
//  GGUtil.m
//  VisibleTools
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

@implementation NSString(GGUtil)

-(NSString *) ebg13String{

    const char *_string = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger stringLength = [self length];
    char newString[stringLength+1];

    int x;
    for( x=0; x<stringLength; x++ )
    {
        unsigned int aCharacter = _string[x];

        if( 0x40 < aCharacter && aCharacter < 0x5B ) // A - Z
            newString[x] = (((aCharacter - 0x41) + 0x0D) % 0x1A) + 0x41;
        else if( 0x60 < aCharacter && aCharacter < 0x7B ) // a-z
            newString[x] = (((aCharacter - 0x61) + 0x0D) % 0x1A) + 0x61;
        else  // Not an alpha character
            newString[x] = aCharacter;
    }

    newString[x] = '\0';

    NSString *ebgString = [NSString stringWithCString:newString encoding:NSASCIIStringEncoding];
    return( ebgString );

}

+ (NSString *) infoByKey:(NSString *)key NeedEbg:(BOOL)need{
    NSString *infoOriginString = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    if (need) {
        infoOriginString = [infoOriginString ebg13String];
    }
    return infoOriginString;
}

@end


#import "GGUtil.h"
#import <objc/runtime.h>
@import MessageUI;
@import SystemConfiguration;
@import Darwin;

static NSDateFormatter *g_dayDateFormatter;

@implementation GGUtil

+ (void)load
{
    g_dayDateFormatter = [[NSDateFormatter alloc] init];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
#pragma mark Image
+ (UIImage *)makeAShotWithView:(UIView*)aView
{
    const CGFloat *designValues = CGColorGetComponents(aView.backgroundColor.CGColor);
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, designValues[3] == 1, [UIScreen mainScreen].scale);
    if ([aView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [aView drawViewHierarchyInRect:aView.bounds afterScreenUpdates:YES];
    } else {
        [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width=originSize.width;
    CGFloat height=originSize.height;

    CGFloat wSize=width/maxSize.width;
    CGFloat hSize=height/maxSize.height;

    CGFloat currSize= wSize > hSize ? wSize : hSize;

    CGFloat finelWidth=width/currSize;
    CGFloat finelHeight=height/currSize;

    return CGSizeMake(finelWidth, finelHeight);
}

#pragma mark -
#pragma mark Color
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark -
#pragma mark System Check
+ (BOOL)canSendSMS{
    BOOL canSMS=NO;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            canSMS=YES;
        } else {
            [GGUtil showAlert:NSLocalizedString(@"Device can not use SMS.",@"")
                      title:NSLocalizedString(@"Warning",@"")];
        }
    }
    return canSMS;

}

+ (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags) {
        return NO;
    }

    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


#pragma mark -
#pragma mark Alert
+ (void) showAlert: (NSString *) theMessage title:(NSString *) theTitle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:STRING_OR_EMPTY(theTitle) message:STRING_OR_EMPTY(theMessage) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"okay", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIViewController *rootController =(UIViewController*)[[(AppDelegate *)
                                                           [[UIApplication sharedApplication] delegate] window] rootViewController];
    [alertController addAction:cancelAction];
    [rootController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark String
+ (BOOL)stringIsEmpty:(NSString *) aString {

    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }

    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }

    return NO;
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {

    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }

    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    }

    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }

    return NO;
}



#pragma mark -
#pragma mark Text

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length{
    NSString* returnString=string;
    if([string length]>length) {
        returnString=[NSString stringWithFormat:@"%@...",[string substringToIndex:length-3]];
    }
    return returnString;
}



+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    if (mobile.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom      * 130,131,132,155,156,185,186,145,176,1709
     */

    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    NSInteger len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark -
#pragma mark Memory
+ (void)simulateMemoryWarning
{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                         (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
#endif
}





@end
