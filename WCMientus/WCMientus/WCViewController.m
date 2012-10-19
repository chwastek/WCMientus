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
    
    
    [WCAlertView showAlertWithTitle:@"Custom AlertView Title" message:@"You can do a lot of additional setup using WCAlertView. You can do a lot of additional setup using WCAlertView" customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleVioletHatched;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        
    } cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay",nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
