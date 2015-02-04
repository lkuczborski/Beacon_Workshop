//
//  KTKConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 20/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

/**
 KTKConverter is an abstarct class that is a base for all converters. It converts binary value to its string representation and vice versa.
 */
@interface KTKConverter : NSObject

#pragma mark - public methods

/**
 Converts string representation of a value to its binary form.
 
 @param string string representation of a value
 @param error error if operation fails
 @return binary form of a value
 */
- (NSData *)dataWithString:(NSString *)string error:(NSError **)error;

/**
 Converts binary value to its string representation.
 
 @param data binary value
 @param error error if operation fails
 @return string represetation of data
 */
- (NSString *)stringWithData:(NSData *)data error:(NSError **)error;

@end
