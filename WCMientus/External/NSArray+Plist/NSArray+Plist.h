//
//  NSArray+Plist.h
//  Ante-Up
//
//  Created by mientus on 11.07.2012.
//  Copyright (c) 2012 Ante Up. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Plist)

- (BOOL)writeToPlistFile:(NSString*)filename;
+ (NSArray*)readFromPlistFile:(NSString*)filename;

@end
