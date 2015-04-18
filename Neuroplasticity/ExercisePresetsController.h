//
//  ExercisePresetsDataSource.h
//  Neuroplasticity
//
//  Created by David Monson on 4/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExercisePresetsController : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;

+ (ExercisePresetsController *)sharedInstance;
-(void)queryForPresetExercisesWithCompletion:(void (^)(BOOL completion))weAreDone;

@end
