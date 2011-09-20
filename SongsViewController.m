    //
//  SongsViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SongsViewController.h"
#import "AppDelegate_Shared.h"
#import "AudioPlayerViewController.h"
#import "UIDevice+Hardware.h"

@implementation SongsViewController

@synthesize isLullaby;
@synthesize currentPage;
@synthesize songs;
@synthesize currentSong;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isLullaby = NO;
		self.songs = [NSArray array];
		self.currentPage = 0;
		context = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] managedObjectContext];
		playlists = [[Playlist getPlaylists:context] mutableCopy];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (self.isLullaby) {
		bg.image = [UIImage imageNamed:@"lullaby_bg.png"];
		stick.image = [UIImage imageNamed:@"stick_lullaby.png"];
	}
	
	[song1 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[song1 setTitleShadowColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateHighlighted];
	[song1 setTitleColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateNormal];
	[song1.titleLabel setShadowOffset:CGSizeMake(1, 1)];
	
	[song2 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[song2 setTitleShadowColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateHighlighted];
	[song2 setTitleColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateNormal];
	[song2.titleLabel setShadowOffset:CGSizeMake(1, 1)];
	
	[song3 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[song3 setTitleShadowColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateHighlighted];
	[song3 setTitleColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateNormal];
	[song3.titleLabel setShadowOffset:CGSizeMake(1, 1)];
	
	[song4 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[song4 setTitleShadowColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateHighlighted];
	[song4 setTitleColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1] forState:UIControlStateNormal];
	[song4.titleLabel setShadowOffset:CGSizeMake(1, 1)];
	
	
	
	favFrame = favView.frame;
	favView.frame = CGRectMake(favView.frame.origin.x, self.view.bounds.size.height, favView.frame.size.width, favView.frame.size.height);
	[self pageChanged];
}


- (void)viewWillAppear:(BOOL)animated {
	// to fix the controller showing under the status bar
	self.view.frame = [[UIScreen mainScreen] applicationFrame];
}


-(Song *)songForIndex:(NSInteger)index{
	return [songs objectAtIndex:(currentPage * 4 + index)];
}


-(void)pageChanged{
	for (NSInteger i = 0; i<4; i++) {
		NSInteger index = currentPage * 4 + i;
		
		if(index < [songs count]){
			Song *song = [songs objectAtIndex:index];
			switch (i) {
				case 0:
					[song1 setTitle:song.title forState:UIControlStateNormal];
					[star1 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star1 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					else 
						[star1 setBackgroundImage:[UIImage imageNamed:@"star_off.png"] forState:UIControlStateNormal];
					break;
				case 1:
					[song2 setTitle:song.title forState:UIControlStateNormal];
					[star2 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star2 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					else 
						[star2 setBackgroundImage:[UIImage imageNamed:@"star_off.png"] forState:UIControlStateNormal];
					break;
				case 2:
					[song3 setTitle:song.title forState:UIControlStateNormal];
					[star3 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star3 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					else 
						[star3 setBackgroundImage:[UIImage imageNamed:@"star_off.png"] forState:UIControlStateNormal];
					break;
				case 3:
					[song4 setTitle:song.title forState:UIControlStateNormal];
					[star4 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star4 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					else 
						[star4 setBackgroundImage:[UIImage imageNamed:@"star_off.png"] forState:UIControlStateNormal];
					break;
				default:
					break;
			}
		}
		else {
			switch (i) {
				case 0:
					[song1 setTitle:@"" forState:UIControlStateNormal];
					[star1 setHidden:YES];
					break;
				case 1:
					[song2 setTitle:@"" forState:UIControlStateNormal];
					[star2 setHidden:YES];
					break;
				case 2:
					[song3 setTitle:@"" forState:UIControlStateNormal];
					[star3 setHidden:YES];
					break;
				case 3:
					[song4 setTitle:@"" forState:UIControlStateNormal];
					[star4 setHidden:YES];
					break;
				default:
					break;
			}
		}

	}

}


-(IBAction)nextPage:(id)sender{
	if ((currentPage+1) * 4 < [songs count]){
		currentPage++;
		[self pageChanged];
	}

}	


-(IBAction)previousPage:(id)sender{
	if (currentPage > 0){
		currentPage--;
		[self pageChanged];
	}
}

-(IBAction)backToMenu:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)playSong:(id)sender{
	NSInteger index = 0;
	if ((UIButton *)sender == song1) {
		index = 0;
	}
	else if ((UIButton *)sender == song2) {
		index = 1;
	}
	else if ((UIButton *)sender == song3) {
		index = 2;
	}
	else if ((UIButton *)sender == song4) {
		index = 3;
	}
	index = currentPage * 4 + index;
	if(index < [songs count]){
		//Song *song = [songs objectAtIndex:index];
		
		//NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], song.localPath];
		//moviePlayer = [[[CustomMoviePlayerViewController alloc] initWithPath:filePath] autorelease];
		
		// Show the movie player as modal
		//[self presentModalViewController:moviePlayer animated:YES];
		
		// Prep and play the movie
		//[moviePlayer readyPlayer];
		
		AudioPlayerViewController *audioPlayer;
		if ([UIDevice isIPad]) {
			audioPlayer = [[[AudioPlayerViewController alloc] initWithNibName:@"AudioPlayerViewControllerIpad" bundle:nil] autorelease];
		}
		else{
			audioPlayer = [[[AudioPlayerViewController alloc] initWithNibName:@"AudioPlayerViewControllerIphone" bundle:nil] autorelease];
		}
		
		audioPlayer.songs = songs;
		audioPlayer.index = index;
		
		[self.navigationController pushViewController:audioPlayer animated:YES];
	}
}

-(IBAction)hideFavSelection:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	favView.frame = CGRectMake(favView.frame.origin.x, self.view.bounds.size.height, favView.frame.size.width, favView.frame.size.height);
	[UIView commitAnimations];

}


-(IBAction)showFavSelection:(id)sender{
	
	NSInteger index = 0;
	if ((UIButton *)sender == star1) {
		index = 0;
	}
	else if ((UIButton *)sender == star2) {
		index = 1;
	}
	else if ((UIButton *)sender == star3) {
		index = 2;
	}
	else if ((UIButton *)sender == star4) {
		index = 3;
	}
	
	self.currentSong = [self songForIndex:index];
	[tblView reloadData];

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	favView.frame = favFrame;
	[UIView commitAnimations];
}


-(IBAction)favSelectionDone:(id)sender{
	[self hideFavSelection:nil];

}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return @"";
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [playlists count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [[playlists objectAtIndex:indexPath.row] title];
	cell.detailTextLabel.font = [UIFont fontWithName:@"arial" size:14];
	cell.detailTextLabel.numberOfLines = 1;
	cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
	if ([currentSong.favouritePlaylist containsObject:[playlists objectAtIndex:indexPath.row]]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryNone) {
		[self.currentSong addFavouritePlaylistObject:[playlists objectAtIndex:indexPath.row]];
		NSError *error = nil;
		if ([context save:&error]) {
			[PlaylistSongs createEntryForPlaylist:[playlists objectAtIndex:indexPath.row] song:self.currentSong context:context];
			[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark]; 
		}
	}
	else if([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark){
		[self.currentSong removeFavouritePlaylistObject:[playlists objectAtIndex:indexPath.row]];
		NSError *error = nil;
		if ([context save:&error]) {
			[PlaylistSongs deleteEntryForPlaylist:[playlists objectAtIndex:indexPath.row] song:self.currentSong context:context];
			[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
		}
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self pageChanged];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 35.0;
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
	[song1 release];
	[song2 release];
	[song3 release];
	[song4 release];
	[star1 release];
	[star2 release];
	[star3 release];
	[star4 release];
	[bg release];
	[stick release];
	[next release];
	[previous release];
	[favView release];
	[songs release];
	[currentSong release];
	[tblView release];
    [super dealloc];
}


@end
