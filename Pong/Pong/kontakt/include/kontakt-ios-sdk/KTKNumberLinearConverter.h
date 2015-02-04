//
//  KTKFormattedNumberConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 21/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKNumberConverter.h"

/**
 Extends KTKNumberConverter by mapping value before conversion using linear function y = factor * x.
 */
@interface KTKNumberLinearConverter : KTKNumberConverter

#pragma mark - properties

/**
 Factor taht is used to map value before conversion.
 */
@property (strong, nonatomic, readwrite) NSDecimalNumber *factor;

@end
