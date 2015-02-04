//
//  KTKClient.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 12/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

@class KTKAction;
@class KTKPublicAction;
@class KTKBeacon;
@class KTKPublicBeacon;
@class KTKBeaconProfile;
@class KTKFirmware;
@class KTKVenue;
@class KTKPublicVenue;
@class KTKManager;
@class KTKUser;

@protocol KTKAction;
@protocol KTKBeacon;
@protocol KTKVenue;

extern NSString *const kKTKAdded;
extern NSString *const kKTKModified;
extern NSString *const kKTKDeleted;
extern NSString *const kKTKTimestamp;

/**
 KTKClinet provides easy way to use web API methods.
 */
@interface KTKClient : NSObject

#pragma mark - properties

/**
 Authenticates user. You should write your own API key to this property.
 */
@property (copy, nonatomic, readwrite) NSString *apiKey;

/**
 Points to the server where web API is located. You should not change value of this property.
 */
@property (copy, nonatomic, readwrite) NSURL *apiUrl;

#pragma mark - Management

/**
 Returns regions that are used by KTKLocationManager to detect beacons.
 
 @param error error if operation fails
 @return array of KTKRegion objects
 */
- (NSArray *)getRegionsError:(NSError **)error;

#pragma mark - Changelog

/**
 Returns venues that were added, changed or deleted since provided point in time.
 
 Return value is a dictionary that contains four keys:
 
 * kKTKAdded - array of added venues
 * kKTKModified - array of modified venues
 * kKTKDeleted - array of deleted venues
 * kKTKTimestamp - current server timestamp
 
 @param since point in time, put 0 to get all venues
 @param error error if operation fails
 @return dictionary of KTKVenue objects
 */
- (NSDictionary *)getVenuesChangedSince:(NSUInteger)since error:(NSError **)error;

/**
 Returns venues assigned to a venue that were added, changed or deleted since provided point in time.
 
 Return value is a dictionary that contains four keys:
 
 * kKTKAdded - array of added beacons
 * kKTKModified - array of modified beacons
 * kKTKDeleted - array of deleted beacons
 * kKTKTimestamp - current server timestamp
 
 @param venues venues array for which get beacons
 @param since point in time, put 0 to get all beacons
 @param error error if operation fails
 @return dictionary of KTKBeacon objects
 */
- (NSDictionary *)getBeaconsForVenues:(NSArray *)venues changedSince:(NSUInteger)since error:(NSError **)error;

/**
 Returns actions assigned to a beacon that were added, changed or deleted since provided point in time.
 
 Return value is a dictionary that contains four keys:
 
 * kKTKAdded - array of added actions
 * kKTKModified - array of modified actions
 * kKTKDeleted - array of deleted actions
 * kKTKTimestamp - current server timestamp
 
 @param beacons beacons array(KTKBeacon object(s)) for which get actions
 @param since point in time, put 0 to get all actions
 @param error error error if operation fails
 @return dictionary of KTKAction objects
 */
- (NSDictionary *)getActionsForBeacons:(NSArray *)beacons changedSince:(NSUInteger)since error:(NSError **)error;

#pragma mark - Action

/**
 Returns action object for specified UUID
 
 @param UUID    action's UUID
 @param error   error if operation fails
 
 @return action object
 */
- (KTKAction *)actionByUUID:(NSString *)UUID withError:(NSError **)error;

/**
 Returns content's bytes data for specified action's UUID.
 Data can be image or video(content action) or nil(browser action)
 
 @param UUID    action's UUID
 @param error   error if operation fails
 
 @return bytes that represents image/video
 */
- (NSData *)actionContentDataByUUID:(NSString *)UUID withError:(NSError **)error;

/**
 Returns boolean value which tells if CREATE operation succeeded
 
 @param action  action that we want to add/create
 @param error   error if operation fails
 
 @return TRUE if action was successfully created or FALSE if not
 */
- (BOOL)actionCreate:(KTKAction *)action withError:(NSError **)error;

