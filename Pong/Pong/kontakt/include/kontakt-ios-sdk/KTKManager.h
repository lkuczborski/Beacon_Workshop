//
//  KTKManager.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 9/8/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"


@protocol KTKCompany;

/**
    KTKManager is a protocol that should be implemented by any class that represents manager.
 */
@protocol KTKManager <KTKDataTransferObject>

/**
    manager's uuid
 */
@property (nonatomic, readonly) NSString *UUID;

/**
    manager's supervisor uuid
 */
@property (nonatomic, readonly) NSString *supervisorUUID;

/**
    manager's first name
 */
@property (nonatomic, readonly) NSString *firstName;

/**
    manager's last name
 */
@property (nonatomic, readonly) NSString *lastName;

/**
    manager's role
 */
@property (nonatomic, readonly) NSString *role;

/**
    manager's email addres
 */
@property (nonatomic, readonly) NSString *email;

/**
    manager's company
 */
@property (nonatomic) id<KTKCompany> company;

/**
    manager's unique id
 */
@property (nonatomic, readonly) NSString *uniqueId;

@end

/**
    KTKCompany is a class represnting manager
 */
@interface KTKManager : KTKDataTransferObject<KTKManager>

#pragma mark - properties

@property (nonatomic) NSString *UUID;
@property (nonatomic) NSString *supervisorUUID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *role;
@property (nonatomic) NSString *email;
@property (nonatomic) id<KTKCompany> company;
@property (nonatomic) NSString *uniqueId;

#pragma mark - methods

/**
 Initializes object with most values for first name, last name, email and role.
 
 @param firstName   manager's first name
 @param lastName    manager's last name
 @param email       manager's email
 @param role        manager's role
 
 @return initailized manager object
 */
- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email role:(NSString *)role;

@end
