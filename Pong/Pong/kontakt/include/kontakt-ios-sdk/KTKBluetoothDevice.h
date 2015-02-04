//
//  KTKBluetoothDevice.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 19/12/13.
//  Copyright (c) 2013 kontakt. All rights reserved.
//

#import "KTKServiceDescriptor.h"
#import "KTKCharacteristicDescriptor.h"

/**
 Represents generic bluetooth device and allows to interact with it. All methods in this class are blocking (they wait for operation to finish). If you want to execute them concurrently you are encouraged to use GCD:

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [device connect];
    });
 */
@interface KTKBluetoothDevice : NSObject

#pragma mark - class methods

/**
 Returns descriptors of all characteristics of a bluetooth device. By default this class returns empty dictionary. You should implement this methods in a subclass.
 
 @return dictionary of KTKCharacteristicDescriptor objects indexed by UUID strings
 */
+ (NSDictionary *)characteristicsDescriptors;

/**
 Returns descriptors of all services of a bluetooth device. By default this class returns empty dictionary. You should implement this methods in a subclass.
 
 @return dictionary of KTKServiceDescriptor objects indexed by UUID strings
 */
+ (NSDictionary *)servicesDescriptors;

#pragma mark - properties

/**
 UUID provided by Core Bluetooth to identify device.
 */
@property (strong, nonatomic, readonly) NSUUID *identifier;

/**
 Name broadcaseted by device.
 */
@property (strong, nonatomic, readonly) NSString *name;

#pragma mark - public methods

/**
 Connects to device. Has 30s timeout.
 
 @return error if operation fails
 */
- (NSError *)connect;

/**
 Disconnects from device. Has 30s timeout.
 
 @return error if operation fails
 */
- (NSError *)disconnect;

/**
 Discover services and characteristics of device. Has 30s timeout.
 
 @return error if operation fails
 */
- (NSError *)discover;

/**
 Reads value of device characteristc. Has 30s timeout.
 
 @param descriptor describes characteristic that value will be read for
 @return error if operation fails
 */
- (NSError *)readValueForCharacteristicWithDescriptor:(KTKCharacteristicDescriptor *)descriptor;

/**
 Writes value to device characteristic. Has 30s timeout.
 
 @param data binary representation of value that will be written to device characteristic
 @param descriptor object that describes device characteristic
 @return error if operation fails
 */
- (NSError *)writeData:(NSData *)data forCharacteristicWithDescriptor:(KTKCharacteristicDescriptor *)descriptor;

/**
 Writes value to device characteristic. Has 30s timeout.
 
 @param string string representation of value that will be written to device characteristic
 @param descriptor object that describes device characteristic
 @return error if operation fails
 */
- (NSError *)writeString:(NSString *)string forCharacteristicWithDescriptor:(KTKCharacteristicDescriptor *)descriptor;

/**
 Waits for device to disconnect. Has 30s timeout.
 
 @warning This methods does not disconnect from device. Use it only when you expect the device to end connection.
 
 @return error if operation fails
 */
- (NSError *)waitForDisconnect;

/**
 Tells if characteristic represented by descriptor is readable.
 
 @param descriptor characteristic descriptor
 @return YES if characteristic is readable
 */
- (BOOL)isCharacteristicWithDescriptorReadable:(KTKCharacteristicDescriptor *)descriptor;

/**
 Tells if characteristic represented by descriptor is writable.
 
 @param descriptor characteristic descriptor
 @return YES if characteristic is writable
 */
- (BOOL)isCharacteristicWithDescriptorWritable:(KTKCharacteristicDescriptor *)descriptor;

/**
 Returns value of charactestitic in binary form.
 
 @param descriptor object that describes device characteristic
 @return value of characteristic
 */
- (NSData *)dataForCharacteristicWithDescriptor:(KTKCharacteristicDescriptor *)descriptor;

/**
 Returns value of characteristic in string form.
 
 @param descriptor object that describes device characteristic
 @return value of characteristic
 */
- (NSString *)stringForCharacteristicWithDescriptor:(KTKCharacteristicDescriptor *)descriptor;

@end
