//
//  SFGlobal.h
//  SafeChats
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 SafeChats. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>





@interface SFGlobal : NSObject

+(id) sharedInstance;
@property (nonatomic, strong) NSUserDefaults *userDefaults;

#pragma mark - Text utility
#define NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
+ (BOOL) isValidEmail:(NSString*)email;

#pragma mark - UI utility

#define UIColorFromRGBA(rgbValue, alphaValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:alphaValue])
#define UIColorFromRGB(rgbValue) (UIColorFromRGBA((rgbValue), 1.0))

#pragma mark - Screen Size
+ (int)  screenWidth;
+ (int)  screenHeight;
+ (CGSize)screenSize;

#pragma mark - View Effect
+ (void) setBorderEffect:(UIView *)view;
+ (void) setBorderEffect:(UIView *)view borderColor:(UIColor *)borderColor;
+ (void) setBorderEffect:(UIView *)view backColor:(UIColor*) backColor borderColor:(UIColor *)borderColor;

#pragma mark - Dynamic Font
#define FONTSIZE_SMALL  12
#define FONTSIZE_MEDIUM 15
#define FONTSIZE_LARGE  17
+ (UIFont*) smallFont:(NSString*) fontName;
+ (UIFont*) mediumFont:(NSString*) fontName;
+ (UIFont*) largeFont:(NSString*) fontName;

#pragma mark - Animation
- (void) moveFromCenter:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveFromLeftOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveFromRightOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveToCurrent:(UIView*)view from:(CGRect)frame withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) hideAndShow:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;

#pragma mark - NSUserDefault
#define USER_EMAIL      @"USER_EMAIL"
#define USER_PASSWORD   @"USER_PASSWORD"
- (void) saveAccountInfo:(NSString*)email password:(NSString*)password;
- (void) clearAccountInfo;
- (NSDictionary*) loadAccountInfo;

@end
