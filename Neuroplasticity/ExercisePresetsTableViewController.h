//
//  ExercisePresetsTableViewController.h
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ExercisePresetsTableViewController : UITableViewController

@property (nonatomic, strong) PFObject *selectedPlaylistObject;

@end
