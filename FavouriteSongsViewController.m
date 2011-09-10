    //
//  FavouriteSongsViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouriteSongsViewController.h"
#import "UIDevice+Hardware.h"

@implementation FavouriteSongsViewController

@synthesize playlist;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        context = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] managedObjectContext];
		coordinator = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] persistentStoreCoordinator];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	playlistSongs = [[PlaylistSongs getOrderedSongs:playlist context:context] retain];
	if ([UIDevice isIPad]) {
		_launcherView = [[TTLauncherView alloc] initWithFrame:CGRectMake(0, 0, 768, 700)];
		_launcherView.columnCount = ROWS_PER_PAGE_IPAD;
	}
	else {
		_launcherView = [[TTLauncherView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
		_launcherView.columnCount = ROWS_PER_PAGE_IPHONE;
	}

	
	_launcherView.backgroundColor = [UIColor clearColor];
	_launcherView.delegate = self;
	
	_launcherView.persistenceMode = TTLauncherPersistenceModeNone;
	
	_launcherView.pages = [self getLauncherItems];	
	[self.view addSubview:_launcherView];
}



- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	
}


- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	
}


- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	
}

- (void)launcherView:(TTLauncherView*)launcher didRemoveItem:(TTLauncherItem*)item{
	[PlaylistSongs deleteEntryForPlaylist:playlist song:(Song *)item.userInfo context:context];
	[playlist removeFavouriteSongObject:(Song *)item.userInfo];
	NSError *error;
	if ([context save:&error]) {
	}
}

- (void)launcherView:(TTLauncherView*)launcher didMoveItem:(TTLauncherItem*)item{
	for (NSArray* page in _launcherView.pages) {
		for (TTLauncherItem* anItem in page) {
			NSIndexPath *indexPath = [_launcherView indexPathOfItem:anItem];
			if ([UIDevice isIPad]) {
				[PlaylistSongs reorderEntryForPlaylist:playlist song:(Song *)anItem.userInfo order:(indexPath.section * ITEMS_PER_PAGE_IPAD + indexPath.row + 1) context:context];
			}
			else {
				[PlaylistSongs reorderEntryForPlaylist:playlist song:(Song *)anItem.userInfo order:(indexPath.section * ITEMS_PER_PAGE_IPHONE + indexPath.row + 1) context:context];

			}
			PlaylistSongs *entry = [PlaylistSongs getEntryForPlaylist:playlist song:(Song *)anItem.userInfo context:context];
			NSLog(@"%d", [entry.songOrder intValue]);
			NSLog(@"%@", ((Song *)anItem.userInfo).title);
		}
	}
}


-(NSArray *)getLauncherItems{
	NSMutableArray *pages = [NSMutableArray array];
	NSMutableArray *items = [NSMutableArray array];
	NSInteger currentPage = 0;
	for(PlaylistSongs *entry in playlistSongs){
		NSInteger page = 0;
		if ([UIDevice isIPad]) {
			page = [playlistSongs indexOfObject:entry]/ITEMS_PER_PAGE_IPAD;
		}
		else {
			page = [playlistSongs indexOfObject:entry]/ITEMS_PER_PAGE_IPHONE;
		}
		if (page > currentPage) {
			currentPage++;
			[pages addObject:items];
			items = [NSMutableArray	array];
		}
		
		Song *song = (Song *)[context objectWithID:[coordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:entry.songId]]];
		TTLauncherItem *item = [[[TTLauncherItem alloc] initWithTitle:song.title
																image:@"bundle://star_on.png"
																  URL:entry.songId canDelete:YES] autorelease];
		
		[items addObject:item];
		
		NSLog(@"%d", [entry.songOrder intValue]);
		NSLog(@"%@", song.title);
		
		item.userInfo = song;
	}
	
	[pages addObject:items];
	return pages;
}


-(IBAction)back:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[playlistSongs release];
	[playlist release];
	[_launcherView release];
    [super dealloc];
}


@end
