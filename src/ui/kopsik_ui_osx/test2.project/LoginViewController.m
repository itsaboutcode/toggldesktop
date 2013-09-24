//
//  LoginViewController.m
//  kopsik_ui_osx
//
//  Created by Tambet Masik on 9/24/13.
//  Copyright (c) 2013 Alari. All rights reserved.
//

#import "LoginViewController.h"
#import "kopsik_api.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)clickLoginButton:(id)sender {
  NSString *email, *pass;
  email = [self.email stringValue];
  pass = [self.password stringValue];
  
  char err[KOPSIK_ERR_LEN];
  if (KOPSIK_API_SUCCESS != kopsik_login(err, KOPSIK_ERR_LEN, [email UTF8String], [pass UTF8String])) {
    [self.errorLabel setValue:[NSString stringWithUTF8String:err]];
    [self.errorLabel setHidden:NO];
    NSLog(@"Login failed: %s", err);
  } else {
    NSLog(@"Success");
    [self.errorLabel setHidden:YES];
  }
}
@end