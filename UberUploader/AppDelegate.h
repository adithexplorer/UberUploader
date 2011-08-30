//
//  AppDelegate.h
//  UberUploader
//
//  Created by Aditya Matharu on 07/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//  Repository on GitHub

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class  LROAuth2AccessToken;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>
{
    Facebook *facebookInstance;
    LROAuth2AccessToken *accessTokenInstagram;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Facebook Session
@property (strong, nonatomic) Facebook *facebookInstance;
@property (strong, nonatomic) LROAuth2AccessToken *accessTokenInstagram;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
