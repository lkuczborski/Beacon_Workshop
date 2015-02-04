//
//  KTKNumberConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 20/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKConverter.h"

/**
 Converts binary value to its decimal number representation as a string and vice versa.
 */
@interface KTKNumberConverter : KTKConverter

#pragma mark - properties

/**
 Size of binary value in bytes.
 */
@property (assign, nonatomic, readonly) NSUInteger size;

/**
 Maximum value of a number that can be converted.
 */
@property (strong, nonatomic, readonly) NSDecimalNumber *maxValue;

/**
 Minimum value of a number that can be converted.
 */
@property (strong, nonatomic, readonly) NSDecimalNumber *minValue;

#pragma mark - initializers

/**
 Initializes number converter with a given size of a binary value.
 
 @param size size of a binary value in bytes.
 @return initialized converter
 */
- (id)initWithSize:(NSUInteger)size;

/**
 Initializes number converter with a given size of a binary value, minimum value and maximum value.
 
 @param size size of a binary value in bytes
 @param minValue minimum value of a number
 @param maxValue maximum value of a number
 @return initialized converter
 */
- (id)initWithSize:(NSUInteger)size minValue:(NSString *)minValue andMaxValue:(NSString *)maxValue;

#pragma mark - public methods

/**
 Converts string represenation of a number to NSDecimalNumber.
 
 @param string string representation of a number to convert
 @param error error if operation fails
 @return number converted from string
 */
- (NSDecimalNumber *)numberWithString:(NSString *)string error:(NSError **)error;

/**
 Converts NSDecimalNumebr to its string representation.
 
 @param number decimal number to convert
 @param error if operation fails
 @return strin representation of a number
 */
- (NSString *)stringWithNumber:(NSDecimalNumber *)number error:(NSError **)error;

/**
 Converts decimal number to its binary representation.
 
 @param number number to convert
 @return binary representation of a number
 */
- (NSData *)dataWithNumber:(NSDecimalNumber *)number;

/**
 Converts binary data to its decimal number representation.
 
 @param data binary data to convert
 @return decimal number
 */
- (NSDecimalNumber *)numberWithData:(NSData *)data;

@end
