    //
//  AudioPlayerViewController.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import "Song.h"
#import "UIDevice+Hardware.h"

@implementation AudioPlayerViewController

@synthesize songs;
@synthesize player;
@synthesize updateTimer;
@synthesize inBackground;
@synthesize index;
@synthesize shuffle;


- (void)updateViewForPlayerState:(AVAudioPlayer *)p{
	[self updateCurrentTime];
	
	if (updateTimer) 
		[updateTimer invalidate];
	
	if (p.playing)
	{
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateCurrentTime) userInfo:p repeats:YES];
	}
	else
	{
		updateTimer = nil;
	}
	
}

-(void)updateCurrentTime{
	progressView.value = player.currentTime/player.duration;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self registerForBackgroundNotifications];
	
	Song *song = (Song *)[songs objectAtIndex:index];
	[self playSong:song];
	
	if (shuffle) {
		shuffledSongs = [[NSMutableArray array] retain];
		[shuffledSongs addObject:song];
		index = 0;
	}	
	
	if ([UIDevice isIPad]) {
		CGAffineTransform transform = CGAffineTransformMakeScale(2.0f, 2.0f);
		progressView.transform = transform;
	}
}


-(void)playSong:(Song *)song{
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [song localPath]]];
	NSError *error;
	self.player = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error] autorelease];
	
	if (shuffle) {
		[shuffledSongs addObject:song];
		index++;
	}
	else {
		index = [songs indexOfObject:song];
	}

	if (self.player == nil){
		NSLog(@"%@",[error localizedDescription]);
	}
	else{
		player.volume = 1;
		player.numberOfLoops = 0;
		player.delegate = self;
		[player prepareToPlay];
		[player play];
		[self updateViewForPlayerState:player];
	}
}


-(void)playSongByIndex:(NSInteger)anIndex{
	Song *song;
	if (shuffle) {
		song = [shuffledSongs objectAtIndex:anIndex];
	}
	else{
		song = [songs objectAtIndex:anIndex];
	}
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [song localPath]]];
	NSError *error;
	self.player = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error] autorelease];
	
	index = anIndex;
	
	if (self.player == nil){
		NSLog(@"%@",[error localizedDescription]);
	}
	else{
		player.volume = 1;
		player.numberOfLoops = 0;
		player.delegate = self;
		[player prepareToPlay];
		[player play];
		[self updateViewForPlayerState:player];
	}
}

-(void)pausePlaybackForPlayer:(AVAudioPlayer*)p{
	[p pause];
	[self updateViewForPlayerState:p];
}


-(void)startPlaybackForPlayer:(AVAudioPlayer*)p
{
	if ([p play])
	{
		[self updateViewForPlayerState:p];
	}
	else
		NSLog(@"Could not play %@\n", p.url);
}



-(IBAction)play:(id)sender{
	if (!player.playing)
		[self startPlaybackForPlayer: player];
}


-(IBAction)pause:(id)sender{
	if (player.playing)
		[self pausePlaybackForPlayer: player];
}


-(IBAction)previous:(id)sender{
	if (index > 0) {
		[self playSongByIndex:(index - 1)];
	}
}


-(IBAction)next:(id)sender{
	if (shuffle) {
		if (index < [shuffledSongs count] - 1) {
			[self playSongByIndex:(index + 1)];
		}
		else {
			[self playSong:[songs objectAtIndex:abs(arc4random() % [songs count])]];
		}

	}
	else {
		if (index < [songs count] - 1) {
			[self playSongByIndex:(index + 1)];
		}
	}	
}


-(IBAction)stop:(id)sender{
	[player stop];
	[self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)progressSliderMoved:(UISlider *)sender{
	player.currentTime = sender.value * player.duration;
	[self updateCurrentTime];
}


#pragma mark background notifications
- (void)registerForBackgroundNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setInBackgroundFlag)
												 name:UIApplicationWillResignActiveNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(clearInBackgroundFlag)
												 name:UIApplicationWillEnterForegroundNotification
											   object:nil];
}

- (void)setInBackgroundFlag
{
	inBackground = true;
}

- (void)clearInBackgroundFlag
{
	inBackground = false;
}


#pragma mark AVAudioPlayer delegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)p successfully:(BOOL)flag
{
	if (flag == NO)
		NSLog(@"Playback finished unsuccessfully");
	
	[p setCurrentTime:0];
	if (inBackground)
	{
		NSLog(@"in bg");
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
	if (shuffle) {
		[self next:nil];
	}
}

- (void)playerDecodeErrorDidOccur:(AVAudioPlayer *)p error:(NSError *)error
{
	NSLog(@"ERROR IN DECODE: %@\n", error); 
}

// we will only get these notifications if playback was interrupted
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption begin. Updating UI for new state");
	// the object has already been paused,	we just need to update UI
	if (inBackground)
	{
		NSLog(@"in bg");
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption ended. Resuming playback");
	[self startPlaybackForPlayer:p];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([UIDevice isIPad]) {
		// Overriden to allow any orientation.
		if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
			return YES;
		else
			return NO;
	}
	else {
		return NO;
	}

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
	[songs release];
	[player release];
	[updateTimer release];
	[progressView release];
	[shuffledSongs release];
    [super dealloc];
}


@end
