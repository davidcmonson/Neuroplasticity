//
//  PursuitsViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/3/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "PursuitsViewController.h"

typedef NS_ENUM(NSUInteger, MovementDirection) {
    MovementDirectionRight,
    MovementDirectionLeft,
    MovementDirectionDown,
    MovementDirectionUp,
    MovementDirectionUpRight,
    MovementDirectionUpLeft,
    MovementDirectionDownRight,
    MovementDirectionDownLeft,
};

typedef NS_ENUM(NSUInteger, TargetType) {
    TargetTypeDot,
    TargetTypeTarget,
    TargetTypeCrosshairs,
    TargetTypeRandom,
};

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

@interface PursuitsViewController ()

@property (nonatomic, strong) NSDictionary *activity;

@end

@implementation PursuitsViewController

- (instancetype)initWithActivity:(NSDictionary *)activity
{
    self = [super init];
    if (self) {
        self.activity = activity;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performActivityWithDictionary:self.activity];

}

- (void) performActivityWithDictionary:(NSDictionary *)dictionary {
    
    //circle Size
    CGFloat circleSize;
    
    switch ((DotSize)dictionary[dotSizeKey]) {
        case DotSizeSmallest:
            circleSize = self.view.frame.size.height/50;
            break;
        case DotSizeSmall:
            circleSize = self.view.frame.size.height/45;
            break;
        case DotSizeMedium:
            circleSize = self.view.frame.size.height/40;
            break;
        case DotSizeLarge:
            circleSize = self.view.frame.size.height/35;
            break;
        case DotSizeLargest:
            circleSize = self.view.frame.size.height/30;
            break;
    }
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleSize, circleSize)];
    circleView.layer.cornerRadius = circleSize / 2;
    [self.view addSubview:circleView];

    // circle color
    
    switch ((DotColor)dictionary[dotColorKey]) {
        case DotColorBlue:
            circleView.backgroundColor = [UIColor blueColor];
            break;
        case DotColorGreen:
            circleView.backgroundColor = [UIColor greenColor];
            break;
        case DotColorOrange:
            circleView.backgroundColor = [UIColor orangeColor];
            break;
        case DotColorPurple:
            circleView.backgroundColor = [UIColor purpleColor];
            break;
        case DotColorRed:
            circleView.backgroundColor = [UIColor redColor];
            break;
    }
    
    // circle animation
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGPoint topLeft = CGPointMake(0, 0);
    CGPoint topCenter = CGPointMake(self.view.center.x, 0);
    CGPoint topRight = CGPointMake(self.view.frame.size.width, 0);
    
    CGPoint leftMiddle = CGPointMake(0, self.view.center.y);
    CGPoint rightMiddle = CGPointMake(self.view.frame.size.width, self.view.center.y);
    
    CGPoint bottomLeft = CGPointMake(0, self.view.frame.size.height);
    CGPoint bottomCenter = CGPointMake(self.view.center.x, self.view.frame.size.height);
    CGPoint bottomRight = CGPointMake(self.view.frame.size.width, self.view.frame.size.height);
    
    CGPoint startLocation;
    CGPoint endLocation;
    
    switch ((MovementDirection)dictionary[movementDirectionKey]) {
        case MovementDirectionDown:
            startLocation = topCenter;
            endLocation = bottomCenter;
            break;
        case MovementDirectionDownLeft:
            startLocation = topRight;
            endLocation = bottomLeft;
            break;
        case MovementDirectionDownRight:
            startLocation = topLeft;
            endLocation = bottomRight;
            break;
        case MovementDirectionLeft:
            startLocation = rightMiddle;
            endLocation = leftMiddle;
            break;
        case MovementDirectionRight:
            startLocation = leftMiddle;
            endLocation = rightMiddle;
            break;
        case MovementDirectionUp:
            startLocation = bottomCenter;
            endLocation = topCenter;
            break;
        case MovementDirectionUpLeft:
            startLocation = bottomRight;
            endLocation = topLeft;
            break;
        case MovementDirectionUpRight:
            startLocation = bottomLeft;
            endLocation = topRight;
            break;
    }


    [animation setFromValue:[NSValue valueWithCGPoint:startLocation]];
    [animation setToValue:[NSValue valueWithCGPoint:endLocation]];
    
    
    // last details
    
    CGFloat animationDuration = 11 - [dictionary[speedKey] floatValue]; // 11 based on 1-10 inverted scale
    [animation setDuration:animationDuration];
    animation.repeatCount = [dictionary[repetitionsKey] floatValue];
    [circleView.layer addAnimation:animation forKey:@"position"];

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
