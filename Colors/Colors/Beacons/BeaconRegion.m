//
//  BeaconRegion.m
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "BeaconRegion.h"

@implementation BeaconRegion

- (instancetype)initWithUUID:(NSString *)uuid
                        name:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _uuid = [uuid copy];
    }
    return self;
}

@end
