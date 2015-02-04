//
//  KTKDescriptor.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 07/01/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

/**
 KTKDescriptor is an abstract class that lets you assign arbitrary string unique identifier with another string representing arbitrary type. KTKDescriptor is a base class for KTKServiceDescriptor and KTKCharacteristicDescriptor which are used to provide convinient way to refer to services and characteristics of a bluetooth device by type and not by UUID. UUID may differ between devices depending on hardware and formware version.
 */
@interface KTKDescriptor : NSObject

#pragma mark - properties

/**
 Arbitrary type.
 */
@property (strong, nonatomic, readonly) NSString *type;

/**
 Arbitrary UUID.
 */
@property (strong, nonatomic, readonly) NSString *uuid;

#pragma mark - initializers

/**
 Initializes object with given UUID and type.
 
 @param uuid arbitrary UUID
 @param type arbitrary type
 @return initialized object
 */
- (id)initWithUUID:(NSString *)uuid andType:(NSString *)type;

@end
