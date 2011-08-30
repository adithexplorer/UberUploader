//
//  OAuthRequestController.h
//  LROAuth2Demo
//
//  Created by Luke Redpath on 01/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LROAuth2ClientDelegate.h"
#import "Constants.h"

@class LROAuth2Client;
@class LROAuth2AccessToken;

extern NSString *const OAuthReceivedAccessTokenNotification;
extern NSString *const OAuthRefreshedAccessTokenNotification;

@interface InstagramAuthenticate : UIViewController <LROAuth2ClientDelegate> {
  LROAuth2Client *oauthClient;
  UIWebView *webView;
    LROAuth2AccessToken *accessTokenInstagram;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) LROAuth2AccessToken *accessTokenInstagram;

- (void)refreshAccessToken:(LROAuth2AccessToken *)accessToken;
- (void)saveAccessTokenToDisk;


@end

