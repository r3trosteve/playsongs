//
//  CustomStyleSheet.m
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomStyleSheet.h"
#import "UIDevice+Hardware.h"

@implementation CustomStyleSheet

// Style for TTLauncherItems
- (TTStyle*)launcherButton:(UIControlState)state {
	NSInteger fontsize;
	if([UIDevice isIPad]){
		fontsize = 20;
	}
	else {
		fontsize = 14;
	}

    return [TTPartStyle styleWithName: @"image" 
                         style: TTSTYLESTATE(launcherButtonImage:, state) 
                          next: [TTTextStyle 
                                 styleWithFont:[UIFont boldSystemFontOfSize:fontsize]
                                 color: RGBCOLOR(0, 0, 0)
                                 minimumFontSize: 11 
                                 shadowColor: nil
                                 shadowOffset: CGSizeZero 
                                 next: nil]];
}

@end
