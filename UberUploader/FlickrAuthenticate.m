//
//  FlickrAuthenticate.m
//  UberUploader
//
//  Created by Aditya Matharu on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FlickrAuthenticate.h"

@implementation FlickrAuthenticate
@synthesize webView;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self signInToCustomService];    
    
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

- (GTMOAuthAuthentication *)myCustomAuth {
    NSString *myConsumerKey = @"3093c012bd21c951d512331424fcbe63";    // pre-registered with service
    NSString *myConsumerSecret = @"d812edbe4c328aa4"; // pre-assigned by service
    
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                        consumerKey:myConsumerKey
                                                         privateKey:myConsumerSecret];
    
    // setting the service name lets us inspect the auth object later to know
    // what service it is for
    auth.serviceProvider = @"Flickr";
    
    return auth;
}

- (void)signInToCustomService {
    
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
                                                          appServiceName:@"My App: Flickr"
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)] ;
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

@end
