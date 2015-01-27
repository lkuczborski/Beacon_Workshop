//
//  ViewController.m
//  Colors
//
//  Created by Lukasz Kuczborski on 21.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"

static NSString *const RED_UUID   = @"430F6ED4-7E4F-4F63-85C7-845763861A55";
static NSString *const BLUE_UUID  = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString *const GREEN_UUID = @"3A7E7514-A9AC-41F3-A236-3CFCE75BAC95";

@interface ViewController () <BeaconEventHandler>

@property (nonatomic, strong) BeaconHandler *handler;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self setupBeaconHandler];
}

- (IBAction)switchTeam:(UIControl *)sender {
}
- (CGFloat)getComponentValueFromBeacon:(Beacon *)beacon {

	// http://stn.spotfire.com/spotfire_client_help/norm/norm_scale_between_0_and_1.htm
	CGFloat normalized = fabsl(beacon.accuracy - beacon.accuracyMin) / fabsl(beacon.accuracyMax - beacon.accuracyMin);
	
	// some more hints using proximity
	if (beacon.proximity == CLProximityImmediate) {
		normalized += 0.5;
	}
	else if (beacon.proximity == CLProximityUnknown) {
		normalized -= 0.1;
	}
	else if (beacon.proximity == CLProximityNear){
		normalized += 0.1;
	}
	
	// checking the bounds again...
	if (normalized < 0) {
		normalized = 0.0001;
	}
	
	if (normalized > 1) {
		normalized = 1;
	}
	
    return normalized;
}

- (void)animateToColor:(UIColor*)color {

    //TODO: find a nice way to animate this...
	[UIView animateWithDuration:0.5
						  delay:0
						options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 self.view.layer.backgroundColor = color.CGColor;
					 } completion:nil];
}

#pragma mark - BeaconHandler

- (void)setupBeaconHandler {
	NSArray *regions = @[
						 [[BeaconRegion alloc] initWithUUID:RED_UUID
													   name:@"Estimote Mint Cocktail"],
						 [[BeaconRegion alloc] initWithUUID:BLUE_UUID
													   name:@"Estimote Icy Marshmallow"],
						 [[BeaconRegion alloc] initWithUUID:GREEN_UUID
													   name:@"Estimote Blueberry Pie"]
						 ];
	
	self.handler = [[BeaconHandler alloc] initWithBeaconRegions:regions
													   delegate:self];
	
	[self.handler start];
}

#pragma mark - BeaconEventHandler

- (void)beaconHandler:(BeaconHandler *)handler
	 didUpdateBeacons:(NSArray *)beacons {
	
	UIColor *currentColor = [UIColor colorWithCGColor:self.view.layer.backgroundColor];
	CGFloat r = 0.f;
	CGFloat g = 0.f;
	CGFloat b = 0.f;
	CGFloat a = 1.f;
	[currentColor getRed:&r green:&g blue:&b alpha:&a];
	r *= 0.9; g *= 0.9; b *= 0.9; 
	for (Beacon *beacon in beacons) {
		if ([beacon.uuid isEqualToString:RED_UUID]) {
			r = [self getComponentValueFromBeacon:beacon];
		} else if ([beacon.uuid isEqualToString:GREEN_UUID]) {
			g = [self getComponentValueFromBeacon:beacon];
		} else if ([beacon.uuid isEqualToString:BLUE_UUID]) {
			b = [self getComponentValueFromBeacon:beacon];
		}
	}
	
	NSLog(@"%s\t :  R:%.2f G:%.2f B:%.2f", __PRETTY_FUNCTION__, r, g, b);
	[self animateToColor:[UIColor colorWithRed:r green:g blue:b alpha:a]];
}

@end
