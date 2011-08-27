//
//  MainMenuViewControllerIPad.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuViewController.h"
#import "SongsViewControllerIpad.h"
#import "FavouriteCategoriesViewControllerIpad.h"
#import "SettingsViewControllerIpad.h"

@interface MainMenuViewControllerIPad : MainMenuViewController {
	SongsViewControllerIpad *songsController;
	FavouriteCategoriesViewControllerIpad *favController;
	SettingsViewControllerIpad *settingsController;
}

@property (nonatomic, retain) SongsViewControllerIpad *songsController;
@property (nonatomic, retain) FavouriteCategoriesViewControllerIpad *favController;
@property (nonatomic, retain) SettingsViewControllerIpad *settingsController;


-(IBAction)viewPlaySongs:(id)sender;
-(IBAction)viewLullabies:(id)sender;
-(IBAction)viewFavourites:(id)sender;
-(IBAction)viewInstruments:(id)sender;
-(IBAction)viewSettings:(id)sender;

@end
