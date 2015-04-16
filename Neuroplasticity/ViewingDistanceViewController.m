//
//  ViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/1/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ViewingDistanceViewController.h"
#import "ViewingDistanceViewController.h"
#import <AVFoundation/AVFoundation.h>
@import Foundation;

@interface ViewingDistanceViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) AVCaptureSession *session;

@end


@implementation ViewingDistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {

    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *camera = [self frontCamera];
    
    AVCaptureDeviceInput *newInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:nil];
    [captureSession addInput:newInput];
    
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    layer.bounds = self.view.bounds;
    layer.bounds = CGRectMake(0, 0, self.view.frame.size.width * 1.6, self.view.frame.size.height);
    layer.position = CGPointMake(CGRectGetMidX(self.view.layer.bounds) + self.view.frame.size.width *.3, CGRectGetMidY(self.view.layer.bounds));
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [layer.connection setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
    
    [self.view.layer addSublayer:layer];
    
    float profileSize = self.view.frame.size.height *1.8;
    
    UIImageView *profileView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - profileSize/2, self.view.frame.size.height/2 - profileSize/3, profileSize, profileSize)];
    profileView.alpha = 0.25;
    UIImage *profileImage = [UIImage imageNamed:@"profile"];
    profileView.image = profileImage;
    
    [self.view addSubview:profileView];

    [captureSession startRunning];
    
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