/**
 Returns boolean value which tells if DELETE operation succeeded
 
 @param UUID    action's UUID that will be deleted
 @param error   error if operation fails
 
 @return BOOL value TRUE if action was successfully deleted or FALSE if not
 */
- (BOOL)actionDeleteByUUID:(NSString *)UUID withError:(NSError **)error;

#pragma mark - Beacon

/**
 Returns beacon which is related to specified unique ID
 
 @param uniqueID    beacon's unique ID - the one which contains 4 characters e.g. "AwA1"
 @param error       error if operation fails
 
 @return beacon object
 */
- (KTKBeacon *)beaconByUniqueID:(NSString *)uniqueID withError:(NSError **)error;

/**
 Returns array of beacons which are the properties of manager whose Api Key is provided
 
 @param error error if operation fails
 
 @return array of beacons
 */
- (NSArray *)beaconsWithError:(NSError **)error;

/**
 Returns array of beacons which are the properties of manager with indicated UUID
 
 @param managerUUID manager's UUID
 @param error       error if operation fails
 
 @return array of beacons
 */
- (NSArray *)getBeaconsByManagerUUID:(NSString *)managerUUID withError:(NSError **)error;

/**
 Returns array of beacons which are the properties of indicated manager
 
 @param manager manager
 @param error   error if operation fails

 @return array of beacons
 */
- (NSArray *)getBeaconsForManager:(KTKManager *)manager withError:(NSError **)error;

/**
 Returns list of beacons which are the properties of indicated managers
 
 @param managers    list of managers
 @param error       error if operation fails

 @return list of beacons
 */
- (NSArray *)getBeaconsForManagers:(NSArray *)managers withError:(NSError **)error;

/**
 Returns beacon for specified UUID, major, minor and published parameteres.
 It can be used as PUBLIC(with public API key) and has the same effect as used with private/user's API key and isPublished = true
 
 @param UUID    beacon's UUID
 @param major   beacon's major number
 @param minor   beacon's minor number
 @param isPublished boolean value which tells if beacon is publicly accessible
 @param error   error if operation fails
 
 @return KTKBeacon object
 */
- (KTKBeacon *)beaconByUUID:(NSString *)UUID major:(NSNumber *)major minor:(NSNumber *)minor published:(BOOL)isPublished withError:(NSError **)error;

/**
 Returns beacon for specified UUID, major and minor parameteres. 
 Has the same effect as similiar/above method with isPublished = false.
 It can be used as PUBLIC(with public API key).
 
 @param UUID    beacon's UUID
 @param major   beacon's major number
 @param minor   beacon's minor number
 @param error   error if operation fails
 
 @return KTKBeacon object
 */
- (KTKBeacon *)beaconByUUID:(NSString *)UUID major:(NSNumber *)major minor:(NSNumber *)minor withError:(NSError **)error;

/**
 Returns password and master password for beacon with specified uniqueID.
 
 @param password contains password after operation ends
 @param masterPassword contains master password after operation ends
 @param uniqueID uniqueID of beacon
 
 @return error if operation fails
 */
- (NSError *)getPassword:(NSString **)password andMasterPassword:(NSString **)masterPassword forBeaconWithUniqueID:(NSString *)uniqueID;

/**
 Sends information about beacon to the cloud.
 
 @param beacon beacon to be saved
 
 @return error if operation fails
 */
- (NSError *)saveBeacon:(id<KTKBeacon>)beacon;

/**
 Assigns beacons to specified by UUID venue
 
 @param beacons     array of beacons(KTKBeacon objects) to be assigned to venue
 @param venueUUID   venue's UUID to which beacons will be assigned
 @param error       error if operation fails
 
 @return BOOL value TRUE if beacons were successfully assigned or FALSE if not
 */
- (BOOL)beacons:(NSArray *)beacons assignToVenueByUUID:(NSString *)venueUUID withError:(NSError **)error;

/**
 Assigns beacons to specified by UUID manager
 
 @param beacons     array of beacons(KTKBeacon objects) to be assigned to venue
 @param managerUUID manager's UUID to who beacons will be assigned
 @param error       error if operation fails
 
 @return BOOL value TRUE if beacons were successfully assigned or FALSE if not
 */
