//
//  Settings.m
//  UberUploader
//
//  Created by Aditya Matharu on 22/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings
//Facebook
@synthesize appdelegate;
@synthesize facebook;
@synthesize instagram;
//Flickr
@synthesize flickr;

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
    
    //Starts FaceBook and checks if application is already logged in or not. If not then it enables the login button.  NOT WORKING AT THE MOMENT --INVESTIGATE
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appdelegate.facebookInstance isSessionValid]) {
        NSLog(@"FACEBOOK SESTTINGS INSTANCE SSESSION NOT VALID");
    }
    
}

-(IBAction)FacebookLogin:(id)sender
{
    //Creates facebook Logon Dialog
    //[facebookInstance logout:self];

  //  [facebookInstance dialog:@"feed" andDelegate:self];
    [appdelegate.facebookInstance authorize:nil];
}

-(IBAction)FlickrLogin:(id)sender
{
    //Creates flickr Logon dialog DOES NOT WORK
    OFFlickrAPIContext *context = [[OFFlickrAPIContext alloc] initWithAPIKey:@"3093c012bd21c951d512331424fcbe63" sharedSecret:@"d812edbe4c328aa4"];
}

-(IBAction)InstagramLogin:(id)sender
{
//Redirects user to instagram authorization    
   // [self performSegueWithIdentifier:@"InstagramLogin" sender:self];   

}


- (void)dialogDidComplete:(FBDialog *)dialog
{
    NSLog (@"Facebook Login Successful");
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
