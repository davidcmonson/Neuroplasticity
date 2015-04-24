//
//  Cartesian CrossViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/8/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "CartesianCrossViewController.h"

typedef NS_ENUM(NSUInteger, DotColor) {
    DotColorRed,
    DotColorBlue,
    DotColorGreen,
    DotColorOrange,
    DotColorPurple,
};

typedef NS_ENUM(NSUInteger, DotSize) {
    DotSizeSmallest,
    DotSizeSmall,
    DotSizeMedium,
    DotSizeLarge,
    DotSizeLargest,
};

static NSString * const nameKey = @"name";
static NSString * const identifierKey = @"identifier";
static NSString * const movementDirectionKey = @"movementDirection";
static NSString * const targetTypeKey = @"targetType";
static NSString * const dotColorKey = @"dotColor";
static NSString * const dotSizeKey = @"dotSize";
static NSString * const speedKey = @"speed";
static NSString * const sinusoidalKey = @"sinusoidal";
static NSString * const repetitionsKey = @"repetitions";
static NSString * const initialPauseKey = @"initialPause";
static NSString * const finalPauseKey = @"finalPause";
static NSString * const startPositionKey = @"startPosition";
static NSString * const endPositionKey = @"endPosition";

@interface CartesianCrossViewController ()

@end

@implementation CartesianCrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set NavBar as hidden initially, can be shown with tap
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self performActivityWithDictionary:self.activity];
}

- (void) performActivityWithDictionary:(NSDictionary *)dictionary {
    
    CGFloat circleSize;
    
    DotSize chosenDotSize = [dictionary[dotSizeKey] integerValue];
    
    switch (chosenDotSize) {
        case DotSizeSmallest:
            circleSize = self.view.frame.size.height/30;
            break;
        case DotSizeSmall:
            circleSize = self.view.frame.size.height/25;
            break;
        case DotSizeMedium:
            circleSize = self.view.frame.size.height/22;
            break;
        case DotSizeLarge:
            circleSize = self.view.frame.size.height/20;
            break;
        case DotSizeLargest:
            circleSize = self.view.frame.size.height/18;
            break;
    }
    
    UIColor *circleColor;
    
    DotColor chosenDotColor = [dictionary[dotColorKey] integerValue];
    
    switch (chosenDotColor) {
        case DotColorBlue:
            circleColor = [UIColor blueColor];
            break;
        case DotColorGreen:
            circleColor = [UIColor greenColor];
            break;
        case DotColorOrange:
            circleColor = [UIColor orangeColor];
            break;
        case DotColorPurple:
            circleColor = [UIColor purpleColor];
            break;
        case DotColorRed:
            circleColor = [UIColor redColor];
            break;
    }
    
    float circleRadius = circleSize/2;
    float centerX = self.view.frame.size.width/2 - circleRadius;
    float centerY = self.view.frame.size.height/2 - circleRadius;
    float bufferFromCenter = circleSize *2.6;
    UIColor *backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = backgroundColor;
    
    UIView *centerCircle = [[UIView alloc] initWithFrame:CGRectMake(centerX, centerY, circleSize, circleSize)];
    centerCircle.backgroundColor = circleColor;
    centerCircle.layer.cornerRadius = circleRadius;
    [self.view addSubview:centerCircle];
    
    UIView *topCircle = [[UIView alloc] initWithFrame:CGRectMake(centerX, centerY - bufferFromCenter, circleSize, circleSize)];
    topCircle.backgroundColor = circleColor;
    topCircle.layer.cornerRadius = circleRadius;
    [self.view addSubview:topCircle];
    
    UIView *leftCircle = [[UIView alloc] initWithFrame:CGRectMake(centerX - bufferFromCenter, centerY, circleSize, circleSize)];
    leftCircle.backgroundColor = circleColor;
    leftCircle.layer.cornerRadius = circleRadius;
    [self.view addSubview:leftCircle];
    
    UIView *rightCircle = [[UIView alloc] initWithFrame:CGRectMake(centerX + bufferFromCenter, centerY, circleSize, circleSize)];
    rightCircle.backgroundColor = circleColor;
    rightCircle.layer.cornerRadius = circleRadius;
    [self.view addSubview:rightCircle];
    
    UIView *bottomCircle = [[UIView alloc] initWithFrame:CGRectMake(centerX, centerY + bufferFromCenter, circleSize, circleSize)];
    bottomCircle.backgroundColor = circleColor;
    bottomCircle.layer.cornerRadius = circleRadius;
    [self.view addSubview:bottomCircle];
}

-(void) showHideNavbar:(id) sender
{
    // write code to show/hide nav bar here
    // check if the Navigation Bar is shown
    if (self.navigationController.navigationBar.hidden == NO)
    {
        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    // if Navigation Bar is already hidden
    else if (self.navigationController.navigationBar.hidden == YES)
    {
        // Show the Navigation Bar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
