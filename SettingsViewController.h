//
//  SettingsViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#define ACCESS_TOKEN_KEY @"fb_access_token"
#define EXPIRATION_DATE_KEY @"fb_expiration_date"


@interface SettingsViewController : UIViewController <UITextFieldDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate>{
	NSString *childName;
	IBOutlet UITextField *nameField;
	Facebook* facebook;
	NSArray* permissions;
}

@property (nonatomic, retain) NSString *childName;
@property(readonly) Facebook *facebook;

-(IBAction)back:(id)sender;
-(IBAction)share:(id)sender;
- (void)publishStream;

@end
