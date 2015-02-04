//
//  KTKPublicVenue.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 12/5/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKVenueBase.h"

@class KTKManager;

/**
 KTKPublicVenue is a protocol that should be implemented by any class that represents public venue.
 */
@protocol KTKPublicVenue <KTKVenueBase>

/**
 Venue's source(manager's venue which is base for this public one) UUID
 */
@property (strong, nonatomic, readonly) NSString *sourceUUID;

/**
 Venue's status - VERIFICATION, VERIFIED, PUBLISHED, REJECTED
 */
@property (strong, nonatomic, readonly) NSString *status;

/**
 Venue's manager
 */
@property (strong, nonatomic, readonly) KTKManager *manager;

@end


/**
 KTKPublicVenue is a class representing public venue.
 */
@interface KTKPublicVenue : KTKVenueBase <KTKPublicVenue>

#pragma mark - properties

@property (strong, nonatomic, readwrite) NSString *sourceUUID;
@property (strong, nonatomic, readwrite) NSString *status;
@property (strong, nonatomic, readwrite) KTKManager *manager;

@end
