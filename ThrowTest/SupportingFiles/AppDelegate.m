//  Created by Dmitriy Stupivtsev on 21.09.2018.

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [UIWindow new];
    _window.rootViewController = [ViewController new];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
