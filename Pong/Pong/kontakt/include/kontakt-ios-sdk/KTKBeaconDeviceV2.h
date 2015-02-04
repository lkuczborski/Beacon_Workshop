//
//  KTKBeaconDeviceV2.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 22/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKBeaconDevice.h"

@class KTKFirmware;

/**
 Possible states of firmware update process.
 */
typedef NS_ENUM(int, KTKBeaconDeviceFirmwareUpdateState) {
    /**
     Beacon is being prepared for firmware update.
     */
    KTKBeaconDeviceFirmwareUpdateStatePreparing,
    
    /**
     Firmware is being uploaded to beacon.
     */
    KTKBeaconDeviceFirmwareUpdateStateUploading,
};

/**
 Represents second generation of Kontakt beacon. This beacon can have its firmware updated.
 */
@interface KTKBeaconDeviceV2 : KTKBeaconDevice

#pragma mark - properties

/**
 Percentage value of battery state.
 */
@property (assign, nonatomic, readonly) NSUInteger batteryLevel;

/**
 Firmware version number
 */
@property (strong, nonatomic, readonly) NSDecimalNumber *firmwareVersion;

#pragma mark - public methods

/**
 Updates beacon firmware. This methods is blocking and waits for operation to finish.
 
 @param firmware firmware
 @param masterPassword password required to update beacons firmware, this passwod is different than regular password used to connect to the beacon
 @param progressHandler block of code that is invoked to give a feedback about update progress, if state parameter is KTKBeaconDeviceFirmwareUpdateStateUploading then progress parameters contains value between 0 nad 1 that indicates progress of firmare upload process
 
 @return error if operation fails
 */
- (NSError *)updateFirmware:(KTKFirmware *)firmware
        usingMasterPassword:(NSString *)masterPassword
            progressHandler:(void (^)(KTKBeaconDeviceFirmwareUpdateState state, int progress))progressHandler;

/**
 Updates beacon firmware if beacon is in DFU mode. This methods is non-blocking.
 
 @param firmware        firmware object
 @param progressHandler block of code that is invoked to give a feedback about update progress, 
                        if state parameter is KTKBeaconDeviceFirmwareUpdateStateUploading then progress parameters 
                        contains value between 0 nad 1 that indicates progress of firmare upload process
 
 @return error if operation fails
 */
- (NSError *)updateFirmwareForDfu:(KTKFirmware *)firmware
              withProgressHandler:(void (^)(KTKBeaconDeviceFirmwareUpdateState, int))progressHandler;

@end
