//
//  KTKFirmware.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 28/04/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"

/**
 KTKFirmware is a protocol that should be implemented by any class that represents firmware.
 */
@protocol KTKFirmware <NSObject>

/**
 Firmware description.
 */
@property (strong, nonatomic, readonly) NSString *desc;

/**
 
 */
@property (strong, nonatomic, readonly) NSString *important;

/**
 Firmware API URL
 */
@property (strong, nonatomic, readonly) NSString *url;

/**
 Firmware data - if nil try downloadData
 */
@property (strong, nonatomic, readonly) NSData *data;

/**
 Firmware version number
 */
@property (strong, nonatomic, readonly) NSString *version;

/**
 Firmware version numbers from which it's valid to update to this version of firmware
 */
@property (strong, nonatomic, readonly) NSArray *validVersions;

@end

/**
 KTKFirmware is a class representing firmware.
 */
@interface KTKFirmware : KTKDataTransferObject <KTKFirmware>

#pragma mark - properties

@property (strong, nonatomic, readonly) NSString *desc;
@property (strong, nonatomic, readonly) NSString *important;
@property (strong, nonatomic, readonly) NSString *url;
@property (strong, nonatomic, readonly) NSData *data;
@property (strong, nonatomic, readonly) NSString *version;
@property (strong, nonatomic, readonly) NSArray *validVersions;

#pragma mark - Public

/**
 Downloads firmware's binary data.
 If succeeded then property data != nil.
 */
- (BOOL)downloadData;

@end
