//
//  Settings.h
//  UberUploader
//
//  Created by Aditya Matharu on 22/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AppDelegate.h"
#import "GTMOAuthViewControllerTouch.h"


@interface Settings : UIViewController <FBDialogDelegate, FBSessionDelegate>
{
    UIButton *facebook;
    UIButton *flickr;
    UIButton *instagram;
    
    AppDelegate *appdelegate;

}

@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *flickr;
@property (strong, nonatomic) IBOutlet UIButton *instagram;
@property (strong, nonatomic) AppDelegate *appdelegate;


-(IBAction)FacebookLogin:(id)sender;
-(IBAction)FlickrLogin:(id)sender;
-(IBAction)InstagramLogin:(id)sender;

- (GTMOAuthAuthentication *)myCustomAuth;



@end
