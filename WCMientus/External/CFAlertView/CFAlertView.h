//
//  CFAlertView.h
//  CFAlertView
//
//  Created by Michał Zaborowski on 18/07/12.
//  Copyright (c) 2012 Codeflex limited. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CFAlertView : UIAlertView

typedef NS_ENUM(NSInteger, CFAlertViewType)
{
    CFAlertViewTypeDefault = 0,
    CFAlertViewTypeWhite,
    CFAlertViewTypeWhiteHatched,
    CFAlertViewTypeBlack,
    CFAlertViewTypeBlackHatched,
};

// PREDEFINED ALERT COLORS
@property (nonatomic,assign) CFAlertViewType alertType;

// LABEL CUSTOMIZATION
@property (nonatomic,strong) UIColor *labelTextColor;
@property (nonatomic,strong) UIColor *labelShadowColor;
@property (nonatomic,assign) CGSize   labelShadowOffset;

// BUTTONS CUSTOMIZATION
@property (nonatomic,strong) UIColor *buttonTextColor;
@property (nonatomic,strong) UIColor *buttonShadowColor;
@property (nonatomic,assign) CGSize   buttonShadowOffset;

// ALERT BACKGROUND GRADIENT COLORS AND LOCATIONS
@property (nonatomic,strong) NSArray *gradientLocations;
@property (nonatomic,strong) NSArray *gradientColors;

// INNER FRAME SHADOW (OPTIONAL)
@property (nonatomic,strong) UIColor *innerFrameShadowColor;
@property (nonatomic,strong) UIColor *innerFrameStrokeColor;

// HATCHED LINES (OPTIONAL)
@property (nonatomic,strong) UIColor *verticalLineColor;

@property (nonatomic,strong) UIColor *hatchedLinesColor;
@property (nonatomic,strong) UIColor *hatchedBackgroundColor;

// OUTHER FRAME COLOR
@property (nonatomic,strong) UIColor *outerFrameColor;

/* 
 [CFAlertView alertWithTitle:@"Title" message:@"message" customizationBlock:^(CFAlertView *alertView)
 {
    alertView.alertType = CFAlertViewTypeWhite;
    alertView.buttonTextColor = [UIColor blackColor];
 
 } completionBlock:^(NSUInteger buttonIndex, CFAlertView *alertView) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Not doing it");
                break;
            case 1:
                NSLog(@"I'm doing it!");
                break;
            break;
        }
 } cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
 */

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message customizationBlock:(void (^)(CFAlertView *alertView))customization completionBlock:(void (^)(NSUInteger buttonIndex, CFAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;



@end
