//
//  KTKServiceDescriptor.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 07/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

#import "KTKDescriptor.h"

extern NSString *const kKTKServiceDescriptorTypeAccessControl;
extern NSString *const kKTKServiceDescriptorTypeGenericAccessProfile;
extern NSString *const kKTKServiceDescriptorTypeDeviceInformation;
extern NSString *const kKTKServiceDescriptorTypeProximity;
extern NSString *const kKTKServiceDescriptorTypeTxPower;
extern NSString *const kKTKServiceDescriptorTypeTimers;
extern NSString *const kKTKServiceDescriptorTypeBatteryService;
extern NSString *const kKTKServiceDescriptorTypeResetService;

/**
 KTKServiceDescriptor is an class that represents a specific bluetooth service. It allows to refer to device service by convinient type rather than its UUID.
 
 Predefined services types are:
 
 * kKTKServiceDescriptorTypeAccessControl
 * kKTKServiceDescriptorTypeGenericAccessProfile
 * kKTKServiceDescriptorTypeDeviceInformation
 * kKTKServiceDescriptorTypeProximity
 * kKTKServiceDescriptorTypeTxPower
 * kKTKServiceDescriptorTypeTimers
 * kKTKServiceDescriptorTypeBatteryService
 * kKTKServiceDescriptorTypeResetService
 */
@interface KTKServiceDescriptor : KTKDescriptor

@end
