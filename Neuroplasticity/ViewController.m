//
//  ViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/1/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ViewController.h"
@import Foundation;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //rect for circle to be used by bezier path, layer, and view
    CGFloat circleSize = self.view.frame.size.height/25;
    CGRect circleRect = CGRectMake(0, 0, circleSize, circleSize);
    
    UIView *circleView = [[UIView alloc] initWithFrame:circleRect];
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    
    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.bounds = circleRect;
    circleLayer.path = circle.CGPath;
    circleLayer.strokeColor = [UIColor grayColor].CGColor;
    circleLayer.lineWidth = 10;
    circleLayer.backgroundColor =[UIColor clearColor].CGColor;
    
    [self.view addSubview:circleView];
    
    [circleView.layer addSublayer:circleLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(0, self.view.frame.size.height / 2)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height / 2)]];
    [animation setDuration:5.0];
    [animation repeatCount];
    
    [circleView.layer addAnimation:animation forKey:@"position"];
    
    
    //corner radius
    //autolayout
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
