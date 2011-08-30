    //
//  HomeAnimationController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeAnimationController.h"
#import "UIDevice+Hardware.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate_Shared.h"

@implementation HomeAnimationController


@synthesize mmIphone;
@synthesize mmIpad;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//Prepare UI
	UIImageView *img = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.png"]] autorelease];
	img.frame = self.view.bounds;
	[self.view addSubview:img];
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showLogoAnimation) userInfo:nil repeats:NO];
}


-(void)showLogoAnimation{
	UIImageView *logo = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]] autorelease];
	UIImageView *logoText = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_text.png"]] autorelease];
	
	logo.frame = CGRectMake((self.view.bounds.size.width - logo.frame.size.width) / 2, - logoText.frame.size.width - 50 - logoText.frame.size.height , logo.frame.size.width, logo.frame.size.height);
	logoText.frame = CGRectMake((self.view.bounds.size.width - logoText.frame.size.width) / 2,- logoText.frame.size.height, logoText.frame.size.width, logoText.frame.size.height);
	
	[self.view addSubview:logo];
	[self.view  addSubview:logoText];
	
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedlogoAnimation:finished:context:)];
	logo.frame = CGRectMake(logo.frame.origin.x, 15 , logo.frame.size.width, logo.frame.size.height);
	
	NSInteger yPosition;
	if ([UIDevice isIPad]) {
		yPosition = logo.frame.origin.x + logo.frame.size.height - 230;
    } else {
		yPosition = logo.frame.origin.x + logo.frame.size.height - 85;
    }
	
	logoText.frame = CGRectMake(logoText.frame.origin.x, yPosition , logoText.frame.size.width, logoText.frame.size.height);
	
	
	[UIView commitAnimations];
	
}

-(void)finishedlogoAnimation:(NSString*)animationID finished:(BOOL)finished context:(void*)context{
	UIImageView *text = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nickie_jill.png"]] autorelease];
	
	NSInteger yPosition;
	if ([UIDevice isIPad]) {
		yPosition = 700;
    } else {
		yPosition = 340;
    }
	
	text.frame = CGRectMake((self.view.bounds.size.width - text.frame.size.width) / 3.5, yPosition, text.frame.size.width, text.frame.size.height);
	text.alpha = 0;
	[self.view addSubview:text];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:0.1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedFadeAnimation:finished:context:)];
	
	text.alpha = 1;
	
	[UIView commitAnimations];
}

-(void)finishedFadeAnimation:(NSString*)animationID finished:(BOOL)finished context:(void*)context{
	[self performSelector:@selector(showMenu) withObject:nil afterDelay:1];
}

-(void)showMenu{
	UIWindow *window = [(AppDelegate_Shared *)[[UIApplication sharedApplication] delegate] window];
	CATransition *transition = [CATransition animation];
	
	transition.duration = 0.8;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[window.layer addAnimation:transition forKey:@"FADE_ANIM"];
	
	[[window subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	if ([UIDevice isIPad]) {
		self.mmIpad = [[[MainMenuViewControllerIPad alloc] initWithNibName:@"MainMenuViewControllerIPad" bundle:nil] autorelease];
		nav = [[UINavigationController alloc] initWithRootViewController:self.mmIpad];
		[window addSubview:nav.view];
		[nav setNavigationBarHidden:YES];
	}
	else {
		self.mmIphone = [[[MainMenuViewControllerIphone alloc] initWithNibName:@"MainMenuViewControllerIphone" bundle:nil] autorelease];
		nav = [[UINavigationController alloc] initWithRootViewController:self.mmIphone];
		[window addSubview:nav.view];
		[nav setNavigationBarHidden:YES];
	}
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Overriden to allow any orientation.
	if (![UIDevice isIPad]) {
		return NO;
	}
	if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		return YES;
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
	
	[mmIphone release];
	[mmIpad release];
	
	[nav release];
    [super dealloc];
}


@end
