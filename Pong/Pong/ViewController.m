//
//  ViewController.m
//  Pong
//
//  Created by Lukasz Kuczborski on 04.02.2015.
//  Copyright (c) 2015 ACME. All rights reserved.
//

#import "ViewController.h"

static NSInteger const kPalletHeight = 20;
static NSInteger const kPalletWidth = 80;

@interface ViewController ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic) UIView *pallet;
@property (nonatomic) UIView *ball;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(self.width/2, self.height/2, 20, 20)];
    [self.ball setBackgroundColor:[UIColor whiteColor]];
    
    self.pallet = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kPalletHeight, kPalletWidth, kPalletHeight)];
    [self.pallet setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.ball];
    [self.view addSubview:self.pallet];
}

- (void)movePalletBy:(CGFloat)distance {
    
    CGFloat currentX = self.pallet.frame.origin.x;
    
    currentX += distance;
    
    if (currentX < 0)
        currentX = 0;
    
    if (currentX > self.width - kPalletWidth)
        currentX = self.width - kPalletWidth;
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.pallet.frame;
        frame.origin.x = currentX;
        self.pallet.frame = frame;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
