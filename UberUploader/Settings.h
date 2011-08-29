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
#import "Constants.h"
#import "ASIHTTPRequestDelegate.h"
#import "LROAuth2AccessToken.h"
#import "InstagramAuthenticate.h"
#import "ASIHTTPRequest.h"
#import "NSString+QueryString.h"
#import "NSObject+YAJL.h"

@class  LROAuth2AccessToken;


@interface Settings : UIViewController <FBDialogDelegate, FBSessionDelegate, ASIHTTPRequestDelegate>
{
    UIButton *facebook;
    UIButton *flickr;
    UIButton *instagram;
    
    AppDelegate *appdelegate;
    
    
    //Created this so that authentication can be set to this once token is recieved
    GTMOAuthAuthentication *mAuth;

    LROAuth2AccessToken *Oauth2accessToken;

}

@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *flickr;
@property (strong, nonatomic) IBOutlet UIButton *instagram;
@property (strong, nonatomic) AppDelegate *appdelegate;
@property (nonatomic, retain) LROAuth2AccessToken *Oauth2accessToken;



-(IBAction)FacebookLogin:(id)sender; //Propritory singlesignin
-(IBAction)FlickrLogin:(id)sender; //Oauth1.0
-(IBAction)MySpaceLogin:(id)sender; //OAuth1.0  TO BE IMPLEMTED
-(IBAction)InstagramLogin:(id)sender; //Oauth2.0

//GTMOAuth methods
- (GTMOAuthAuthentication *)myCustomAuth;
- (void)doAnAuthenticatedAPIFetch;
- (void)setAuthentication:(GTMOAuthAuthentication *)auth;
- (void)updateUI;
- (BOOL)isSignedIn;

//LROAuth2 methods
- (void)saveAccessTokenToDisk;
- (void)beginAuthorization;

@end
