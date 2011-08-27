//
//  MainMenuViewControllerIphone.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuViewController.h"
#import "SongsViewControllerIphone.h"
#import "FavouriteCategoriesViewControllerIphone.h"
#import "SettingsViewControllerIphone.h"

@interface MainMenuViewControllerIphone : MainMenuViewController {

	SongsViewControllerIphone *songsController;
	FavouriteCategoriesViewControllerIphone *favController;
	SettingsViewControllerIphone *settingsController;
}

@property (nonatomic, retain) SongsViewControllerIphone *songsController;
@property (nonatomic, retain) FavouriteCategoriesViewControllerIphone *favController;
@property (nonatomic, retain) SettingsViewControllerIphone *settingsController;


-(IBAction)viewPlaySongs:(id)sender;
-(IBAction)viewLullabies:(id)sender;
-(IBAction)viewFavourites:(id)sender;
-(IBAction)viewInstruments:(id)sender;
-(IBAction)viewSettings:(id)sender;
@end
