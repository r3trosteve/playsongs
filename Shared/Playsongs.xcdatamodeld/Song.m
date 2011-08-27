// 
//  Song.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Song.h"

#import "Playlist.h"

@implementation Song 

@dynamic isVideo;
@dynamic isLullaby;
@dynamic title;
@dynamic url;
@dynamic localPath;
@dynamic favouritePlaylist;

+(BOOL)copyDefaultData:(NSManagedObjectContext *)context{
	NSDictionary *songsDictionary = [[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"songs" ofType:@"plist"]] autorelease];
	
	for (NSString *songKey in [songsDictionary allKeys]) {		
		Song *song = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:context];
		
		NSDictionary *songDictionary = [songsDictionary objectForKey:songKey];
		
		song.isLullaby = [songDictionary objectForKey:@"isLullaby"];
		song.isVideo = [songDictionary objectForKey:@"isVideo"];
		song.localPath = [songDictionary objectForKey:@"localPath"];
		song.title = [songDictionary objectForKey:@"title"];
		song.url = [songDictionary objectForKey:@"url"];
		
	}
	NSError *error;
	if (![context save:&error]) {
		return NO;
	}	
	return YES;
	
}

+(NSArray *)getSongs:(BOOL)lullaby managedObjectContext:(NSManagedObjectContext *)context{
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Song" inManagedObjectContext:context];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isLullaby = %@", [NSNumber numberWithBool: lullaby]];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:predicate];
	NSError *error;
	NSArray *cards = [context executeFetchRequest:fetchRequest error:&error];
	return cards;
}
@end
