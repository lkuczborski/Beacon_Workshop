//
//  KTKBeaconDevice.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 20/12/13.
//  Copyright (c) 2013 kontakt. All rights reserved.
//

#import "KTKBluetoothDevice.h"

@class KTKBluetoothManager;

/**
 Represents Kontakt beacon device.
 */
@interface KTKBeaconDevice : KTKBluetoothDevice

#pragma mark - properties

/**
 Logic value indicating if beacon is in DFU.
 */
@property (nonatomic) BOOL isInDfuMode;

/**
 Logic value indicating if beacon is locked.
 */
@property (assign, nonatomic, readonly) BOOL locked;

/**
 Unique identifier of a beacon.
 */
@property (copy, nonatomic, readonly) NSString *uniqueID;

#pragma mark - public methods

/**
 Authorizes connection to the beacon using password set by setPassword: method.
 
 @return error if opertion fails
 */
- (NSError *)authorize;

/**
 Sets password used to authorize connection to the beacon.
 
 @param password password for the beacon
 @return error if operation fails
 */
- (NSError *)setPassword:(NSString *)password;

/**
 Returns characteristic descriptor for a specific characteristic kind.
 
 @param type type of characteristic
 @return characteristic descriptor
 */
- (KTKCharacteristicDescriptor *)characteristicDescriptorWithType:(NSString *)type;

/**
 Returns service descriptor for a specific service kind.
 
 @param type type of service
 @return service descriptor
 */
- (KTKServiceDescriptor *)serviceDescriptorWithType:(NSString *)type;

@end
