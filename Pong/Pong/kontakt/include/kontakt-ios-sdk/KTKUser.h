//
//  KTKUser.h
//  kontakt-ios-sdk
//
//  Created by Lukasz Hlebowicz on 9/9/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKManager.h"


/**
    KTKUser is a protocol that should be implemented by any class that represents user.
 */
@protocol KTKUser <KTKManager>

/**
    user's API key
 */
@property (nonatomic, readonly) NSString *apiKey;

@end

/**
    KTKUser is a class represnting user("extended" manager)
 */
@interface KTKUser : KTKManager<KTKUser>

#pragma mark - properties

@property (nonatomic) NSString *apiKey;

@end
