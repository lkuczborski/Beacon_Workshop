//
//  ViewController.m
//  Colors
//
//  Created by Lukasz Kuczborski on 21.01.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"
#import "BeaconHandler.h"

@interface ViewController ()

@property Beacon *rBeacon;
@property Beacon *gBeacon;
@property Beacon *bBeacon;

@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
