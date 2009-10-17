//
//  chatAppDelegate.h
//  chat
//
//  Created by siong1987 on 10/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class chatViewController;

@interface chatAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    chatViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet chatViewController *viewController;

@end

