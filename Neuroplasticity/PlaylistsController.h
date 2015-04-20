//
//  SessionsController.h
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaylistsController : NSObject

@property (nonatomic, strong) NSMutableArray *playlistExercisesArray;

+ (PlaylistsController *)sharedInstance;

-(void)queryForPlaylistsWithCompletion:(void (^)(BOOL completion))weAreDone;
- (void)createNewPlaylist;

@end
