//
//  FavouriteCategoriesViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"
#import "PlaylistSongs.h"

@interface FavouriteCategoriesViewController : UIViewController<UIAlertViewDelegate, UITextFieldDelegate> {
	IBOutlet UIScrollView *scrollView;
	NSMutableArray * playlists;
	NSManagedObjectContext *context;
	NSMutableArray *categoryViews;
	NSInteger deleteIndex;
	
	UITextField *categoryNameField;
	UIAlertView *addAlert;
}

@property (nonatomic, retain) NSArray *playlists;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) UITextField *categoryNameField;
@property (nonatomic, retain) UIAlertView *addAlert;

-(IBAction)addFavCategory:(id)sender;
-(IBAction)backToMenu:(id)sender;
@end
