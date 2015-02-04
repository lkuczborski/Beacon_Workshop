//
//  KTKAction.h
//  kontakt-ios-sdk
//
//  Created by Krzysiek Cieplucha on 14/03/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "KTKDataTransferObject.h"


#define ActionProximityImmediate    @"IMMEDIATE"
#define ActionProximityNear         @"NEAR"
#define ActionProximityFar          @"FAR"

#define ActionTypeContent   @"CONTENT"
#define ActionTypeBrowser   @"BROWSER"

#define ActionContentCategoryImage  @"IMAGE"
#define ActionContentCategoryAudio  @"AUDIO"
#define ActionContentCategoryVideo  @"VIDEO"
#define ActionContentCategoryText   @"TEXT"


@protocol KTKBeacon;

/**
 KTKAction is a protocol that should be implemented by any object that represents an action assigned to a beacon.
 */
@protocol KTKAction <KTKDataTransferObject>

/**
 Beacons that this action is assigned to.
 */
@property (strong, nonatomic, readonly) id<KTKBeacon> beacon;

/**
 Content category if action type is CONTENT. Possible values are IMAGE, AUDIO and VIDEO.
 */
@property (strong, nonatomic, readonly) NSString *contentCategory;

/**
 Content type if action type is CONTENT. Possible values are image/png, image/jpeg, image/gif, audio/mp4, audio/mpeg, 
 audio/ogg, audio/webm, video/mpeg, video/mp4, video/ogg and video/webm.
 */
@property (strong, nonatomic, readonly) NSString *contentType;

/**
 URL to content if action type is CONTENT.
 */
@property (strong, nonatomic, readonly) NSString *contentURL;

/**
 Action trigger proximity. Possible values are IMMEDIATE, NEAR and FAR.
 */
@property (strong, nonatomic, readonly) NSString *proximity;

/**
 Type of action. Possible values are CONTENT and BROWSER.
 */
@property (strong, nonatomic, readonly) NSString *type;

/**
 URL to page if action type is BROWSER.
 Valid format of this string is "http://www.google.com" WITH HTTP or HTTPS protocol in front
 */
@property (strong, nonatomic, readonly) NSString *url;

/**
 Data in bytes of action with type == CONTENT. If nil try downloadData.
 */
@property (strong, nonatomic) NSData *contentData;

@end

/**
 KTKAction is a class representing an action assigned to a beacon.
 */
@interface KTKAction : KTKDataTransferObject <KTKAction>

#pragma mark - properties

@property (strong, nonatomic, readwrite) id<KTKBeacon> beacon;
@property (strong, nonatomic, readwrite) NSString *contentCategory;
@property (strong, nonatomic, readwrite) NSString *contentType;
@property (strong, nonatomic, readwrite) NSString *contentURL;
@property (strong, nonatomic, readwrite) NSString *proximity;
@property (strong, nonatomic, readwrite) NSString *type;
@property (strong, nonatomic, readwrite) NSString *url;
@property (strong, nonatomic) NSData *contentData;

#pragma mark - Public

/**
 Downloads action's data - for images/videos.
 If succeeded then property contentData != nil.
 */
- (void)downloadData;

@end
