//
//  BeaconRegion.h
//  Colors
//
//  Created by Lukasz Stocki on 22.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconRegion : NSObject

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWitName:(NSString *)name
                       UUID:(NSString *)uuid NS_DESIGNATED_INITIALIZER;

@end
