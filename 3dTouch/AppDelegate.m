//
//  AppDelegate.m
//  3dTouch
//
//  Created by Dmitriy Zakharov on 2015-10-08.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property UIApplicationShortcutItem *shortcutItem;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *currentShortcuts = application.shortcutItems;
    
    if (![currentShortcuts count]) {
        UIMutableApplicationShortcutItem *dynamicShortcut = [[UIMutableApplicationShortcutItem alloc] initWithType:@"searchType" localizedTitle:@"Shorcut3" localizedSubtitle:@"subtitle" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"EyeTemplate"] userInfo:nil];
        
        application.shortcutItems = @[dynamicShortcut];
    }
    
    
    if (launchOptions[UIApplicationLaunchOptionsShortcutItemKey]) {
        self.shortcutItem = launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
    }
    
    
    return YES;
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if (self.shortcutItem) {
        //Perform some work
    }
    
    self.shortcutItem = nil;
}


- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void (^)(BOOL succeeded))completionHandler
{
    NSLog(@"called %@", shortcutItem.type);
}

@end
