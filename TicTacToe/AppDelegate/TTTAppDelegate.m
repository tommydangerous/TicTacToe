#import "TTTAppDelegate.h"

#import "TTTApplicationViewController.h"

@implementation TTTAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.applicationViewController = [TTTApplicationViewController new];
  self.window.rootViewController = self.applicationViewController;

  [self.window makeKeyAndVisible];

  return YES;
}

@end
