//
//  ViewController.m
//  Colors
//
//  Created by Lukasz Kuczborski on 21.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"
#import "BeaconHandler.h"

@interface ViewController () <BeaconEventHandler>

@property Beacon *rBeacon;
@property Beacon *gBeacon;
@property Beacon *bBeacon;

@property (nonatomic, strong) BeaconHandler *handler;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self setupBeaconHandler];
}

- (CGFloat)getComponentValueFromBeacon:(Beacon *)beacon {
    return 0.f;
}

- (void)animateToColor:(UIColor*)color {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.layer.backgroundColor = color.CGColor;
    } completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - BeaconHandler

- (void)setupBeaconHandler {
	NSArray *regions = @[
						 [[BeaconRegion alloc] initWithUUID:@"430F6ED4-7E4F-4F63-85C7-845763861A55"
													   name:@"Estimote Mint Cocktail"],
						 [[BeaconRegion alloc] initWithUUID:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
													   name:@"Estimote Icy Marshmallow"],
						 [[BeaconRegion alloc] initWithUUID:@"3A7E7514-A9AC-41F3-A236-3CFCE75BAC95"
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
	for (Beacon *beacon in beacons) {
		if ([beacon.name isEqualToString:self.rBeacon.name]) {
			r = [self getComponentValueFromBeacon:_rBeacon];
		} else if ([beacon.name isEqualToString:self.gBeacon.name]) {
			r = [self getComponentValueFromBeacon:_bBeacon];
		} else if ([beacon.name isEqualToString:self.bBeacon.name]) {
			r = [self getComponentValueFromBeacon:_gBeacon];
		}
	}
	[self animateToColor:[UIColor colorWithRed:r green:g blue:b alpha:a]];
}

@end
