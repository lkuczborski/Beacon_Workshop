//
//  ViewController.m
//  Pong
//
//  Created by Lukasz Kuczborski on 04.02.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "KontaktSDK.h"

static NSInteger const kPalletHeight = 20;
static NSInteger const kPalletWidth = 80;
static NSString *const kLeftBeaconUUID = @"4B1FA4F9-2857-428E-B60B-89EA901C3AE8";
static NSString *const kRightBeaconUUID = @"F7826DA6-4FA2-4E98-8024-BC5B71E0893E";

@interface ViewController () <UICollisionBehaviorDelegate, KTKLocationManagerDelegate>

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIView *paddleView;
@property (nonatomic, strong) UIView *ballView;

@property (nonatomic, strong) KTKLocationManager *locationManager;


@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *ballPusher;
@property (nonatomic, strong) UIPushBehavior *paddlePusher;
@property (nonatomic, strong) UICollisionBehavior *collider;
@property (nonatomic, strong) UIDynamicItemBehavior *paddleDynamicProperties;
@property (nonatomic, strong) UIDynamicItemBehavior *ballDynamicProperties;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initKontaktSDK];
    [self initViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initBehaviors];
}

- (void)initKontaktSDK {
    self.locationManager = [KTKLocationManager new];
    self.locationManager.delegate = self;
    
    if ([KTKLocationManager canMonitorBeacons]) {
        KTKRegion *region1 =[[KTKRegion alloc] init];
        region1.uuid = kLeftBeaconUUID;
        region1.major = @(14380);
        region1.minor = @(33786);
        
        KTKRegion *region2 =[[KTKRegion alloc] init];
        region2.uuid = kRightBeaconUUID;
        region2.major = @(29700);
        region2.minor = @(42553);
        
        [self.locationManager setRegions:@[region1, region2]];
        [self.locationManager startMonitoringBeacons];
    }
}

- (void)initViews {
    self.width = CGRectGetWidth(self.view.frame);
    self.height = CGRectGetHeight(self.view.frame);
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.ballView = [[UIView alloc] initWithFrame:CGRectMake(self.width/2, self.height/2, 20, 20)];
    [self.ballView setBackgroundColor:[UIColor whiteColor]];
    
    self.paddleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame), self.height - kPalletHeight, kPalletWidth, kPalletHeight)];
    [self.paddleView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.ballView];
    [self.view addSubview:self.paddleView];
}

- (void)initBehaviors {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Start ball off with a push
    self.ballPusher = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
                                                   mode:UIPushBehaviorModeInstantaneous];
    self.ballPusher.pushDirection = CGVectorMake(0.5, 1.0);
    self.ballPusher.active = YES; // Because push is instantaneous, it will only happen once
    [self.animator addBehavior:self.ballPusher];
    
    // Set pusher for paddle
    self.paddlePusher = [[UIPushBehavior alloc] initWithItems:@[self.paddleView]
                                                       mode:UIPushBehaviorModeContinuous];
    self.paddlePusher.pushDirection = CGVectorMake(0.0, 0.0);
    
    [self.animator addBehavior:self.paddlePusher];
    
    // Step 1: Add collisions
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collider];
    
    // Step 2: Remove rotation
    self.ballDynamicProperties = [[UIDynamicItemBehavior alloc]
                                  initWithItems:@[self.ballView]];
    self.ballDynamicProperties.allowsRotation = NO;
    [self.animator addBehavior:self.ballDynamicProperties];
    
    self.paddleDynamicProperties = [[UIDynamicItemBehavior alloc]
                                    initWithItems:@[self.paddleView]];
    self.paddleDynamicProperties.allowsRotation = NO;
    [self.animator addBehavior:self.paddleDynamicProperties];
    
    // Step 3: Heavy paddle
    self.paddleDynamicProperties.density = 1.0f;
    
    // Step 4: Better collisions, no friction
    self.ballDynamicProperties.density = 10.0f;
    self.ballDynamicProperties.elasticity = 1.0;
    self.ballDynamicProperties.friction = 0.0;
    self.ballDynamicProperties.resistance = 0.0;
}

#pragma mark Kontakt.io SDK

- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    NSLog(@"Exit region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
{
    CGFloat distanceFromLeft = 0.f;
    CGFloat distanceFromRight = 0.f;
    NSLog(@"Ranged beacons count: %lu", [beacons count]);
    for (CLBeacon *beacon in beacons) {

        if ([[beacon.proximityUUID UUIDString] isEqualToString:kLeftBeaconUUID]) {
            distanceFromLeft = beacon.accuracy;
        }
        if ([[beacon.proximityUUID UUIDString] isEqualToString:kRightBeaconUUID]) {
            distanceFromRight = beacon.accuracy;
        }
    }
    
    if(distanceFromLeft < distanceFromRight) {
        self.paddlePusher.pushDirection = CGVectorMake(-1.0f, 0.0);
    } else if (distanceFromLeft > distanceFromRight) {
        self.paddlePusher.pushDirection = CGVectorMake(1.0f, 0.0);
    }
}

@end
