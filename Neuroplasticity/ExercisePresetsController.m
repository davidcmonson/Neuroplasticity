//
//  ExercisePresetsDataSource.m
//  Neuroplasticity
//
//  Created by David Monson on 4/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ExercisePresetsController.h"
#import "ExercisePresetsTableViewController.h"
#import <Parse/Parse.h>

@interface ExercisePresetsController ()

@end


@implementation ExercisePresetsController 

+ (ExercisePresetsController *)sharedInstance {
    static ExercisePresetsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ExercisePresetsController new];
    });    
    return sharedInstance;
}


-(void)queryForPresetExercisesWithCompletion:(void (^)(BOOL completion))weAreDone
{
    PFQuery *query = [PFQuery queryWithClassName:@"Default"];
    [query getObjectInBackgroundWithId:@"UYs0sixfYO" block:^(PFObject *object, NSError *error) {
        PFFile *file = object[@"exercises"];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"ExercisePresetsController is getting data?: %@", dictionary[@"pursuits"] [0]);
            self.dictionary = dictionary;
            weAreDone(YES);
            
        }];
    }];
}

@end
