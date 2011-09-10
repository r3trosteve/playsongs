//
//  PlaylistSongs.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Playlist.h"
#import "Song.h"

@interface PlaylistSongs :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * songId;
@property (nonatomic, retain) NSNumber * songOrder;
@property (nonatomic, retain) NSString * playlistId;


+(NSMutableArray *)getOrderedSongs:(Playlist *)playlist context:(NSManagedObjectContext *)context;
+(PlaylistSongs *)getEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context;
+(NSInteger)createEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context;
+(void)deleteEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context;
+(void)deleteAllEntriesForPlaylist:(Playlist *)playlist context:(NSManagedObjectContext *)context;
+(void)reorderEntryForPlaylist:(Playlist *)playlist song:(Song *)song order:(NSInteger)order context:(NSManagedObjectContext *)context;
@end



