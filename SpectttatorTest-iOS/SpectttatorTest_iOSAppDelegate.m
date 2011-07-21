//
//  SpectttatorTest_iOSAppDelegate.m
//  SpectttatorTest-iOS
//
//  Created by David Keegan on 6/29/11.
//  Copyright 2011 David Keegan.
//

#import "SpectttatorTest_iOSAppDelegate.h"
#import "RootViewController.h"

@implementation SpectttatorTest_iOSAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *controller = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
