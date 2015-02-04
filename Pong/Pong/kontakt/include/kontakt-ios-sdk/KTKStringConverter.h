//
//  KTKStringConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 20/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKConverter.h"

/**
 Converts binary value to its string representation and vice versa.
 */
@interface KTKStringConverter : KTKConverter

#pragma mark - properties

/**
 String encoding.
 */
@property (assign, nonatomic, readonly) NSStringEncoding encoding;

/**
 Maximum string length.
 */
@property (assign, nonatomic, readonly) NSUInteger maxLength;

/**
 Minimum string length.
 */
@property (assign, nonatomic, readonly) NSUInteger minLength;

#pragma mark - initializers

/**
 Initializes string converter with given encoding, minimum length and maximum length.
 
 @param encoding string encoding
 @param minLength minimum string length
 @param maxLength maximim string length
 @return initialized converter
 */
- (id)initWithEncoding:(NSStringEncoding)encoding minLength:(NSUInteger)minLength andMaxLength:(NSUInteger)maxLength;

@end
