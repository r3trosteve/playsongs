    //
//  MainMenuViewControllerIPad.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewControllerIPad.h"


@implementation MainMenuViewControllerIPad

@synthesize songsController;
@synthesize favController;
@synthesize settingsController;


-(IBAction)viewPlaySongs:(id)sender{
	self.songsController = [[[SongsViewControllerIpad alloc] initWithNibName:@"SongsViewControllerIpad" bundle:nil] autorelease];
	songsController.isLullaby = NO;
	songsController.songs = [Song getSongs:NO managedObjectContext:self.context];
	[self.navigationController pushViewController:songsController animated:YES];
}


-(IBAction)viewLullabies:(id)sender{
	self.songsController = [[[SongsViewControllerIpad alloc] initWithNibName:@"SongsViewControllerIpad" bundle:nil] autorelease];
	songsController.isLullaby = YES;
	songsController.songs = [Song getSongs:YES managedObjectContext:self.context]; 
	[self.navigationController pushViewController:songsController animated:YES];
}


-(IBAction)viewFavourites:(id)sender{
	self.favController = [[[FavouriteCategoriesViewControllerIpad alloc] initWithNibName:@"FavouriteCategoriesViewControllerIpad" bundle:nil] autorelease];
	favController.context = self.context;
	favController.playlists = [[[Playlist getPlaylists:self.context] mutableCopy] autorelease];
	[self.navigationController pushViewController:favController animated:YES];
}


-(IBAction)viewInstruments:(id)sender{
	
}


-(IBAction)viewSettings:(id)sender{
	self.settingsController = [[[SettingsViewControllerIpad alloc] initWithNibName:@"SettingsViewControllerIpad" bundle:nil] autorelease];
	[self.navigationController pushViewController:settingsController animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
			
		return YES;
	}
	else
		return NO;
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
	[songsController release];
	[favController release];
	[settingsController release];
    [super dealloc];
}


@end
