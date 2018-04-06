//
//  SFGlobal.m
//  SafeChats
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 SafeChats. All rights reserved.
//

#import "SFGlobal.h"


@implementation SFGlobal

+ (id) sharedInstance {
    static SFGlobal *sharedObject = nil;
    if (sharedObject == nil) {
        sharedObject = [[self alloc] init];
        sharedObject.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return sharedObject;
}

#pragma mark - Text utility
+ (BOOL) isValidEmail:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - UI utility
#pragma mark - Screen Size

+ (int)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (int)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)screenSize {
    return [[UIScreen mainScreen] bounds].size;
}

#pragma mark - View Effect

+ (void) setBorderEffect:(UIView *)view {
    [SFGlobal setBorderEffect:view backColor:nil borderColor:nil];
}

+ (void) setBorderEffect:(UIView *)view borderColor:(UIColor *)borderColor {
    [SFGlobal setBorderEffect:view backColor:nil borderColor:borderColor];
}

+ (void) setBorderEffect:(UIView *)view backColor:(UIColor*) backColor borderColor:(UIColor *)borderColor {
    if (backColor != nil) {
        view.backgroundColor = backColor;
    }
    if (borderColor != nil) {
        view.layer.borderColor = [borderColor CGColor];
        view.layer.borderWidth = 1.0;
    }
    view.layer.cornerRadius = 4.0;
}

#pragma mark - Dynamic Font

+ (UIFont*)smallFont:(NSString*) fontName {
    // choose the font size
    CGFloat fontSize = FONTSIZE_SMALL;
    NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
    
    if ([contentSize isEqualToString:UIContentSizeCategoryExtraSmall]) {
        fontSize -= 2;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategorySmall]) {
        fontSize -= 1;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryMedium]) {
        fontSize -= 0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryLarge]) {
        fontSize += 0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraLarge]) {
        fontSize += 1.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
        fontSize += 2.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
        fontSize += 3.0;
    }
    
    return [UIFont fontWithName:fontName size:fontSize];
}

+ (UIFont*)mediumFont:(NSString*) fontName {
    // choose the font size
    CGFloat fontSize = FONTSIZE_MEDIUM;
    NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
    
    if ([contentSize isEqualToString:UIContentSizeCategoryExtraSmall]) {
        fontSize -= 2;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategorySmall]) {
        fontSize -= 1;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryMedium]) {
        fontSize -= 0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryLarge]) {
        fontSize += 1;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraLarge]) {
        fontSize += 2.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
        fontSize += 3.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
        fontSize += 4.0;
    }
    
    return [UIFont fontWithName:fontName size:fontSize];
}

+ (UIFont*)largeFont:(NSString*) fontName {
    // choose the font size
    CGFloat fontSize = FONTSIZE_LARGE;
    NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;
    
    if ([contentSize isEqualToString:UIContentSizeCategoryExtraSmall]) {
        fontSize -= 2;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategorySmall]) {
        fontSize -= 1;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryMedium]) {
        fontSize -= 0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryLarge]) {
        fontSize += 1;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraLarge]) {
        fontSize += 2.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraLarge]) {
        fontSize += 3.0;
        
    } else if ([contentSize isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]) {
        fontSize += 4.0;
    }
    
    return [UIFont fontWithName:fontName size:fontSize];
}

#pragma mark - Animation

- (void) moveFromCenter:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    CGRect frame = view.frame;
    frame.origin.x = ([SFGlobal screenWidth] - frame.size.width) / 2;
    frame.origin.y = ([SFGlobal screenHeight] - frame.size.height) / 2;
    [self moveToCurrent:view from:frame withDuration:duration afterDelay:delay];
}

- (void) moveFromLeftOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    CGRect frame = view.frame;
    frame.origin.x =  -frame.size.width;
    [self moveToCurrent:view from:frame withDuration:duration afterDelay:delay];
}

- (void) moveFromRightOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    CGRect frame = view.frame;
    frame.origin.x =  [SFGlobal screenWidth];
    [self moveToCurrent:view from:frame withDuration:duration afterDelay:delay];
}

- (void) moveToCurrent:(UIView*)view from:(CGRect)frame withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    CGRect toRect = view.frame;
    [view setFrame:frame];
    [view setNeedsLayout];
    NSDictionary* param = [[NSDictionary alloc] initWithObjectsAndKeys:
                           view, @"view",
                           [NSNumber numberWithFloat:duration], @"duration",
                           [NSValue valueWithCGRect:toRect], @"frame",
                           nil];
    [self performSelector:@selector(movingAnimation:) withObject:param afterDelay:delay];
}

- (void)movingAnimation:(NSDictionary*)param {
    UIView* view = [param objectForKey:@"view"];
    NSTimeInterval duration = [[param objectForKey:@"duration"] doubleValue];
    CGRect frame = [[param objectForKey:@"frame"] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        view.frame = frame;
    }];
}

- (void) hideAndShow:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    [view setAlpha:0];
    NSDictionary* param = [[NSDictionary alloc ] initWithObjectsAndKeys:
                           view, @"view",
                           [NSNumber numberWithFloat:duration], @"duration",
                           nil];
    [self performSelector:@selector(appearingAnimation:) withObject:param afterDelay:delay];
}

- (void)appearingAnimation:(NSDictionary*)param {
    UIView* view = [param objectForKey:@"view"];
    NSTimeInterval duration = [[param objectForKey:@"duration"] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [view setAlpha:1.0];
    }];
}

#pragma mark - NSUserDefault

- (void) saveAccountInfo:(NSString*)email password:(NSString*)password {
    [self.userDefaults setObject:email forKey:USER_EMAIL];
    [self.userDefaults setObject:password forKey:USER_PASSWORD];
    [self.userDefaults synchronize];
}

- (void) clearAccountInfo {
    [self.userDefaults removeObjectForKey:USER_EMAIL];
    [self.userDefaults removeObjectForKey:USER_PASSWORD];
    [self.userDefaults synchronize];
}

- (NSDictionary*) loadAccountInfo {
    NSString* email = [self.userDefaults objectForKey:USER_EMAIL];
    NSString* password = [self.userDefaults objectForKey:USER_PASSWORD];
    if (email != nil && password != nil) {
        return [[NSDictionary alloc] initWithObjectsAndKeys:email, USER_EMAIL, password, USER_PASSWORD, nil];
    }
    return nil;
}

@end
