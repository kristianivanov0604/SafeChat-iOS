//
//  SFLoginViewController.h
//  SafeChats
//
//  Created by Admin on 8/9/15.
//  Copyright (c) 2015 SafeChats. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface SFLoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView*        contentView;

@property (weak, nonatomic) IBOutlet UIImageView*   imgLogo;
@property (weak, nonatomic) IBOutlet UIView*        emailView;
@property (weak, nonatomic) IBOutlet UITextField*   txtEmail;
@property (weak, nonatomic) IBOutlet UIButton*      clearEmail;
@property (weak, nonatomic) IBOutlet UILabel*       invalidEmail;

@property (weak, nonatomic) IBOutlet UIView*        passwordView;
@property (weak, nonatomic) IBOutlet UITextField*   txtPassword;
@property (weak, nonatomic) IBOutlet UIButton*      clearPassword;
@property (weak, nonatomic) IBOutlet UILabel*       invalidPassword;

@property (weak, nonatomic) IBOutlet UIButton*      btnLogIn;
@property (weak, nonatomic) IBOutlet UIView*        switchView;
@property (weak, nonatomic) IBOutlet UILabel*       lblSavePass;
@property (weak, nonatomic) IBOutlet UISwitch*      savePassword;
@property (weak, nonatomic) IBOutlet UIButton*      btnContactUs;
@property (weak, nonatomic) IBOutlet UIButton*      btnSignUp;

- (IBAction)onClearEmail:(id)sender;
- (IBAction)onClearPassword:(id)sender;

- (IBAction)onTouchDownLogIn:(id)sender;
- (IBAction)onLogIn:(id)sender;
- (IBAction)onSavePswdStatusChanged:(id)sender;
- (IBAction)onContactUs:(id)sender;
- (IBAction)onSignUp:(id)sender;



@end

