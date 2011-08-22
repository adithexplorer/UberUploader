//
//  Settings.h
//  UberUploader
//
//  Created by Aditya Matharu on 22/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "ObjectiveFlickr.h"

@interface Settings : UIViewController <FBDialogDelegate, FBSessionDelegate>
{
    UIButton *facebook;
    Facebook *facebookInstance;
}

@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) Facebook *facebookInstance;

-(IBAction)FacebookLogin:(id)sender;

@end
