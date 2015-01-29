//
//  BeaconRegion.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Class reperesnting beacon region.
 */
@interface BeaconRegion : NSObject

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *name;

/**
 *  Designated initalizer for creating a new BeaconRegion instance.
 *
 *  @param uuid NSString with the UUID for reagion.
 *  @param name Unique name for region.
 *
 *  @return New instance of BeaconRegion.
 */
- (instancetype)initWithUUID:(NSString *)uuid
                        name:(NSString *)name NS_DESIGNATED_INITIALIZER;

@end
