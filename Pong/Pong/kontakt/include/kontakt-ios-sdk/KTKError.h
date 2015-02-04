//
//  KTKError.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 25/02/14.
//  Copyright (c) 2014 kontakt. All rights reserved.
//

/**
 Possible error codes of KTKError.
 */
typedef NS_ENUM(int, KTKErrorCode) {
    /**
     Error cause is unknown.
     */
    KTKErrorCodeUnknown,
    
    /**
     Connection to web API failed.
     */
    KTKErrorCodeConnectionFailed,
    
    /**
     Web API didn't found requested resource.
     */
    KTKErrorCodeResourceNotFound,
    
    /**
     KTKConverter did failed to convert value.
     */
    KTKErrorCodeConversionFailed,
    
    /**
     Bluetooth device is not connected.
     */
    KTKErrorCodeDeviceDisconnected,
    
    /**
     Bluetooth device is not connectable.
     */
    KTKErrorCodeDeviceLocked,
    
    /**
     Bluetooth operation has failed.
     */
    KTKErrorCodeOperationFailed,
    
    /**
     Bluetooth operation has timed out.
     */
    KTKErrorCodeOperationItmedOut,
};

/**
 This class represents error returend by SKD methods.
 */
@interface KTKError : NSError

#pragma mark - class methods

/**
 Checks if error is KTKError with provided error code.
 
 @param error error to be checked
 @param code error code
 @return YES if error is KTKError with specified error code
 */
+ (BOOL)doesError:(NSError *)error haveCode:(KTKErrorCode)code;

/**
 Creates and return new KTKError object wiht provided error code.
 
 @param code error code
 @return new KTKError object
 */
+ (KTKError *)errorWithCode:(KTKErrorCode)code;

#pragma mark - initializers

/**
 Initializes object with given error code.
 
 @param code error code
 @return initialized object
 */
- (id)initWithCode:(KTKErrorCode)code;

@end
