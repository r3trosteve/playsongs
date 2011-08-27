//
//  AppDelegate_Shared.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_Shared.h"
#import "UIDevice+Hardware.h"
#import <QuartzCore/QuartzCore.h>
#import "Song.h"

@implementation AppDelegate_Shared

@synthesize window;
@synthesize mmIphone;
@synthesize mmIpad;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	//Copy the default data
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"CopiedDefaultData"]) {
		
		if ([Song copyDefaultData:self.managedObjectContext]) {
			NSLog(@"Successfully copied data");
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CopiedDefaultData"];
		}
		else {
			[[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error copying data." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease] show];
		}
		
		[[NSUserDefaults standardUserDefaults] setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"version"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	}
	
	//Prepare UI
	UIImageView *img = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.png"]] autorelease];
	img.frame = window.bounds;
	[window addSubview:img];
    
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showLogoAnimation) userInfo:nil repeats:NO];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)showLogoAnimation{
	UIImageView *logo = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]] autorelease];
	UIImageView *logoText = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_text.png"]] autorelease];
	
	logo.frame = CGRectMake((window.bounds.size.width - logo.frame.size.width) / 2, - logoText.frame.size.width - 50 - logoText.frame.size.height , logo.frame.size.width, logo.frame.size.height);
	logoText.frame = CGRectMake((window.bounds.size.width - logoText.frame.size.width) / 2,- logoText.frame.size.height, logoText.frame.size.width, logoText.frame.size.height);
	
	[window addSubview:logo];
	[window addSubview:logoText];
	
	
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
	
	text.frame = CGRectMake((window.bounds.size.width - text.frame.size.width) / 3.5, yPosition, text.frame.size.width, text.frame.size.height);
	text.alpha = 0;
	[window addSubview:text];
	
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
	CATransition *transition = [CATransition animation];
	
	transition.duration = 0.8;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[window.layer addAnimation:transition forKey:@"FADE_ANIM"];
	
	[[window subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	if ([UIDevice isIPad]) {
		self.mmIpad = [[[MainMenuViewControllerIPad alloc] initWithNibName:@"MainMenuViewControllerIPad" bundle:nil] autorelease];
		[window addSubview:mmIpad.view];
	}
	else {
		self.mmIphone = [[[MainMenuViewControllerIphone alloc] initWithNibName:@"MainMenuViewControllerIPhone" bundle:nil] autorelease];
		[window addSubview:mmIphone.view];
	}
}


/**
 Save changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    
    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Playsongs" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Playsongs.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[mmIphone release];
	[mmIpad release];
	
    [window release];
    [super dealloc];
}


@end

