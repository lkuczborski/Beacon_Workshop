//
//  KTKBluetoothManager.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 19/12/13.
//  Copyright (c) 2013 kontakt. All rights reserved.
//

@class KTKBluetoothManager;

/**
 Responds to bluetooth manager events. Methods are invoked on main thread.
 */
@protocol KTKBluetoothManagerDelegate <NSObject>

/**
 Informs that bluetooth manager has found new beacons and updated some already discovered beacons.
 
 @param bluetoothManager bluetooth manager that calls this method
 @param devices set of new and updated KTKBluetoothDevice objects
 */
- (void)bluetoothManager:(KTKBluetoothManager *)bluetoothManager didChangeDevices:(NSSet *)devices;

@end

/**
 Allows to easily sarch for nearby bluetooth devices.
 */
@interface KTKBluetoothManager : NSObject

#pragma mark - properties

/**
  Responds to bluetooth manager events.
 */
@property (weak, nonatomic, readwrite) id<KTKBluetoothManagerDelegate> delegate;

#pragma mark - public methods

/**
 Return array of all discovered bluethooth devices.
 
 @return array of KTKBluetoothDevice objects
 */
- (NSArray *)devices;

/**
 Forces bluethooth manager to forget all devices and discover them again.
 */
- (void)reloadDevices;

/**
 Tells bluetooth manager to start discovering devices.
 */
- (void)startFindingDevices;

/**
 Tells bluetooth manager to stop discovering devices.
 */
- (void)stopFindingDevices;

@end
