//
//  InstagramAuthenticate.m
//  UberUploader
//
//  Created by Aditya Matharu on 23/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
/*
#import "InstagramAuthenticate.h"

@implementation InstagramAuthenticate

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Assign CliendID from Instagram
    NSString *clientID = @"fcc9c5bf6f464b5fb1e5d084b64b54e4";
    
    //CHANGE  - Currently Redrect URI for user denied is set to Google CHANGE
    NSString *redirectURI = @"http://www.google.com";
    //NSString *redirectURI = @"UberUploader://";

    
    //URL  to send theuser to 
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code", clientID, redirectURI];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    //Calls the delegate method
    webView.delegate = self;

    
}

//WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webViewDelegate {
	
	/**
	 * Since there's some server side redirecting involved, this method/function will be called several times
	 * we're only interested when we see a url like:  http://www.facebook.com/connect/login_success.html#access_token=..........
	 */
/*	//get the url string
	NSString *url_string = [((webViewDelegate.request).URL) absoluteString];
	
	//looking for "code="
	NSRange access_token_range = [url_string rangeOfString:@"code="];
	
	//coolio, we have a token, now let's parse it out....
	if (access_token_range.length > 0) {
		
		//we want everything after the 'code=' thus the position where it starts + it's length
		int from_index = access_token_range.location + access_token_range.length;
		NSString *codeString = [url_string substringFromIndex:from_index];
		
		NSLog(@"code:  %@", codeString);
        
        
        //Authenticate using ASIHTTPRequest
        NSURL *authenticationURL = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
        ASIFormDataRequest *asiformrequest = [ASIFormDataRequest requestWithURL:authenticationURL];
        [asiformrequest setPostValue:@"fcc9c5bf6f464b5fb1e5d084b64b54e4" forKey:@"client_id"];
        [asiformrequest setPostValue:@"cf311b8c62634aeb8ec23f7274162acf" forKey:@"client_secret"];
        [asiformrequest setPostValue:@"authorization_code" forKey:@"grant_type"];
        [asiformrequest setPostValue:@"http://www.google.com" forKey:@"redirect_uri"];
        [asiformrequest setPostValue:codeString forKey:@"code"];
        [asiformrequest startSynchronous];
        
        NSString *recievedData = [[NSString alloc] initWithData:[asiformrequest responseData] encoding:NSUTF8StringEncoding];
        
       // NSLog([asiformrequest responseString]);
        NSLog(recievedData);
        
        //This parses the response from Instagram and gives a value out for access token
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *object = [parser objectWithString:recievedData];
        NSLog([object valueForKey:@"access_token"]);
                        

	}
}

- (void)requestStarted:(ASIHTTPRequest *)request{NSLog(@"Request Started");}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{NSLog(@"Recieved Response Headers");}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL{NSLog(@"Will Redirect");}
- (void)requestFinished:(ASIHTTPRequest *)request{NSLog(@"Request finished");}
- (void)requestFailed:(ASIHTTPRequest *)request{NSLog(@"Request failed");}
- (void)requestRedirected:(ASIHTTPRequest *)request{NSLog(@"Request redirected");}




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

@end */
