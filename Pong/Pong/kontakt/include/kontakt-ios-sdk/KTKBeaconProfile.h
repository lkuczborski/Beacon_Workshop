//
//  KTKBeaconProfile.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 10/15/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"

/**
 KTKProfile is a protocol that should be implemented by any object that represents a beacon's profile.
 */
@protocol KTKBeaconProfile <KTKDataTransferObject>

/**
 profile's UUID
 */
@property (nonatomic, readonly) NSString *UUID;

/**
 profile's name
 */
@property (nonatomic, readonly) NSString *name;

/**
 profile's usage description
 */
@property (nonatomic, readonly) NSString *usageDescription;

/**
 profile's proximity UUID
 */
@property (nonatomic, readonly) NSString *proximityUUID;

/**
 profile's broadcasting interval
 */
@property (nonatomic, readonly) NSNumber *interval;

/**
 profile's broadcasting power
 */
@property (nonatomic, readonly) NSNumber *txPower;

@end


/**
 KTKBeaconProfile is a class representing a beacon's profile settings.
 */
@interface KTKBeaconProfile : KTKDataTransferObject <KTKBeaconProfile>

@property (nonatomic) NSString *UUID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *usageDescription;
@property (nonatomic) NSString *proximityUUID;
@property (nonatomic) NSNumber *interval;
@property (nonatomic) NSNumber *txPower;

@end

