// 
//  Playlist.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Playlist.h"
#import "Song.h"

@implementation Playlist 

@dynamic title;
@dynamic favouriteSong;

+(NSArray *)getPlaylists:(NSManagedObjectContext *)context{
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Playlist" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSError *error;
	NSArray *playlists = [context executeFetchRequest:fetchRequest error:&error];
	return playlists;
}

@end
