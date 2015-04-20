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



//do all the parse stuff

// make a mutable array of session in order recent to oldest

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
    
    [self queryForPlaylistsWithCompletion:^(BOOL completion) {
        //reload tableview?
    }];
}

-(void)queryForPlaylistsWithCompletion:(void (^)(BOOL completion))weAreDone
{
    PFQuery *queryForPlaylists = [PFQuery queryWithClassName:@"Playlist"];
    [queryForPlaylists whereKey:@"owner" equalTo:[PFUser currentUser]];
    [queryForPlaylists findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.playlistExercisesArray = [NSMutableArray arrayWithArray:objects];
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//            NSLog(@"ExercisePresetsController is getting data?: %@", dictionary[@"pursuits"] [0]);
//            self.dictionary = dictionary;
            weAreDone(YES);
            
    }];
};

-(void)deletePlaylist:(PFObject *)playlist {
    [playlist deleteInBackground];
    [self queryForPlaylistsWithCompletion:^(BOOL completion) {
        //reload tableview?
    }];
}

@end
