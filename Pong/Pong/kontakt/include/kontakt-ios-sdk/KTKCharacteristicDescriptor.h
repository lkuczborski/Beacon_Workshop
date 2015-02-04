//
//  KTKCharacteristcDescriptor.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 07/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKDescriptor.h"

@class KTKConverter;

extern NSString *const kKTKCharacteristicDescriptorTypeDeviceName;
extern NSString *const kKTKCharacteristicDescriptorTypeAppearance;
extern NSString *const kKTKCharacteristicDescriptorTypeSlavedPreferredConnectionParameters;
extern NSString *const kKTKCharacteristicDescriptorTypeManufacturerName;
extern NSString *const kKTKCharacteristicDescriptorTypeFirmwareRevision;
extern NSString *const kKTKCharacteristicDescriptorTypeHardwareRevision;
extern NSString *const kKTKCharacteristicDescriptorTypeTxPowerLevel;
extern NSString *const kKTKCharacteristicDescriptorTypeBatteryLevel;
extern NSString *const kKTKCharacteristicDescriptorTypeProximityUUID;
extern NSString *const kKTKCharacteristicDescriptorTypeMajor;
extern NSString *const kKTKCharacteristicDescriptorTypeMinor;
extern NSString *const kKTKCharacteristicDescriptorTypeModelName;
extern NSString *const kKTKCharacteristicDescriptorTypeAdvertisingInterval;
extern NSString *const kKTKCharacteristicDescriptorTypePassword;
extern NSString *const kKTKCharacteristicDescriptorTypeSetPassword;
extern NSString *const kKTKCharacteristicDescriptorTypeReset;
extern NSString *const kKTKCharacteristicDescriptorTypeDefault;
extern NSString *const kKTKCharacteristicDescriptorTypeBootloader;

/**
 KTKCharacteristicDescriptor is an class that represents a specific bluetooth characteristic. It allows to refer to device characteristic by convinient type rather than its UUID.
 
 Predefined characteristics types are:
 
 * kKTKCharacteristicDescriptorTypeDeviceName
 * kKTKCharacteristicDescriptorTypeAppearance
 * kKTKCharacteristicDescriptorTypeSlavedPreferredConnectionParameters
 * kKTKCharacteristicDescriptorTypeManufacturerName
 * kKTKCharacteristicDescriptorTypeFirmwareRevision
 * kKTKCharacteristicDescriptorTypeHardwareRevision
 * kKTKCharacteristicDescriptorTypeTxPowerLevel
 * kKTKCharacteristicDescriptorTypeBatteryLevel
 * kKTKCharacteristicDescriptorTypeProximityUUID
 * kKTKCharacteristicDescriptorTypeMajor
 * kKTKCharacteristicDescriptorTypeMinor
 * kKTKCharacteristicDescriptorTypeModelName
 * kKTKCharacteristicDescriptorTypeAdvertisingInterval
 * kKTKCharacteristicDescriptorTypePassword
 * kKTKCharacteristicDescriptorTypeSetPassword
 * kKTKCharacteristicDescriptorTypeReset
 * kKTKCharacteristicDescriptorTypeDefault
 * kKTKCharacteristicDescriptorTypeBootloader
 */
@interface KTKCharacteristicDescriptor : KTKDescriptor

#pragma mark - properties

/**
 Converter is used to convert binary value of characteristic into its string representation and vice versa.
 */
@property (strong, nonatomic, readonly) KTKConverter *converter;

#pragma mark - initializers

/**
 Initializes characteristics descriptor.
 
 @param uuid UUID of characteristic
 @param type should be unique string that identifies characteristic
 @param converter converter used to convert binary value of characteristic to its string representation and vice versa.
 @return initialized object
 */
- (id)initWithUUID:(NSString *)uuid type:(NSString *)type andConverter:(KTKConverter *)converter;

@end
