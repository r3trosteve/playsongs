//
//  FavouriteSongsViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "Playlist.h"
#import "PlaylistSongs.h"

@class AppDelegate_Shared;

#define ITEMS_PER_PAGE_IPHONE	6
#define ROWS_PER_PAGE_IPHONE	2
#define ITEMS_PER_PAGE_IPAD		12
#define ROWS_PER_PAGE_IPAD		4

@interface FavouriteSongsViewController : TTViewController <TTLauncherViewDelegate> {
	TTLauncherView* _launcherView;
	Playlist *playlist;
	NSMutableArray *playlistSongs;
	NSManagedObjectContext *context;
	NSPersistentStoreCoordinator *coordinator;
}


@property (nonatomic, retain) Playlist *playlist;

-(NSArray *)getLauncherItems;
-(IBAction)back:(id)sender;

@end
