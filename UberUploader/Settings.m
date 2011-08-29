//
//  Settings.m
//  UberUploader
//
//  Created by Aditya Matharu on 22/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "FlickrAuthenticate.h"


@implementation Settings
//Facebook
@synthesize appdelegate;
@synthesize facebook;
@synthesize instagram;
//Flickr
@synthesize flickr;

@synthesize Oauth2accessToken;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)awakeFromNib {
    // Get the saved authentication FOR FLICKR, if any, from the keychain.
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    if (auth) {
        BOOL didAuth = [GTMOAuthViewControllerTouch authorizeFromKeychainForName:kFlickerKeychainName authentication:auth];
        // if the auth object contains an access token, didAuth is now true
    }
    
    // retain the authentication object, which holds the auth tokens
    //
    // we can determine later if the auth object contains an access token
    // by calling its -canAuthorize method
    [self setAuthentication:auth];
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Starts FaceBook and checks if application is already logged in or not. If not then it enables the login button.  NOT WORKING AT THE MOMENT --INVESTIGATE
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appdelegate.facebookInstance isSessionValid]) {
        NSLog(@"FACEBOOK SESTTINGS INSTANCE SSESSION NOT VALID");
    }
    
    
    //this will update the UI if Flicker is Logged in
    [self updateUI];

    
}



#pragma mark Facebook Login Method

//Facebook Login Method
-(IBAction)FacebookLogin:(id)sender
{
    //Creates facebook Logon Dialog
    //[facebookInstance logout:self];

  //  [facebookInstance dialog:@"feed" andDelegate:self];
    [appdelegate.facebookInstance authorize:nil];
}

- (void)dialogDidComplete:(FBDialog *)dialog
{
    //Do I even need this method?
    NSLog (@"Facebook Login Successful");
}




#pragma mark Flickr Login Methid

-(IBAction)FlickrLogin:(id)sender
{
    NSLog(@"Sign Into FLicker Method Called");
    NSURL *requestURL = [NSURL URLWithString:@"http://www.flickr.com/services/oauth/request_token"];
    NSURL *accessURL = [NSURL URLWithString:@"http://www.flickr.com/services/oauth/access_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"http://www.flickr.com/services/oauth/authorize"];
    NSString *scope = @"http://example.com/scope";
    
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.example.com/OAuthCallback"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[GTMOAuthViewControllerTouch alloc] initWithScope:scope
                                                               language:nil
                                                        requestTokenURL:requestURL
                                                      authorizeTokenURL:authorizeURL
                                                         accessTokenURL:accessURL
                                                         authentication:auth
                                                         appServiceName:kFlickerKeychainName
                                                               delegate:self
                                                       finishedSelector:@selector(viewController:finishedWithAuth:error:)] ;
    
    
    //Maybe I can have this as a if statement, ie if its iphone then do this otherwise do that 
   //Ipad Modal View
    viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentModalViewController:viewController animated:YES];
}



#pragma mark OAuth1.0 methods Google GTMO 

- (GTMOAuthAuthentication *)myCustomAuth {
    NSString *myConsumerKey = @"3093c012bd21c951d512331424fcbe63";    // pre-registered with service
    NSString *myConsumerSecret = @"d812edbe4c328aa4"; // pre-assigned by service
    
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                       consumerKey:myConsumerKey
                                                        privateKey:myConsumerSecret];
    
    // setting the service name lets us inspect the auth object later to know
    // what service it is for
    auth.serviceProvider = kFlickerServiceName;
    
    return auth;
}


- (BOOL)isSignedIn {
    BOOL isSignedIn = [mAuth canAuthorize];
    return isSignedIn;
}


- (void)setAuthentication:(GTMOAuthAuthentication *)auth {
    mAuth = auth;
}

//Delegate Method
- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        //TODO: Set something here so that the user can do somethig if authorization fails or at least dismiss the view
        NSLog(@"Flicker Auth Failed");
        [self setAuthentication:nil];

    } else {
        NSLog(@"Flicker Auth Succeeded");
        [self dismissModalViewControllerAnimated:YES];
        
        // save the authentication object
        [self setAuthentication:auth];
        
        //Checks and NSLogs to check if authentication is successful
        [self doAnAuthenticatedAPIFetch];
        
        [self updateUI];

    }
}

//Authorization Check
- (void)doAnAuthenticatedAPIFetch {
    NSString *urlStr;
    
    //Flickr Login Check
    urlStr = @"http://api.flickr.com/services/rest/?method=flickr.test.login&name=value";
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [mAuth authorizeRequest:request];
    
    // Note that for a request with a body, such as a POST or PUT request, the
    // library will include the body data when signing only if the request has
    // the proper content type header:
    //
    //   [request setValue:@"application/x-www-form-urlencoded"
    //  forHTTPHeaderField:@"Content-Type"];
    
    // Synchronous fetches like this are a really bad idea in Cocoa applications
    //
    // For a very easy async alternative, we could use GTMHTTPFetcher
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (data) {
        // API fetch succeeded
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"API response: %@", str);
    } else {
        // fetch failed
        NSLog(@"API fetch error: %@", error);
    }
}

//if authrorization is successful this method will change the button text
- (void)updateUI {
    // update the text showing the signed-in state and the button title
    // A real program would use NSLocalizedString() for strings shown to the user.
    if ([self isSignedIn]) {
        // signed in
       flickr.titleLabel.text = @"Flickr Signed in";
    } else {
        // signed out
        NSLog(@"Not signed in");
    }
  
}


#pragma mark instagram Login Method
-(IBAction)InstagramLogin:(id)sender
{
//Redirects user to instagram authorization    
   // [self performSegueWithIdentifier:@"InstagramLogin" sender:self];   

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
