//
//  KTKCompany.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 9/8/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"


/**
    KTKCompany is a protocol that should be implemented by any class that represents company.
 */
@protocol KTKCompany <KTKDataTransferObject>

/**
    company's uuid
 */
@property (nonatomic, readonly) NSString *uuid;

/**
    company's name
 */
@property (nonatomic, readonly) NSString *name;

/**
    company's country code
 */
@property (nonatomic, readonly) NSString *countryCode;

/**
    company's unique id
 */
@property (nonatomic, readonly) NSString *uniqueId;

@end

/**
    KTKCompany is a class represnting company
 */
@interface KTKCompany : KTKDataTransferObject <KTKCompany>

#pragma mark - properties

@property (nonatomic) NSString *uuid;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *countryCode;
@property (nonatomic) NSString *uniqueId;

@end
