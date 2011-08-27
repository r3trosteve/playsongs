//
//  MainMenuViewControllerIphone.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewControllerIphone.h"


@implementation MainMenuViewControllerIphone

@synthesize songsController;
@synthesize favController;
@synthesize settingsController;

-(IBAction)viewPlaySongs:(id)sender{
	self.songsController = [[[SongsViewControllerIphone alloc] initWithNibName:@"SongsViewControllerIphone" bundle:nil] autorelease];
	songsController.isLullaby = NO;
	songsController.songs = [Song getSongs:NO managedObjectContext:self.context];
	[self.window addSubview:songsController.view];
}


-(IBAction)viewLullabies:(id)sender{
	self.songsController = [[[SongsViewControllerIphone alloc] initWithNibName:@"SongsViewControllerIphone" bundle:nil] autorelease];
	songsController.isLullaby = YES;
	songsController.songs = [Song getSongs:YES managedObjectContext:self.context]; 
	[self.window addSubview:songsController.view];
}


-(IBAction)viewFavourites:(id)sender{

}


-(IBAction)viewInstruments:(id)sender{

}


-(IBAction)viewSettings:(id)sender{
	self.settingsController = [[[SettingsViewControllerIphone alloc] initWithNibName:@"SettingsViewControllerIphone" bundle:nil] autorelease];
	[window addSubview:self.settingsController.view];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
