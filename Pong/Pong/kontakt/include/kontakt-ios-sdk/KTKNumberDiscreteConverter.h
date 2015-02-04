//
//  KTKNumberDiscreteConverter.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 04/02/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKNumberConverter.h"

/**
 Extends KTKNumberConverter by mapping value before conversion using discrete values.
 */
@interface KTKNumberDiscreteConverter : KTKNumberConverter

#pragma mark - properties

/**
 Dictionary of NSDecimalNumebr objects that represents value mapping.
 */
@property (strong, nonatomic, readwrite) NSDictionary *mapping;

@end
