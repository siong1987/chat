//
//  chatAppDelegate.m
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "chatAppDelegate.h"
#import "chatViewController.h"

@implementation chatAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
