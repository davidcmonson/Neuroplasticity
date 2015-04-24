//
//  HemistimViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/7/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "HemistimViewController.h"
@import QuartzCore;

typedef NS_ENUM(NSUInteger, BoxSize) {
    BoxSizeSmallest,
    BoxSizeSmall,
    BoxSizeMedium,
    BoxSizeLarge,
    BoxSizeLargest,
};

typedef NS_ENUM(NSUInteger, BoxColor) {
    BoxColorRed,
    BoxColorBlue,
    BoxColorGreen,
    BoxColorOrange,
    BoxColorPurple,
};

static NSString * const nameKey = @"name";
static NSString * const identifierKey = @"identifier";
static NSString * const movementDirectionKey = @"movementDirection";
static NSString * const targetTypeKey = @"targetType";
static NSString * const boxColorKey = @"dotColor";
static NSString * const boxSizeKey = @"dotSize";
static NSString * const speedKey = @"speed";
static NSString * const sinusoidalKey = @"sinusoidal";
static NSString * const repetitionsKey = @"repetitions";
static NSString * const initialPauseKey = @"initialPause";
static NSString * const finalPauseKey = @"finalPause";
static NSString * const startPositionKey = @"startPosition";
static NSString * const endPositionKey = @"endPosition";

@interface HemistimViewController ()

@end

@implementation HemistimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.
    
    //set NavBar as hidden initially, can be shown with tap
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self performActivityWithDictionary:self.activity];

    
}

- (void) performActivityWithDictionary:(NSDictionary *)dictionary {
    
    UIView *giantView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width *3, self.view.frame.size.height)];
    [giantView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:giantView];

    
    
    CGFloat numberOfBoxes;
    
    BoxSize chosenBoxSize = [dictionary[boxSizeKey] integerValue];
    
    switch (chosenBoxSize) {
        case BoxSizeSmallest:
            numberOfBoxes = 10;
            break;
        case BoxSizeSmall:
            numberOfBoxes = 8;
            break;
        case BoxSizeMedium:
            numberOfBoxes = 6;
            break;
        case BoxSizeLarge:
            numberOfBoxes = 4;
            break;
        case BoxSizeLargest:
            numberOfBoxes = 2;
            break;
    }
    //insert width code here
    
    UIColor *backgroundColor;
    
    BoxColor chosenBoxColor = [dictionary[boxColorKey] integerValue];
    
    switch (chosenBoxColor) {
        case BoxColorBlue:
            backgroundColor = [UIColor blueColor];
            break;
        case BoxColorGreen:
            backgroundColor = [UIColor greenColor];
            break;
        case BoxColorOrange:
            backgroundColor = [UIColor orangeColor];
            break;
        case BoxColorPurple:
            backgroundColor = [UIColor purpleColor];
            break;
        case BoxColorRed:
            backgroundColor = [UIColor redColor];
            break;
    }
    
    UIColor *rectangleColor = backgroundColor;
    float totalRepeats = 500.0;
    float duration = 2;

    int columns = numberOfBoxes;
    int rows = numberOfBoxes;
    float boxWidth = (self.view.frame.size.width) / columns;
    float boxHeight = (self.view.frame.size.height) / rows;
    NSNumber *boxWidthNumber = [NSNumber numberWithFloat:boxWidth];
    
    for (int x = 0; x < rows; x++) {
        for (int i = 0; i < columns * 3 ; i++) {
            if (i % 2 == 0 && x % 2 == 0) {
                UIView *boxView = [[UIView alloc] initWithFrame:CGRectMake(0+ (boxWidth * i), 0 + (boxHeight * x), boxWidth, boxHeight)];
                boxView.backgroundColor = rectangleColor;
                [giantView addSubview:boxView];
            }
            if (i % 2 == 1 && x % 2 == 1) {
                UIView *boxView = [[UIView alloc] initWithFrame:CGRectMake(0+ (boxWidth * i), 0 + (boxHeight * x), boxWidth, boxHeight)];
                boxView.backgroundColor = rectangleColor;
                [giantView addSubview:boxView];
            }
        }
    }
    
    //ANIMATION: If the calculationMode is set to kCAAnimationDiscrete, the first value in the array must be 0.0.
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.calculationMode = kCAAnimationDiscrete;
    animation.values = @[ @0, boxWidthNumber, @0, boxWidthNumber];
    animation.keyTimes = @[@0.0, @.5, @1, @1.5];
    animation.duration = duration;
    animation.repeatCount = totalRepeats;
    animation.additive = YES;
    [giantView.layer addAnimation:animation forKey:@"shake"];
    
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
