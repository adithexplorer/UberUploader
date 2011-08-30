//
//  OAuthRequestController.m
//  LROAuth2Demo
//
//  Created by Luke Redpath on 01/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "InstagramAuthenticate.h"
#import "LROAuth2Client.h"



/*
 * you will need to create this from OAuthCredentials-Example.h
 *
 */

NSString *const OAuthReceivedAccessTokenNotification  = @"OAuthReceivedAccessTokenNotification";
NSString *const OAuthRefreshedAccessTokenNotification = @"OAuthRefreshedAccessTokenNotification";

NSString * AccessTokenSavePath() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"OAuthAccessToken.cache"];
}

@implementation InstagramAuthenticate

@synthesize webView;
@synthesize accessTokenInstagram;

/*
- (id)init;
{
  if (self = [super initWithNibName:@"OAuthRequestController" bundle:nil]) {
    oauthClient = [[LROAuth2Client alloc] initWithClientID:kInstagramClientID 
      secret:kInstagramClientSecret redirectURL:[NSURL URLWithString:kInstagramClientAuthURL]];

    oauthClient.debug = YES;
    oauthClient.delegate = self;    
    oauthClient.userURL  = [NSURL URLWithString:@"https://graph.facebook.com/oauth/authorize"];
    oauthClient.tokenURL = [NSURL URLWithString:@"https://graph.facebook.com/oauth/access_token"];
    
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    self.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
  }
  return self;
}*/

//Accesstoken save path



-(void)viewDidLoad
{
    
    // check if we have a valid access token before continuing otherwise obtain a token
    oauthClient = [[LROAuth2Client alloc] initWithClientID:kInstagramClientID 
                                                    secret:kInstagramClientSecret redirectURL:[NSURL URLWithString:kInstagramClientRedirectURL]];
    
    oauthClient.debug = YES;
    oauthClient.delegate = self;    
    oauthClient.userURL  = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize"]];
    oauthClient.tokenURL = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
    
    self.modalPresentationStyle = UIModalPresentationPageSheet;
   // self.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
   
}

- (void)saveAccessTokenToDisk
{
    [NSKeyedArchiver archiveRootObject:self.accessTokenInstagram toFile:AccessTokenSavePath()];
}

- (void)viewDidUnload 
{
 [super viewDidUnload];
  self.webView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
  NSDictionary *params = [NSDictionary dictionaryWithObject:@"touch" forKey:@"display"];
  [oauthClient authorizeUsingWebView:self.webView additionalParameters:params];
}



- (void)refreshAccessToken:(LROAuth2AccessToken *)accessToken
{
  [oauthClient refreshAccessToken:accessToken];
}

#pragma mark -
#pragma mark LROAuth2ClientDelegate methods

- (void)oauthClientDidReceiveAccessToken:(LROAuth2Client *)client
{
 // [[NSNotificationCenter defaultCenter] postNotificationName:OAuthReceivedAccessTokenNotification object:client.accessToken];
    [self dismissModalViewControllerAnimated:YES];
    accessTokenInstagram =  client.accessToken;
    [self saveAccessTokenToDisk];
    
}

- (void)oauthClientDidRefreshAccessToken:(LROAuth2Client *)client
{
 // [[NSNotificationCenter defaultCenter] postNotificationName:OAuthRefreshedAccessTokenNotification object:client.accessToken];
    [self saveAccessTokenToDisk];
    NSLog(@"Access Token Refreshed");
}

@end
