//
//  KTKPublicBeacon.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 12/8/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKBeacon.h"


/**
 KTKPublicBeacon is a protocol that should be implemented by any object that represents a Public Beacon.
 */
@protocol KTKPublicBeacon <KTKBeacon>

/**
 Public beacon's status - VERIFICATION, VERIFIED, PUBLISHED, REJECTED.
 */
@property (strong, nonatomic, readonly) NSString *status;

/**
 Public beacon's source(manager's beacon which is base for this public one) UUID
 */
@property (strong, nonatomic, readonly) NSString *sourceUUID;

/**
 Public beacon's actions count - browser and content ones
 */
@property (nonatomic, readonly) NSUInteger actionsCount;

@end


/**
 KTKPublicBeacon is a class representing a Public Beacon.
 */
@interface KTKPublicBeacon : KTKBeacon <KTKPublicBeacon>

#pragma mark - properties

@property (strong, nonatomic, readwrite) NSString *status;
@property (strong, nonatomic, readwrite) NSString *sourceUUID;
@property (nonatomic, readwrite) NSUInteger actionsCount;

@end
