//
//  NSString+Base64.h
//  TheShootAR
//
//  Created by Michał Zaborowski on 27-04-12.
//  Copyright (c) 2012 Future Reality Games sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)base64Encode:(NSString *)plainText;
+ (NSString *)base64Decode:(NSString *)base64String;

@end
