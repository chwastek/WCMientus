//
//  CFAlertView.m
//  CFAlertView
//
//  Created by Michał Zaborowski on 18/07/12.
//  Copyright (c) 2012 Codeflex limited. All rights reserved.
//

#import "CFAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface CFAlertView () <UIAlertViewDelegate>

@end

@implementation CFAlertView
@synthesize buttonShadowColor = _buttonShadowColor;
@synthesize buttonShadowOffset = _buttonShadowOffset;
@synthesize buttonTextColor = _buttonTextColor;
@synthesize verticalLineColor = _verticalLineColor;
@synthesize innerFrameShadowColor = _innerFrameShadowColor;
@synthesize hatchedLinesColor = _hatchedLinesColor;
@synthesize outerFrameColor = _outerFrameColor;
@synthesize hatchedBackgroundColor = _hatchedBackgroundColor;
@synthesize alertType = _alertType;


+ (id)alertWithTitle:(NSString *)title message:(NSString *)message customizationBlock:(void (^)(CFAlertView *alertView))customization completionBlock:(void (^)(NSUInteger buttonIndex, CFAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{

    CFAlertView *alertView = [[self alloc] initWithTitle:title message:message completionBlock:block cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (otherButtonTitles != nil) {
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [alertView addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [alertView addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    
    if (customization) {
        customization(alertView);
    }
    
    [alertView show];
    
    return alertView;
    
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]) {
        
        self.alertType = CFAlertViewTypeWhite;
        
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *anOtherButtonTitle = otherButtonTitles; anOtherButtonTitle != nil; anOtherButtonTitle = va_arg(args, NSString*)) {
            [self addButtonWithTitle:anOtherButtonTitle];
        }
    }
    return self;
}


- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex, CFAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]) {
        
        self.alertType = CFAlertViewTypeDefault;
		
		if (cancelButtonTitle) {
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = [self numberOfButtons] - 1;
		}
		
		id eachObject;
		va_list argumentList;
		if (otherButtonTitles) {
			[self addButtonWithTitle:otherButtonTitles];
			va_start(argumentList, otherButtonTitles);
			while ((eachObject = va_arg(argumentList, id))) {
				[self addButtonWithTitle:eachObject];
			}
			va_end(argumentList);
		}
	}
	return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(buttonIndex, self);
    }
	
}

- (void)setAlertType:(CFAlertViewType)alertType
{
    if (alertType != _alertType) {
        _alertType = alertType;
        [self customizeWithAlertType:_alertType];
    }
}

- (void)customizeWithAlertType:(CFAlertViewType)type
{
    switch (type) {
        case CFAlertViewTypeDefault:
            break;
        case CFAlertViewTypeWhite:
            [self whiteAlertHatched:NO];
            break;
        case CFAlertViewTypeWhiteHatched:
            [self whiteAlertHatched:NO];
            break;
        case CFAlertViewTypeBlack:
            [self blackAlertHatched:NO];
            break;
        case CFAlertViewTypeBlackHatched:
            [self blackAlertHatched:YES];
            break;
        default:
            self.alertType = CFAlertViewTypeDefault;
            break;
    }
}

- (void)whiteAlertHatched:(BOOL)hatched
{
    self.labelTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
    self.labelShadowColor = [UIColor whiteColor];
    self.labelShadowOffset = CGSizeMake(0.0f, 1.0f);
    
    self.gradientLocations = @[ @0.0f, @0.57f, @1.0f ];
    
    UIColor *topGradient = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    UIColor *middleGradient = [UIColor colorWithRed:0.93f green:0.94f blue:0.96f alpha:1.0f];
    UIColor *bottomGradient = [UIColor colorWithRed:0.89f green:0.89f blue:0.92f alpha:1.00f];
    
    self.gradientColors = @[topGradient,middleGradient,bottomGradient];
    self.outerFrameColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    
    self.buttonTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
    self.buttonShadowColor = [UIColor whiteColor];
    
    if (hatched) {
        self.verticalLineColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        self.hatchedLinesColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    }
}

