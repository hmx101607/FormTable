//
//  GGUtil.h
//  VisibleTools
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

@interface NSString (GGUtil)

-(NSString *) ebg13String;

+ (NSString *) infoByKey:(NSString *)key NeedEbg:(BOOL)need;

@end

@interface GGUtil : NSObject

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize;

+ (UIImage *)makeAShotWithView:(UIView*)aView;

+ (UIColor *)randomColor;

+ (void)showAlert: (NSString *) theMessage title:(NSString *) theTitle;

+ (BOOL)canSendSMS;

+ (BOOL)checkNetworkConnection;

+ (void)simulateMemoryWarning;

+ (BOOL)stringIsEmpty:(NSString *) aString;

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length;

+(BOOL)isValidateEmail:(NSString *)email;

+(BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isValidZipcode:(NSString*)value;

@end
