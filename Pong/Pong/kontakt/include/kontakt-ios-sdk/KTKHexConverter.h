//
//  KTKHexConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 20/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKConverter.h"

/**
 Converts binary value to its hexadecimal string representation and vice versa.
 */
@interface KTKHexConverter : KTKConverter

#pragma mark - properties

/**
 Size of a binary value in bytes.
 */
@property (assign, nonatomic, readonly) NSUInteger size;

#pragma mark - initializers

/**
 Initializes object of KTKHexConverter with given size.
 
 @param size size of binary value in bytes.
 @return initialized converter
 */
- (id)initWithSize:(NSUInteger)size;

@end
