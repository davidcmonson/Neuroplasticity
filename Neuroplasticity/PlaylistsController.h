//
//  SessionsController.h
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PlaylistsController : NSObject

@property (nonatomic, strong) NSMutableArray *playlistArray;
@property (nonatomic, strong) NSMutableArray *exercisesArray;
@property (nonatomic, strong) PFObject *object;

+ (PlaylistsController *)sharedInstance;

-(void)queryForPlaylistsWithCompletion:(void (^)(BOOL completion))weAreDone;
- (void)createNewPlaylist;
-(void)deletePlaylist:(PFObject *)playlist;
- (void)addExerciseToPlaylist:(NSDictionary *)exercise;
-(void)queryForExercisesWithID:(PFObject *)object WithCompletion:(void (^)(BOOL completion))weAreDone;

@end