- (void)blackAlertHatched:(BOOL)hatched
{
    self.labelTextColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    self.labelShadowColor = [UIColor blackColor];
    self.labelShadowOffset = CGSizeMake(0.0f, 1.0f);
    
    self.gradientLocations = @[ @0.0f, @0.57f, @1.0f ];
    
    UIColor *topGradient = [UIColor colorWithRed:0.27f green:0.27f blue:0.27f alpha:1.0f];
    UIColor *middleGradient = [UIColor colorWithRed:0.21f green:0.21f blue:0.21f alpha:1.0f];
    UIColor *bottomGradient = [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:1.00f];
    
    self.gradientColors = @[topGradient,middleGradient,bottomGradient];
    
    self.outerFrameColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    
    self.buttonTextColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
    self.buttonShadowColor = [UIColor blackColor];
    self.buttonShadowOffset = CGSizeMake(0.5, 0.5);
    
    if (hatched) {
        self.verticalLineColor = [UIColor blackColor];
        self.innerFrameShadowColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
        self.innerFrameShadowColor = [UIColor blackColor];
        self.hatchedLinesColor = [UIColor blackColor];
    }
    
}

#pragma mark -
#pragma mark UIView Overrides
- (void)layoutSubviews
{
    if (self.alertType) {
        for (UIView *subview in self.subviews){ //Fast Enumeration
            //		NSLog(@"subview class :%@",[subview class]); //Get Class Description of Each Subview
            
            
            if ([subview isMemberOfClass:[UIImageView class]]) { //Find UIImageView Containing Blue Background
                subview.hidden = YES; //Hide UIImageView Containing Blue Background
                // [subview removeFromSuperview]; Also Works
            }
            
            if ([subview isMemberOfClass:[UILabel class]]) { //Point to UILabels To Change Text
                UILabel *label = (UILabel*)subview;	//Cast From UIView to UILabel
                label.textColor = self.labelTextColor;
                label.shadowColor = self.labelShadowColor;
                label.shadowOffset = self.labelShadowOffset;
            }
            
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                button.titleLabel.alpha = 0;
            }
        }
    }
    
}

