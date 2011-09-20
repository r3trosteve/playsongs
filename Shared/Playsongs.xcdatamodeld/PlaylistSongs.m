// 
//  PlaylistSongs.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaylistSongs.h"


@implementation PlaylistSongs 

@dynamic songId;
@dynamic songOrder;
@dynamic playlistId;


+(NSMutableArray *)getOrderedSongs:(Playlist *)playlist context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@", playlistId];
	
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"songOrder" ascending:YES];
	
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	return [[results mutableCopy] autorelease];

}

+(PlaylistSongs *)getEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSString *songId = [[[song objectID] URIRepresentation] absoluteString];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@ AND songId = %@", playlistId, songId];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:1];
	
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	if (results.count == 1) {
		return [results objectAtIndex:0];
	}
	return nil;	
	
}


+(NSInteger)createEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSString *songId = [[[song objectID] URIRepresentation] absoluteString];
	
	PlaylistSongs *entry = [NSEntityDescription insertNewObjectForEntityForName:@"PlaylistSongs" inManagedObjectContext:context];
	entry.playlistId = playlistId;
	entry.songId = songId;
	
	//Put the ordering at the end.
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@", playlistId];
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"songOrder" ascending:NO];
	
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:1];
	
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	NSInteger maxVal = 0;
	if (results.count == 1) {
		maxVal = [[(PlaylistSongs *)[results objectAtIndex:0] songOrder] intValue];
	}
	maxVal++;	
	entry.songOrder = [NSNumber numberWithInt:maxVal];

	if (![context save:&error]) {
	}
	return maxVal;
}


+(void)deleteEntryForPlaylist:(Playlist *)playlist song:(Song *)song context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSString *songId = [[[song objectID] URIRepresentation] absoluteString];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@ AND songId = %@", playlistId, songId];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:1];
	
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	if (results.count == 1) {
		[context deleteObject:[results objectAtIndex:0]];
		NSError *error = nil;
		if ([context save:&error]) {
		}
	}
}


+(void)deleteAllEntriesForPlaylist:(Playlist *)playlist context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@", playlistId];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	for(PlaylistSongs *entry in results){
		[context deleteObject:entry];
		NSError *error = nil;
		if ([context save:&error]) {
			
		}
	}
}


+(void)reorderEntryForPlaylist:(Playlist *)playlist song:(Song *)song order:(NSInteger)order context:(NSManagedObjectContext *)context{
	NSString *playlistId = [[[playlist objectID] URIRepresentation] absoluteString];
	NSString *songId = [[[song objectID] URIRepresentation] absoluteString];
	
	PlaylistSongs *theEntry = nil;
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"PlaylistSongs" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playlistId = %@ AND songId = %@", playlistId, songId];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:1];
	
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	
	if (results.count == 1) {
		theEntry = [results objectAtIndex:0];
		theEntry.songOrder = [NSNumber numberWithInt:order];
		NSError *error = nil;
		if ([context save:&error]) {
		}
	}
	
}


@end
