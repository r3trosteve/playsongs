    //
//  FavouriteCategoriesViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouriteCategoriesViewController.h"
#import "UIDevice+Hardware.h"

@implementation FavouriteCategoriesViewController

@synthesize playlists;
@synthesize context;
@synthesize categoryNameField;
@synthesize addAlert;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}
*/


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) 
		return;
    if (page >= [playlists count]) 
		return;
	
	UIView *view = [categoryViews objectAtIndex:page];
	
    if ((NSNull *)view == [NSNull null]) {
		view = [[UIView alloc] init];
		[categoryViews replaceObjectAtIndex:page withObject:view];
    }
	
    // add the view to the scroll view
    if (view.superview == nil) {
        CGRect frame = scrollView.frame;
		
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud_big.png"]] autorelease];
		
		view.frame = CGRectMake(floor(frame.size.width * page +(frame.size.width - imageView.frame.size.width)/2), floor((frame.size.height - imageView.frame.size.height)/2), imageView.frame.size.width, imageView.frame.size.height);
		
		UIButton *cloud = [UIButton buttonWithType:UIButtonTypeCustom];
		[cloud setBackgroundImage:[UIImage imageNamed:@"cloud_big.png"] forState:UIControlStateNormal];
		cloud.frame = view.bounds;
		//[button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
		
		UILabel *label = [[[UILabel alloc] init] autorelease];
		label.numberOfLines = 1;
		label.adjustsFontSizeToFitWidth = YES;
		label.text = [[playlists objectAtIndex:page] title];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
		
		
		if ([UIDevice isIPad]) {
			label.font = [UIFont systemFontOfSize:48];
			button.frame = CGRectMake(420, 45, 83, 79);
			label.frame = CGRectMake(60, 0, floor(view.frame.size.width) - 100, floor(view.frame.size.height));
		}
		else {
			label.font = [UIFont systemFontOfSize:24];
			button.frame = CGRectMake(210, 22, 41, 39);
			label.frame = CGRectMake(30, 0, floor(view.frame.size.width - 50), floor(view.frame.size.height));
		}

		[view addSubview:cloud];
		[view addSubview:label];
		[view addSubview:button];
		[scrollView addSubview:view];
	}
	
}

-(void)delete:(id)sender{
	for (UIView *view in [scrollView subviews]) {
		if([[view subviews] objectAtIndex:2] == (UIButton *)sender){
			deleteIndex = [[scrollView subviews] indexOfObject:view];
			break;
		}
	}
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Delete playlist" message:@"Are you sure you want to delete this favourite category?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil] autorelease];
	alert.tag = 1;
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 1) {
		if (buttonIndex == 0) {
			Playlist *playlist = [playlists objectAtIndex:deleteIndex];
			[self.context deleteObject:playlist];
			NSError *error = nil;
			if ([self.context save:&error]) {
				[self loadScrollViewWithPage:deleteIndex + 2];
				[playlists removeObjectAtIndex:deleteIndex];
				
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationDuration:0.3];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				
				[[[scrollView subviews] objectAtIndex:deleteIndex] removeFromSuperview];
				scrollView.contentSize = CGSizeMake(scrollView.contentSize.width - self.view.frame.size.width, scrollView.contentSize.height);
				for (NSInteger i = deleteIndex; i < [[scrollView subviews] count]; i++) {
					UIView *view = [[scrollView subviews] objectAtIndex:i];
					view.frame = CGRectMake(view.frame.origin.x - self.view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
				}	
				[UIView commitAnimations];
				
				[categoryViews removeObjectAtIndex:deleteIndex];
			}
			 else{
				 [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry there was an error deleting the category" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
			 }
		}
	}
	else {
		if (buttonIndex == 1) {
			Playlist *playlist = [NSEntityDescription insertNewObjectForEntityForName:@"Playlist" inManagedObjectContext:context];
			playlist.title = categoryNameField.text;
			NSError *error;
			if (![context save:&error]) {
				[[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry there was an error adding the category" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
			}
			else {
				[playlists addObject:playlist];
				[categoryViews addObject:[NSNull null]];
				scrollView.contentSize = CGSizeMake(scrollView.contentSize.width + self.view.frame.size.width, scrollView.contentSize.height);
				for (NSInteger i = 0; i< [playlists count]; i++) {
					[self loadScrollViewWithPage:i];
				}
				[scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width * ([playlists count]-1), scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
			}

		}
	}

}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [playlists count], scrollView.frame.size.height);

	categoryViews = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < [playlists count]; i++) {
		[categoryViews addObject:[NSNull null]];
	}
	
	[self loadScrollViewWithPage:0];
	[self loadScrollViewWithPage:1];
}



- (void)viewWillAppear:(BOOL)animated {
	// to fix the controller showing under the status bar
	self.view.frame = [[UIScreen mainScreen] applicationFrame];
}


-(IBAction)addFavCategory:(id)sender{
	self.addAlert = [[UIAlertView alloc] initWithTitle:@"Add a favourite category" message:@"\n\n\n" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"add", nil];
	self.categoryNameField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 60, 250, 30)] autorelease];
	categoryNameField.placeholder = @"Category name";
	[categoryNameField setDelegate:self];
	[categoryNameField setBorderStyle:UITextBorderStyleRoundedRect];
	[categoryNameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];

	addAlert.tag = 2;
	[addAlert addSubview:categoryNameField];
	[addAlert show];
	[self performSelector:@selector(focus:) withObject:nil afterDelay:0.2];

}


-(void)focus:(id)sender{
	[categoryNameField becomeFirstResponder];
}


-(IBAction)backToMenu:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark scrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}


#pragma mark -
#pragma mark UITextField delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[addAlert resignFirstResponder];
	[categoryNameField resignFirstResponder];
	return YES;	
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
	[playlists release];
	[categoryNameField release];
	[categoryViews release];
	[context release];
    [super dealloc];
}


@end