- (BOOL)beacons:(NSArray *)beacons assignToManagerByUUID:(NSString *)managerUUID withError:(NSError **)error;

/**
 Move beacons to specified by UUID manager from Company(specified by UUID as well)
 
 @param beacons     array of beacons(KTKBeacon objects) to be assigned to venue
 @param managerUUID manager's UUID to who beacons will be assigned
 @param companyUUID comapny's UUID to which beacons will be assigned
 @param error       error if operation fails
 
 @return BOOL value TRUE if beacons were successfully assigned or FALSE if not
 */
- (BOOL)beacons:(NSArray *)beacons moveToManagerByUUID:(NSString *)managerUUID fromCompanyByUUID:(NSString *)companyUUID withError:(NSError **)error;

/**
 Returns array of manager's(specified by UUID) unassigned beacons
 
 @param managerUUID manager's UUID who has those unassigned beacons
 @param error       error if operation fails
 
 @return array of unassigned beacons
 */
- (NSArray *)beaconsUnassignedByManagerUUID:(NSString *)managerUUID withError:(NSError **)error;


#pragma mark - Beacon Configs


/**
 Returns list of beacons that requires configuration.
 
 @param     error error if operation fails
 @return    list of KTKBeacon objects
 */
- (NSArray *)getBeaconsToConfigureWithError:(NSError **)error;

/**
 Creates config for specified beacon
 
 @param config  configuration of beacon that we want to apply
 @param error   error if operation fails
 
 @return true if configuartion was created
 */
- (BOOL)createBeaconConfig:(KTKBeacon *)config withError:(NSError **)error;

#pragma mark - Firmware

/**
 Returns information about latest beacons firmware update for a list of specified beacons.
 
 @param beacons set of KTKBeaconDevice objects
 @param error error if operation fails
 
 @return dictionary of KTKFirmware objects indexed by KTKBeaconDevice objects
 */
- (NSDictionary *)getLatestFirmwareForBeacons:(NSSet *)beacons error:(NSError **)error;

/**
 Returns firmware object specified by firmware's name
 
 @param firmwareName    firmware's name(e.g. @"2.6")
 @param error           error if operation fails
 
 @return firmware's object or nil if operation failed or improper name was provided
 */
- (KTKFirmware *)firmwareByName:(NSString *)firmwareName withError:(NSError **)error;

/**
 Returns firmware file as bytes buffer.
 
 @param firmwareVersion number of needed firmware's version
 @param error           error if operation fails
 
 @return firmware file as bytes buffer
 */
- (NSData *)firmwareDataForVersion:(NSString *)firmwareVersion withError:(NSError **)error;


#pragma mark - Profile


/**
 Returns beacons predefined profiles/configurations array(KTKBeaconProfile objects)
 
 @param error error if operation fails
 
 @return array of beacons profiles
 */
- (NSArray *)profilesWithError:(NSError **)error;

/**
 Returns beacon profile(KTKBeaconProfile) specified by its name
 
 @param profileName name of demanded profile
 @param error       error if operation fails
 
 @return beacon profile
 */
- (KTKBeaconProfile *)profileByName:(NSString *)profileName withError:(NSError **)error;


#pragma mark - Managers

/**
 Authenticates USER by email and password, returns User object/profile with his API key etc
 
 @param email       user's email
 @param password    user's password
 @param error       error if operation fails
 
 @return user object if request succeeded
 */
- (KTKUser *)getAuthenticatedUserByEmail:(NSString *)email andPassword:(NSString *)password withError:(NSError **)error;

/**
 Creates manager based on KTKManager object
 
 @param manager     manager who will be created
 @param error       error if operation fails
 
 @return true if manager was created successfully
 */
- (BOOL)createManager:(KTKManager *)manager withError:(NSError **)error;

/**
 Updates manager settings based on KTKManager object
 
 @param manager     manager who will be updated with current settings
 @param error       error if operation fails
 
 @return true if manager was updated successfully
 */
