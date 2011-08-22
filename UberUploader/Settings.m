//
//  Settings.m
//  UberUploader
//
//  Created by Aditya Matharu on 22/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize facebook;
@synthesize facebookInstance;

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
    facebookInstance = [[Facebook alloc] initWithAppId:@"158734337540761" andDelegate:self];
    if (![facebookInstance isSessionValid]) {
        facebook.enabled = YES;
        NSLog(@"Session is Valid");
    }
    
}

-(IBAction)FacebookLogin:(id)sender
{
    //[facebookInstance logout:self];

    [facebookInstance dialog:@"feed" andDelegate:self];
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
