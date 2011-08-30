//
//  HomeAnimationController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuViewControllerIPad.h"
#import "MainMenuViewControllerIphone.h"

@interface HomeAnimationController : UIViewController {
	MainMenuViewControllerIphone *mmIphone;
	MainMenuViewControllerIPad *mmIpad;
}

@property (nonatomic, retain) MainMenuViewControllerIphone *mmIphone;
@property (nonatomic, retain) MainMenuViewControllerIPad *mmIpad;

@end