- (BOOL)updateManager:(KTKManager *)manager withError:(NSError **)error;

/**
 Deletes manager based on manager's UUID
 
 @param UUID        manager's UUID who will be deleted
 @param error       error if operation fails
 
 @return true if manager was deleted successfully
 */
- (BOOL)deleteManagerWithUUID:(NSString *)UUID withError:(NSError **)error;

/**
 Deletes manager based on KTKManager object
 
 @param manager     manager who will be deleted
 @param error       error if operation fails
 
 @return true if manager was deleted successfully
 */
- (BOOL)deleteManager:(KTKManager *)manager withError:(NSError **)error;

/**
 Assigns managers to supervisor(manager) with specified UUID
 
 @param managers    array of managers(KTKManager) who should be assigned
 @param UUID        supervisor's UUID to whom managers should be assigned
 @param error       error if operation fails
 
 @return true if managers were assigned successfully
 */
- (BOOL)assignManagers:(NSArray *)managers toSupervisorWithUUID:(NSString *)UUID withError:(NSError **)error;

/**
 Returns list of managers
 
 @param error error if operation fails
 
 @return array which is list of managers
 */
- (NSArray *)getManagersWithError:(NSError **)error;

/**
 Returns manager with specified UUID
 
 @param UUID    manager's UUID
 @param error   error if operation fails
 
 @return manager with specified UUID
 */
- (KTKManager *)getManagerWithUUID:(NSString *)UUID withError:(NSError **)error;

/**
 Returns list of subordinates
 
 @param UUID manager's UUID
 @param error error if operation fails
 
 @return array which is list of manager's subordinates
 */
- (NSArray *)getSubordinatesForManagerByUUID:(NSUUID *)UUID withError:(NSError **)error;


#pragma mark - Venues


/**
 Returns venue for specified UUID
 
 @param venueUUID   venue's UUID that we want to get
 @param error       error if operation fails
 
 @return venue or nil if venue doesn't exist
 */
- (KTKVenue *)venueByUUID:(NSString *)venueUUID withError:(NSError **)error;

/**
 Returns venue's image data for specified venue's UUID
 
 @param venueUUID   venue's UUID for which we want to get image/cover
 @param error       error if operation fails
 
 @return image data or nil
 */
- (NSData *)venueImageDataByUUID:(NSString *)venueUUID withError:(NSError **)error;

/**
 Returns array of venues(KTKVenue objects) for currently logged in manager + public ones
 Can return only public ones if no one is logged in and public ApiKey is provided
 
 @param error error if operation fails
 
 @return array of venues
 */
- (NSArray *)venuesWithError:(NSError **)error;

/**
 Returns BOOL value which tells if CREATE venue operation succeeded
 
 @param name        name for venue
 @param description description for venue
 @param imageData   image as NSData - OPTIONAL(can be nil)
 @param error       error if operation fails
 
 @return YES if venue was successfully created or NO if not
 */
- (BOOL)venueCreateWithName:(NSString *)name description:(NSString *)description andImageData:(NSData *)imageData withError:(NSError **)error;

/**
 Returns BOOL value which tells if DELETED venue operation succeeded
 
 @param venueUUID   vanue's UUID
 @param error       error if operation fails
 
 @return YES if venue was successfully DELETED or NO if not
 */
- (BOOL)venueDeleteByUUID:(NSString *)venueUUID withError:(NSError **)error;

/**
 Returns BOOL value which tells if UPDATE venue operation succeeded
 ALL PARAMS are optional - still there must be at least one none nil value to make an update
 
 @param venueUUID   vanue's UUID
 @param name        name for venue
 @param description description for venue
 @param imageData   image as NSData - OPTIONAL(can be nil)
 @param error       error if operation fails
 
 @return YES if venue was successfully UPDATED or NO if not
 */
- (BOOL)venueUpdateByUUID:(NSString *)venueUUID name:(NSString *)name description:(NSString *)description andImageData:(NSData *)imageData withError:(NSError **)error;

