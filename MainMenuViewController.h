//
//  MainMenuViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AppDelegate_Shared;

@interface MainMenuViewController : UIViewController {
	UIWindow *window;
	NSManagedObjectContext *context;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
