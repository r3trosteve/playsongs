//
//  SettingsViewController.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController <UITextFieldDelegate>{
	NSString *childName;
	IBOutlet UITextField *nameField;
}

@property (nonatomic, retain) NSString *childName;

-(IBAction)back:(id)sender;

@end
