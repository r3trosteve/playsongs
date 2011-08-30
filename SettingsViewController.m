    //
//  SettingsViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate_Shared.h"

@implementation SettingsViewController

@synthesize childName;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.childName = [[NSUserDefaults standardUserDefaults] stringForKey:@"CHILD_NAME"];
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
	//UIWindow *window = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] window];
	//[[[window subviews] lastObject] removeFromSuperview];
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
	[childName release];
	[nameField release];
    [super dealloc];
}


@end
