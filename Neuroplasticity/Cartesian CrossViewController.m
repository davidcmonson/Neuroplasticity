//
//  Cartesian CrossViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/8/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Cartesian CrossViewController.h"

@interface Cartesian_CrossViewController ()

@end

@implementation Cartesian_CrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int circleSize = 60;
    int circleRadius = circleSize/2;
    int centerX = self.view.frame.size.width/2 - circleRadius;
    int centerY = self.view.frame.size.height/2 - circleRadius;
    int bufferFromCenter = circleSize *2.6;
    UIColor *circleColor = [UIColor blackColor];
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
