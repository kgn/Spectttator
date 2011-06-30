//
//  SpectttatorTest_iOSAppDelegate.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpectttatorTest_iOSAppDelegate.h"

@implementation SpectttatorTest_iOSAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
