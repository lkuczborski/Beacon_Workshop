//
//  Beacon.m
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon

- (instancetype)initWithUUID:(NSString *)uuid
                        name:(NSString *)name
                       major:(NSNumber *)major
                       minor:(NSNumber *)minor
{
    self = [super init];
    if (self != nil) {
        _uuid = [uuid copy];
        _name = [name copy];
        _major = major;
        _minor = minor;
    }
    return self;
}

-(NSString *)description
{
    NSString *description = [super description];
    
    return [NSString stringWithFormat:@"%@\nUUID: %@\nName: %@\nMajor: %@\nMinor: %@",
            description, self.uuid, self.name, [self.major stringValue], [self.minor stringValue]];
}

@end
