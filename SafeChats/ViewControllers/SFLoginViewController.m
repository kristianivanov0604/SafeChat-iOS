//
//  SFLoginViewController.m
//  SafeChats
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 SafeChats. All rights reserved.
//

#import "SFLoginViewController.h"
#import "SFGlobal.h"
#import "JSWaiter.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface SFLoginViewController ()

@end

@implementation SFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register observer for screen orientation changed notification.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
    // Register observer for default text size changed notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTextSizeDidChange)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    [self initCtrls];
    [self performSelector:@selector(animateCtrls) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCtrls {
    [self.scrollView contentSizeToFit];
    [SFGlobal setBorderEffect:self.emailView];
    [SFGlobal setBorderEffect:self.passwordView];
    [SFGlobal setBorderEffect:self.btnLogIn];
    
    [self.txtEmail setDelegate:self];
    [self.clearEmail setHidden:YES];
    [self.invalidEmail setHidden:YES];
    
    [self.txtPassword setDelegate:self];
    [self.clearPassword setHidden:YES];
    [self.invalidPassword setHidden:YES];
    [self updateFontSize];
    
    NSDictionary* account = [[SFGlobal sharedInstance] loadAccountInfo];
    if (account != nil) {
        [self.txtEmail setText:[account objectForKey:USER_EMAIL]];
        [self.txtPassword setText:[account objectForKey:USER_PASSWORD]];
    }
    [self updateButtonStatus];
}

- (void)updateFontSize {
    UIFont* smallFont = [SFGlobal smallFont:@"HelveticaNeue"];
    UIFont* mediumFont = [SFGlobal mediumFont:@"HelveticaNeue"];
    UIFont* largeFont = [SFGlobal largeFont:@"HelveticaNeue-Bold"];
    
    [self.invalidEmail setFont:smallFont];
    [self.invalidPassword setFont:smallFont];

    [self.txtEmail setFont:mediumFont];
    [self.txtPassword setFont:mediumFont];
    [self.lblSavePass setFont:mediumFont];
    [self.btnContactUs.titleLabel setFont:mediumFont];
    
    [self.btnLogIn.titleLabel setFont:largeFont];
    [self.btnSignUp.titleLabel setFont:largeFont];
}

- (void)animateCtrls {
    NSTimeInterval startDealay = 0.5;
    NSTimeInterval moveDuration = 0.6;
    NSTimeInterval showDuration = 0.5;
    NSTimeInterval showInterval = 0.4;
    [[SFGlobal sharedInstance] moveFromCenter:self.imgLogo withDuration:moveDuration
                                   afterDelay:startDealay];
    
    [[SFGlobal sharedInstance] hideAndShow:self.emailView withDuration:showDuration
                                afterDelay:startDealay + moveDuration];
    
    [[SFGlobal sharedInstance] hideAndShow:self.passwordView withDuration:showDuration
                                afterDelay:startDealay + moveDuration + showInterval];
    
    [[SFGlobal sharedInstance] hideAndShow:self.btnLogIn withDuration:showDuration
                                afterDelay:startDealay + moveDuration + showInterval * 2];
    
    [[SFGlobal sharedInstance] hideAndShow:self.switchView withDuration:showDuration
                                afterDelay:startDealay + moveDuration + showInterval * 3];
    
    [[SFGlobal sharedInstance] moveFromLeftOutSide:self.btnContactUs withDuration:moveDuration
                                        afterDelay:startDealay + moveDuration + showInterval * 4];
    
    [[SFGlobal sharedInstance] moveFromRightOutSide:self.btnSignUp withDuration:moveDuration
                                         afterDelay:startDealay + moveDuration + showInterval * 4];
}

- (void)updateButtonStatus {
    if (self.txtEmail.text.length > 0 && self.txtPassword.text.length > 0) {
        [self.btnLogIn setEnabled:YES];
        [self.btnSignUp setEnabled:NO];
    } else {
        [self.btnLogIn setEnabled:NO];
        [self.btnSignUp setEnabled:YES];
    }
}

- (void)updateBorderEffect:(UITextField*) textField selected:(BOOL)selected{
    UIView* view = (textField == self.txtEmail)? self.emailView: self.passwordView;
    if (selected) {
        [SFGlobal setBorderEffect:view borderColor:[UIColor blackColor]];
    } else {
        [SFGlobal setBorderEffect:view borderColor:view.backgroundColor];
    }
}

- (void)performLogIn {
    DDLogDebug(@"Logging in with");
    DDLogDebug(@"SafeChats# %@", self.txtEmail.text);
    DDLogDebug(@"Password# %@", self.txtPassword.text);

    [self.btnLogIn setEnabled:NO];
    [self.btnLogIn setTitle:NSLocalizedString(@"Logging In", nil) forState:UIControlStateNormal];
    [JSWaiter ShowWaiter:self.view title:[NSString stringWithFormat:@"%@...", NSLocalizedString(@"Logging In", nil)] type:0];
    [self performSelector:@selector(didLogIn) withObject:nil afterDelay:3.0];
}

- (void)didLogIn {
    [self.btnLogIn setEnabled:YES];
    [self.btnLogIn setTitle:NSLocalizedString(@"Log In", nil) forState:UIControlStateNormal];
    [JSWaiter HideWaiter];
    BOOL success = arc4random()%2 == 0;
    if (success) {
        // Login Success
        DDLogDebug(@"Login Success");
        
        if (self.savePassword.on) {
            [[SFGlobal sharedInstance] saveAccountInfo:self.txtEmail.text password:self.txtPassword.text];
        } else {
            [[SFGlobal sharedInstance] clearAccountInfo];
        }
    } else {
        // Login Fail
        DDLogDebug(@"Login Failed");
        [self.clearEmail setHidden:NO];
        [self.invalidEmail setHidden:NO];
        
        [self.clearPassword setHidden:NO];
        [self.invalidPassword setHidden:NO];
    }
}

#pragma mark - NotificationManagement

- (void) orientationChanged:(NSNotification*) note {
    DDLogInfo(@"Screen orientation changed");
    CGFloat height = ([SFGlobal screenHeight] > [SFGlobal screenWidth])? [SFGlobal screenHeight]: [SFGlobal screenWidth];
    CGRect frame = self.contentView.frame;
    frame.size.height = height;
    self.contentView.frame = frame;
}

- (void) userTextSizeDidChange {
    DDLogInfo(@"Text size setting changed");
    [self updateFontSize];
}

#pragma mark - IBActions

- (IBAction)onClearEmail:(id)sender {
    DDLogInfo(@"SafeChats# field cleared");
    [self.txtEmail setText:@""];
    [self.clearEmail setHidden:YES];
    [self.invalidEmail setHidden:YES];
    [self updateButtonStatus];
}

- (IBAction)onClearPassword:(id)sender {
    DDLogInfo(@"Password# field cleared");
    [self.txtPassword setText:@""];
    [self.clearPassword setHidden:YES];
    [self.invalidPassword setHidden:YES];
    [self updateButtonStatus];
}

- (IBAction)onTouchDownLogIn:(id)sender {
    self.btnLogIn.alpha = 0.8;
}

- (IBAction)onLogIn:(id)sender {
    DDLogInfo(@"Login button pressed");
    self.btnLogIn.alpha = 1.0;
    
    if (self.txtEmail.text.length > 0 && self.txtPassword.text.length > 0) {
        [self.clearEmail setHidden:YES];
        [self.invalidEmail setHidden:YES];
        [self.clearPassword setHidden:YES];
        [self.invalidPassword setHidden:YES];

        [self performLogIn];
    } else {
        DDLogError(@"Invalid Email or Password");
    }
}

- (IBAction)onSavePswdStatusChanged:(id)sender {
    DDLogInfo(@"Save password status turned %@", (self.savePassword.on)? @"on": @"off");
}

- (IBAction)onContactUs:(id)sender {
    DDLogInfo(@"Contact us button pressed");
}

- (IBAction)onSignUp:(id)sender {
    DDLogInfo(@"Create your account button pressed");
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateButtonStatus];
    [self updateBorderEffect:textField selected:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtEmail) {
        [textField endEditing:YES];
        [self.txtPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self updateButtonStatus];
    [self updateBorderEffect:textField selected:NO];
    return YES;
}

@end
