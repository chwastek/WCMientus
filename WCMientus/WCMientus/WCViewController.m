//
//  WCViewController.m
//  WCMientus
//
//  Created by Michał Zaborowski on 03.09.2012.
//  Copyright (c) 2012 whitecode. All rights reserved.
//

#import "WCViewController.h"
#import "WCAlertView.h"

@interface WCViewController ()

@end

@implementation WCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WCAlertView showAlertWithTitle:@"title" message:@"message" customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleViolet;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        
    } cancelButtonTitle:@"Okej" otherButtonTitles:@"elo",nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
