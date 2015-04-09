//
//  HemistimViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/7/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "HemistimViewController.h"
@import QuartzCore;

@interface HemistimViewController ()

@end

@implementation HemistimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.

    
}
-(void)viewDidAppear:(BOOL)animated {
    UIView *giantView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width *3, self.view.frame.size.height)];
    
    
    //adjustable values////////////////////////////////////
    [giantView setBackgroundColor:[UIColor yellowColor]];//
    UIColor *rectangleColor = [UIColor blueColor];       //
    float totalRepeats = 500.0;                          //
    float duration = 2;                                  //
    int numberOfRectangles = 20;                         //
    ///////////////////////////////////////////////////////
    
    
    int columns = numberOfRectangles;
    int rows = numberOfRectangles;
    float boxWidth = (self.view.frame.size.width) / columns;
    float boxHeight = (self.view.frame.size.height) / rows;
    NSNumber *boxWidthNumber = [NSNumber numberWithFloat:boxWidth];
    
    [self.view addSubview:giantView];

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
