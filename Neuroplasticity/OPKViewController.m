//
//  OPKViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "OPKViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface OPKViewController ()

@end

@implementation OPKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *giantView = [[UIView alloc] initWithFrame:CGRectMake(- self.view.frame.size.width, - self.view.frame.size.height, self.view.frame.size.width * 3, self.view.frame.size.height * 3)];

    double rads = DEGREES_TO_RADIANS(-45);
    giantView.transform = CGAffineTransformMakeRotation(rads);
    
    [giantView setBackgroundColor:[UIColor whiteColor]];
    CGFloat rectangleWidth = giantView.bounds.size.width / 20;
    UIColor *backgroundColor = [UIColor redColor];
    float totalRepeats = 500.0;
    float duration = 10;
    
    for (int rectangleStartingPoint = 0; rectangleStartingPoint < giantView.bounds.size.width; (rectangleStartingPoint += rectangleWidth * 2)) {
        UIView *rectangleView = [[UIView alloc] initWithFrame:CGRectMake(giantView.bounds.origin.x, giantView.bounds.origin.y, rectangleWidth, giantView.bounds.size.height)];
        rectangleView.backgroundColor = backgroundColor;
        
        [self.view addSubview:giantView];
        [giantView addSubview:rectangleView];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(giantView.bounds.origin.x + rectangleStartingPoint, giantView.bounds.size.height/2)]];
        [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(giantView.bounds.origin.x + rectangleStartingPoint + rectangleWidth * 2, giantView.bounds.size.height/2)]];
        CGFloat animationDuration = duration; // 11 based on 1-10 inverted scale
        [animation setDuration:animationDuration];
        animation.repeatCount = totalRepeats;
        [rectangleView.layer addAnimation:animation forKey:@"position"];
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
