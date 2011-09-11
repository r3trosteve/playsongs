    //
//  SettingsViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate_Shared.h"

static NSString* kAppId = @"143449775745160";

@implementation SettingsViewController

@synthesize childName;
@synthesize facebook;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.childName = [[NSUserDefaults standardUserDefaults] stringForKey:@"CHILD_NAME"];
		permissions =  [[NSArray arrayWithObjects: @"read_stream", @"publish_stream", @"offline_access",nil] retain];
		facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
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
	[nameField setText:self.childName];
	[nameField setTextColor:[UIColor colorWithRed:0.26f green:0.13f blue:0.055 alpha:1]];
}


- (void)viewWillAppear:(BOOL)animated {
	// to fix the controller showing under the status bar
	self.view.frame = [[UIScreen mainScreen] applicationFrame];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	self.childName = [textField text];
	[textField resignFirstResponder];
	[[NSUserDefaults standardUserDefaults] setObject:self.childName forKey:@"CHILD_NAME"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	return YES;
}


-(IBAction)back:(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)share:(id)sender{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	facebook.accessToken = [defaults objectForKey:ACCESS_TOKEN_KEY];
    facebook.expirationDate = [defaults objectForKey:EXPIRATION_DATE_KEY];
	
	if([facebook isSessionValid]){
		[self publishStream];
	}
	else {
		[facebook authorize:permissions];
	}
}


/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (void)publishStream {
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"http://www.google.com/", @"link",
								   @"http://fbrell.com/f8.jpg", @"picture",
								   @"PlaySongs iOS App", @"name",
								   @"PlaySongs app for iphone and ipad", @"caption",
								   @"PlaySongs is iphone and ipad application for children.", @"description",
								   @"I love PlaySongs",  @"message",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
};


////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
	
}

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:facebook.accessToken forKey:ACCESS_TOKEN_KEY];
	[defaults setObject:facebook.expirationDate forKey:EXPIRATION_DATE_KEY];
	[defaults synchronize];
	
	[self publishStream];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
	[[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, an error occurred while logging in." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
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
	[childName release];
	[nameField release];
	[facebook release];
    [super dealloc];
}


@end
