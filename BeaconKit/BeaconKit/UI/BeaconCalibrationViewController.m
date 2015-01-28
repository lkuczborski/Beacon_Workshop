//
//  BeaconCalibrationViewController.m
//  BeaconKit
//
//  Created by Lukasz Stocki on 28.01.2015.
//  Copyright (c) 2015 Allegro Group. All rights reserved.
//

#import "BeaconCalibrationViewController.h"

@interface BeaconCalibrationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconBaseInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, strong) NSArray *beaconsToCalibrate;

@property (nonatomic, weak) id <BeaconEventHandler> oryginalEventHandler;

@property (nonatomic, strong) Beacon *currentBeacon;


@end

@implementation BeaconCalibrationViewController

#pragma mark - Mutators

- (void)setBeaconProvider:(id<BeaconProvider>)beaconProvider
{
	BOOL isValidBeaconProvider = [self validateBeaconProvider:beaconProvider];
	if (isValidBeaconProvider) {
		
		_beaconProvider = beaconProvider;
	}
	else {
		NSLog(@"BeaconProvider is not valid :(");
	}
}

#pragma mark - User Actions

- (IBAction)userDidTapButtonHide:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (IBAction)userDidTapCalibrateBeaconButton:(id)sender {
}

#pragma mark - Calibration
- (void)calibrationStart
{
	[self becomeTheEventHandlerForBeaconHandler];
	
	self.beaconsToCalibrate = [self.beaconProvider beaconsToCalibrate];
	NSUInteger beaconsCount = self.beaconsToCalibrate.count;
	
	for (NSUInteger index = 0; index < beaconsCount; beaconsCount++) {
		
	}
}

- (void)calibrationStop
{
	self.beaconHandler.delegate = self.oryginalEventHandler;
}

- (void)becomeTheEventHandlerForBeaconHandler
{
	self.oryginalEventHandler = self.beaconHandler.delegate;
	self.beaconHandler.delegate = self;
}

#pragma mark - Helper Methods
- (BOOL)validateBeaconProvider:(id<BeaconProvider>)beaconProvider
{
	return [beaconProvider respondsToSelector:@selector(beaconsToCalibrate)];
}

#pragma mark - Beacon Event Handler
- (void)beaconHandler:(BeaconHandler *)handler
	 didUpdateBeacons:(NSArray *)beacons
{
	
}

@end
