//
//  ViewController.m
//  TouchID_Demo
//
//  Created by April Lee on 2015/9/21.
//  Copyright © 2015年 april. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenticateButtonTapped:(id)sender
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        // Authenticate user
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Are you the device owner?" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (error)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was a problem verifying your identity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];

                });
                return;
            }
            
            if (success) {
                
                dispatch_async(dispatch_get_main_queue() , ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You are the device owner!" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                    
                    [alert show];
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not the device owner!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                });
            }
        }];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot authenticate using TouchID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

@end
