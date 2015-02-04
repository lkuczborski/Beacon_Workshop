//
//  KTKRegion.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 31/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"

/**
 KTKRegion is a protocol that should be implemented by any class that represents region.
 uuid is REQUIRED
 major is OPTIONAL
 minor is OPTIONAL - ONLY important when major is specified
 Those values define which beacons are only interesting in specified region - it works like filters for beacons.
 */
@protocol KTKRegion <KTKDataTransferObject>

/**
 UUID that defines region. Region contains beacons with proximity UUID equal to region's UUID.
 */
@property (strong, nonatomic, readonly) NSString *uuid;

/**
 Major that defines region with specified the most significant value in a beacon.
 ONLY beacons with equal their major will be found.
 */
@property (strong, nonatomic, readonly) NSNumber *major;

/**
 Minor that defines region with specified the least significant value in a beacon.
 ONLY beacons with equal their minors will be found.
 */
@property (strong, nonatomic, readonly) NSNumber *minor;

@end


/**
 KTKRegion is a class representing region.
 */
@interface KTKRegion : KTKDataTransferObject <KTKRegion>


#pragma mark - properties


@property (strong, nonatomic, readwrite) NSString *uuid;
@property (strong, nonatomic, readwrite) NSNumber *major;
@property (strong, nonatomic, readwrite) NSNumber *minor;


#pragma mark - Initializers


/**
 Initializes object with proximity UUID, major and minor.
 
 @param uuid    region's proximity UUID
 @param major   region's major
 @param minor   region's minor
 
 @return initailized KTKRegion object with set above properties
 */
- (id)initWithUUID:(NSString *)uuid major:(NSNumber *)major andMinor:(NSNumber *)minor;

/**
 Initializes object with proximity UUID.
 
 @param uuid    region's proximity UUID
 
 @return initailized KTKRegion object with set UUID
 */
- (id)initWithUUID:(NSString *)uuid;

/**
 Initializes object with proximity UUID and major.
 
 @param uuid    region's proximity UUID
 @param major   region's major
 
 @return initailized KTKRegion object with set above properties
 */
- (id)initWithUUID:(NSString *)uuid andMajor:(NSNumber *)major;


@end
