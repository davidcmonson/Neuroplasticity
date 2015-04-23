//
//  SessionsController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "PlaylistsController.h"
#import <Parse/Parse.h>

@interface PlaylistsController ()

@end

@implementation PlaylistsController

+ (PlaylistsController *)sharedInstance {
    static PlaylistsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PlaylistsController new];
    });
    return sharedInstance;
}

- (void)createNewPlaylist {
    PFObject *playlist = [PFObject objectWithClassName:@"Playlist"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    NSDate *currentDate = [NSDate date];
    NSMutableArray *playlistExercisesArray = [NSMutableArray new];
    playlist[@"name"] = @"Playlist";
    playlist[@"owner"] = [PFUser currentUser];
    playlist[@"dateCreated"] = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"Created: %@", [dateFormatter stringFromDate:currentDate]]];
    playlist[@"playlistArray"] = playlistExercisesArray;
    [playlist saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"New playlist saved to Parse");
        } else {
            NSLog(@"error saving playlist to Parse: %@", error.description);
        }
    }];
}

-(void)queryForPlaylistsWithCompletion:(void (^)(BOOL completion))weAreDone
{
    PFQuery *queryForPlaylists = [PFQuery queryWithClassName:@"Playlist"];
    [queryForPlaylists whereKey:@"owner" equalTo:[PFUser currentUser]];
//    [queryForPlaylists selectKeys:@[@"playlistArray"]];  does this limit me?
    [queryForPlaylists findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.playlistArray = [NSMutableArray arrayWithArray:objects];
            weAreDone(YES);
            
    }];
};

-(void)deletePlaylist:(PFObject *)playlist {
    [playlist deleteInBackground];
    [self queryForPlaylistsWithCompletion:^(BOOL completion) {
        //reload tableview?
        NSLog(@"Object deleted from parse");
    }];
}

- (void)addExerciseToPlaylist:(NSDictionary *)exercise {
    self.exercisesArray = self.object[@"playlistArray"];
    [self.exercisesArray addObject:exercise];
#warning add object to array not quite working...
    PFQuery *query = [PFQuery queryWithClassName:@"Playlist"];
    [query getObjectInBackgroundWithId:self.object.objectId block:^(PFObject *playlist, NSError *error) {
        playlist[@"playlistArray"] = self.exercisesArray;
        [playlist saveInBackground];
        
    }];
        
}

- (void)removeExerciseFromPlaylist:(NSDictionary *)exercise {
    
}

-(void)queryForExercisesWithID:(PFObject *)object WithCompletion:(void (^)(BOOL completion))weAreDone
{
    PFQuery *queryForExercises = [PFQuery queryWithClassName:@"Playlist"];
    [queryForExercises whereKey:@"objectId" equalTo:object];
    self.object = object;
    [queryForExercises findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.exercisesArray = [NSMutableArray arrayWithArray:objects];
        weAreDone(YES);
        
    }];
};

@end
