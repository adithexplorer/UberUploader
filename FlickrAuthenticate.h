//
//  FlickrAuthenticate.h
//  UberUploader
//
//  Created by Aditya Matharu on 27/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSOAuthKit.h"


@interface FlickrAuthenticate : UIViewController
{ 
    UIWebView *webView;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
