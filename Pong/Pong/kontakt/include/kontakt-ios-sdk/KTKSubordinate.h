//
//  KTKSubordinate.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 10/6/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"

/**
 KTKSubordinate is a protocol that should be implemented by any class that represents subordinate.
 */
@protocol KTKSubordinate <KTKDataTransferObject>

/**
 subordinate's uuid
 */
@property (nonatomic, readonly) NSString *UUID;

/**
 subordinate's supervisor uuid
 */
@property (nonatomic, readonly) NSString *uniqueID;

/**
 subordinate's first name
 */
@property (nonatomic, readonly) NSString *firstName;

/**
 subordinate's last name
 */
@property (nonatomic, readonly) NSString *lastName;

/**
 subordinate's email addres
 */
@property (nonatomic, readonly) NSString *email;

/**
 subordinate's role
 */
@property (nonatomic, readonly) NSString *role;

/**
 subordinate's (assigned)beacons count
 */
@property (nonatomic, readonly) NSUInteger beaconsCount;

@end


/**
 KTKSubordinate is a class represnting subordinate
 */
@interface KTKSubordinate : KTKDataTransferObject <KTKSubordinate>

@property (nonatomic) NSString *UUID;
@property (nonatomic) NSString *uniqueID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *role;
@property (nonatomic) NSUInteger beaconsCount;

@end
