//
//  KTKDataTransferObject.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 07/04/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

/**
 KTKDataTransferObject is a protocol that should be implemented by every model class. Although you can use model classes defined in the SDK you can create yout own model objects as well. For example if you want to store data using Core Data you can create model objects that derives from NSManagedObject.
 */
@protocol KTKDataTransferObject <NSObject>

/**
 String value in form of an UUID that identifies object.
 */
@property (strong, nonatomic, readonly) NSString *identifier;

@end

/**
 KTKDataTransferObject is a base class for every model class defined in the SDK.
 */
@interface KTKDataTransferObject : NSObject <KTKDataTransferObject, NSCopying>

#pragma mark - class methods

/**
 Reads value from a dictionary for a given key and assures that nil is returned every time dictionary returns NSNull object.
 
 @param key key for dictionary
 @param dictionary dictionary to read value from
 @return value for the key
 */
+ (id)readValueForKey:(NSString *)key fromDictionary:(NSDictionary *)dictionary;

#pragma mark - properties

@property (strong, nonatomic, readonly) NSString *identifier;

#pragma mark - initializers

/**
 Initializes object using values in given dictionary.
 
 @param dictionary dictionary with initial values
 @return initailized model object
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