/**
 Returns BOOL value which tells if ADDING venue to VERIFICATION operation succeeded
 
 @param venueUUID   vanue's UUID
 @param error       error if operation fails
 
 @return YES if venue was successfully ADDED to VERIFICATION or NO if not
 */
- (BOOL)venueAddToVerificationByUUID:(NSString *)venueUUID withError:(NSError **)error;


#pragma mark - Public


/**
 Returns array of public venues(KTKPublicVenue objects) for currently logged in manager
 
 @param error error if operation fails
 
 @return array of manager's public venues
 */
- (NSArray *)publicVenuesWithError:(NSError **)error;

/**
 Returns public venue(KTKPublicVenue) for currently logged in manager
 
 @param venueUUID   public venue's UUID
 @param error       error if operation fails
 
 @return public venue or nil(if doesn't exist)
 */
- (KTKPublicVenue *)publicVenueByUUID:(NSString *)venueUUID withError:(NSError **)error;

/**
 Returns public beacon(KTKPublicBeacon) by UUID for currently logged in manager
 
 @param beaconUUID  public beacon's UUID
 @param error       error if operation fails
 
 @return public beacon or nil(if doesn't exist)
 */
- (KTKPublicBeacon *)publicBeaconByUUID:(NSString *)beaconUUID withError:(NSError **)error;

/**
 Returns public action(KTKPublicAction) by UUID for currently logged in manager
 
 @param actionUUID  public action's UUID
 @param error       error if operation fails
 
 @return public action or nil(if doesn't exist)
 */
- (KTKPublicAction *)publicActionByUUID:(NSString *)actionUUID withError:(NSError **)error;

/**
 Returns BOOL value which tells if UPDATE venue operation succeeded
 
 @param venueUUID   vanue's UUID
 @param status      venue's status - VERIFIED, REJECTED (may be changed by user with verifier role), PUBLISHED, VERIFIED (may be changed by manager)
 @param message     some message - OPTIONAL
 @param error       error if operation fails
 
 @return YES if venue was successfully UPDATED or NO if not
 */
- (BOOL)publicVenueUpdateByUUID:(NSString *)venueUUID status:(NSString *)status andMessage:(NSString *)message withError:(NSError **)error;

/**
 Returns BOOL value which tells if DELETE venue operation succeeded
 
 @param venueUUID   vanue's UUID
 @param error       error if operation fails
 
 @return YES if venue was successfully DELETED or NO if not
 */
- (BOOL)publicVenueDeleteByUUID:(NSString *)venueUUID withError:(NSError **)error;


#pragma mark - Requests


/**
 Returns properly signed request(without API key attached/in header - atm for authentication) to 
 specified endpoint's category and it's subcategory. You can use this method to create custom requests.
 
 @param     category    endpoint's category like @"manager"
 @param     subcategory endpoint's subcategory(which is related to its category) like @"authenticate"
 @return    return      signed request
 */
- (NSMutableURLRequest *)createRequestWithoutApiKeyToEndpointCategory:(NSString *)category
                                                       andSubcategory:(NSString *)subcategory;

/**
 Returns properly signed request to specified endpoint's category and it's subcategory. You can use this method to create custom requests.
 
 @param     category    endpoint's category like @"action"
 @param     subcategory endpoint's subcategory(which is related to its category) like @":id/content"
 @return    return      signed request
 */
- (NSMutableURLRequest *)createRequestToEndpointCategory:(NSString *)category andSubcategory:(NSString *)subcategory;

/**
 Returns properly signed request to specified endpoint. You can use this method to create custom requests.
 
 @param endpoint endpoint
 @return return signed request
 */
- (NSMutableURLRequest *)createRequestToEndpoint:(NSString *)endpoint;

/**
 Sends request to API. You can use this methods to execute custom requests.
 
 @param request request to be sent
 @param error error if opertaion fails
 @return data returned by API
 */
- (NSData *)sendRequest:(NSURLRequest *)request error:(NSError **)error;

@end
