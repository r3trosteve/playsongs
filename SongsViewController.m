    //
//  SongsViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SongsViewController.h"
#import "AppDelegate_Shared.h"


@implementation SongsViewController

@synthesize isLullaby;
@synthesize currentPage;
@synthesize songs;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isLullaby = NO;
		self.songs = [NSArray array];
		self.currentPage = 0;
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
		//[song1 setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
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
					break;
				case 1:
					[song2 setTitle:song.title forState:UIControlStateNormal];
					[star2 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star2 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					break;
				case 2:
					[song3 setTitle:song.title forState:UIControlStateNormal];
					[star3 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star3 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
					break;
				case 3:
					[song4 setTitle:song.title forState:UIControlStateNormal];
					[star4 setHidden:NO];
					if ([song.favouritePlaylist count] > 0)
						[star4 setBackgroundImage:[UIImage imageNamed:@"star_on.png"] forState:UIControlStateNormal];
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
	//UIWindow *window = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] window];
//	[[[window subviews] lastObject] removeFromSuperview];
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
		Song *song = [songs objectAtIndex:index];
		
		NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], song.localPath];
		moviePlayer = [[[CustomMoviePlayerViewController alloc] initWithPath:filePath] autorelease];
		
		// Show the movie player as modal
		[self presentModalViewController:moviePlayer animated:YES];
		
		// Prep and play the movie
		[moviePlayer readyPlayer];
	}
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
	[songs release];
    [super dealloc];
}


@end