- (void)drawRect:(CGRect)rect 
{
    if (self.alertType) {
        //////////////GET REFERENCE TO CURRENT GRAPHICS CONTEXT
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //////////////CREATE BASE SHAPE WITH ROUNDED CORNERS FROM BOUNDS
        CGRect activeBounds = self.bounds;
        CGFloat cornerRadius = 10.0f;
        CGFloat inset = 6.5f;
        CGFloat originX = activeBounds.origin.x + inset;
        CGFloat originY = activeBounds.origin.y + inset;
        CGFloat width = activeBounds.size.width - (inset*2.0f);
        CGFloat height = activeBounds.size.height - (inset*2.0f);
        
        CGRect bPathFrame = CGRectMake(originX, originY, width, height);
        CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
        
        //////////////CREATE BASE SHAPE WITH FILL AND SHADOW
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
        CGContextDrawPath(context, kCGPathFill);
        
        //////////////CLIP STATE
        CGContextSaveGState(context); //Save Context State Before Clipping To "path"
        CGContextAddPath(context, path);
        CGContextClip(context);
        
        //////////////DRAW GRADIENT
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        size_t count = [self.gradientLocations count];
        
        CGFloat *locations = malloc(count * sizeof(CGFloat));
        [self.gradientLocations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            locations[idx] = [((NSNumber *)obj) floatValue];
        }];
        
        
        CGFloat *components = malloc([self.gradientColors count] * 4 * sizeof(CGFloat));
        [self.gradientColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIColor *color = (UIColor *)obj;
            
            NSInteger startIndex = (idx * 4);
            
            [color getRed:&components[startIndex]
                    green:&components[startIndex+1]
                     blue:&components[startIndex+2]
                    alpha:&components[startIndex+3]];
        }];
        
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
        
        CGPoint startPoint = CGPointMake(activeBounds.size.width * 0.5f, 0.0f);
        CGPoint endPoint = CGPointMake(activeBounds.size.width * 0.5f, activeBounds.size.height);
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
        free(locations);
        free(components);
        
        //////////////HATCHED BACKGROUND
        if (self.hatchedLinesColor || self.hatchedBackgroundColor) {
            CGFloat buttonOffset = 92.5f; //Offset buttonOffset by half point for crisp lines
            CGContextSaveGState(context); //Save Context State Before Clipping "hatchPath"
            CGRect hatchFrame = CGRectMake(0.0f, buttonOffset-15, activeBounds.size.width, (activeBounds.size.height - buttonOffset+1.0f)+15);
            CGContextClipToRect(context, hatchFrame);
            
            if (self.hatchedBackgroundColor) {
                CGFloat r,g,b,a;
                [self.hatchedBackgroundColor getRed:&r green:&g blue:&b alpha:&a];
                
                CGContextSetRGBFillColor(context, r*255,g*255, b*255, 255);
                CGContextFillRect(context, hatchFrame);
            }
            
            if (self.hatchedLinesColor) {
                CGFloat spacer = 4.0f;
                int rows = (activeBounds.size.width + activeBounds.size.height/spacer);
                CGFloat padding = 0.0f;
                CGMutablePathRef hatchPath = CGPathCreateMutable();
                for(int i=1; i<=rows; i++) {
                    CGPathMoveToPoint(hatchPath, NULL, spacer * i, padding);
                    CGPathAddLineToPoint(hatchPath, NULL, padding, spacer * i);
                }
                CGContextAddPath(context, hatchPath);
                CGPathRelease(hatchPath);
                CGContextSetLineWidth(context, 1.0f);
                CGContextSetLineCap(context, kCGLineCapButt);
                CGContextSetStrokeColorWithColor(context, self.hatchedLinesColor.CGColor);
                CGContextDrawPath(context, kCGPathStroke);
            }
            
            CGContextRestoreGState(context); //Restore Last Context State Before Clipping "hatchPath"
        }
        
        //////////////DRAW LINE
        if (self.verticalLineColor) {
            CGFloat buttonOffset = 92.5f;
            CGMutablePathRef linePath = CGPathCreateMutable();
            CGFloat linePathY = (buttonOffset - 1.0f) - 15;
            CGPathMoveToPoint(linePath, NULL, 0.0f, linePathY);
            CGPathAddLineToPoint(linePath, NULL, activeBounds.size.width, linePathY);
            CGContextAddPath(context, linePath);
            CGPathRelease(linePath);
            CGContextSetLineWidth(context, 1.0f);
            CGContextSaveGState(context); //Save Context State Before Drawing "linePath" Shadow
            CGContextSetStrokeColorWithColor(context, self.verticalLineColor.CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 0.0f, [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f].CGColor);
            CGContextDrawPath(context, kCGPathStroke);
            CGContextRestoreGState(context); //Restore Context State After Drawing "linePath" Shadow
        }
        
        //////////////STROKE PATH FOR INNER SHADOW
        if (self.innerFrameShadowColor || self.innerFrameStrokeColor) {
            CGContextAddPath(context, path);
            CGContextSetLineWidth(context, 3.0f);
            
            if (self.innerFrameStrokeColor) {
               CGContextSetStrokeColorWithColor(context, self.innerFrameStrokeColor.CGColor); 
            }
            if (self.innerFrameShadowColor) {
                CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 6.0f, self.innerFrameShadowColor.CGColor);
            }
            
            CGContextDrawPath(context, kCGPathStroke);
        }
        
        //////////////STROKE PATH TO COVER UP PIXILATION ON CORNERS FROM CLIPPING
        CGContextRestoreGState(context); //Restore First Context State Before Clipping "path"
        CGContextAddPath(context, path);
        CGContextSetLineWidth(context, 3.0f);
        CGContextSetStrokeColorWithColor(context, self.outerFrameColor.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 0.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
        
        //////////////DRAWING BUTTON LABELS
        
        for (UIView *subview in self.subviews){ //Fast Enumeration
            
            if ([subview isKindOfClass:[UIButton class]])
            {
                UIButton *button = (UIButton *)subview;
                
                CGContextSetTextDrawingMode(context, kCGTextFill);
                CGContextSetFillColorWithColor(context, self.buttonTextColor.CGColor);
                CGContextSetShadowWithColor(context, self.buttonShadowOffset, 2.0f, self.buttonShadowColor.CGColor);
                
                [button.titleLabel.text drawInRect:CGRectMake(button.frame.origin.x, button.frame.origin.y+10, button.frame.size.width, button.frame.size.height) withFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
            }
            
        }
    }

}

@end

