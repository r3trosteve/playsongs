//
//  SongsViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface SongsViewController : UIViewController {
	IBOutlet UIButton *song1;
	IBOutlet UIButton *song2;
	IBOutlet UIButton *song3;
	IBOutlet UIButton *song4;
	
	IBOutlet UIButton *star1;
	IBOutlet UIButton *star2;
	IBOutlet UIButton *star3;
	IBOutlet UIButton *star4;
	
	IBOutlet UIImageView *bg;
	IBOutlet UIImageView *stick;
	
	IBOutlet UIButton *next;
	IBOutlet UIButton *previous;
	
	BOOL isLullaby;
	NSArray *songs;
	NSInteger currentPage;
	
}

@property (nonatomic, assign) BOOL isLullaby;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, retain) NSArray *songs;

-(Song *)songForIndex:(NSInteger)index;
-(void)pageChanged;

-(IBAction)nextPage:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)backToMenu:(id)sender;

@end