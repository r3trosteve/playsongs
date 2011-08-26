//
//  AppDelegate_Shared.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainMenuViewControllerIPad.h"
#import "MainMenuViewControllerIphone.h"

@interface AppDelegate_Shared : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	MainMenuViewControllerIphone *mmIphone;
	MainMenuViewControllerIPad *mmIpad;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) MainMenuViewControllerIphone *mmIphone;
@property (nonatomic, retain) MainMenuViewControllerIPad *mmIpad;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end

