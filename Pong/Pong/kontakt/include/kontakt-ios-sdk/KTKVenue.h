//
//  KTKVenue.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 14/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKVenueBase.h"

/**
 KTKVenue is a protocol that should be implemented by any class that represents (manager's)venue.
 */
@protocol KTKVenue <KTKVenueBase>

/**
 Boolean value indicating if the venue is private.
 */
@property (strong, nonatomic, readonly) NSValue *priv;

/**
 Venue's manager uuid
 */
@property (strong, nonatomic, readonly) NSString *managerUUID;

@end


/**
 KTKVenue is a class representing venue.
 */
@interface KTKVenue : KTKVenueBase <KTKVenue>

#pragma mark - properties

@property (strong, nonatomic, readwrite) NSValue *priv;
@property (strong, nonatomic, readwrite) NSString *managerUUID;

@end
