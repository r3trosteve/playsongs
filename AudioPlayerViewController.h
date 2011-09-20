//
//  AudioPlayerViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface AudioPlayerViewController : UIViewController <AVAudioPlayerDelegate>{
	IBOutlet UISlider *progressView;
	NSArray *songs;
	AVAudioPlayer *player;
	NSTimer	*updateTimer;
	BOOL inBackground;
	NSInteger index;
	BOOL shuffle;
	NSMutableArray *shuffledSongs;
}


-(IBAction)play:(id)sender;
-(IBAction)pause:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)progressSliderMoved:(UISlider*)sender;
-(void)updateCurrentTime;
-(void)registerForBackgroundNotifications;
-(void)playSong:(Song *)song;
-(void)playSongByIndex:(NSInteger)anIndex;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSArray *songs;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, assign) BOOL inBackground;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL shuffle;
@end
