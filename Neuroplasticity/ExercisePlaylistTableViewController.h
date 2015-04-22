//
//  ExercisePlaylistTableViewController.h
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ExercisePlaylistTableViewController : UITableViewController

@property (nonatomic, strong) NSString *titleLabel;
@property (nonatomic, strong) NSMutableArray *playlistArray;
@property (nonatomic, strong) PFObject *selectedPlaylistObject;

@end
