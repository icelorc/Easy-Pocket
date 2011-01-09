//
//  EasyPockectAppDelegate.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EasyPockectAppDelegate.h"


@implementation EasyPockectAppDelegate

@synthesize window;
@synthesize tabBarController = _tabBarController;


- (NSString *)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  EPMainViewController *mainViewController = [[[EPMainViewController alloc] initWithNibName:@"EPMainViewController" bundle:nil] autorelease];
  EPOutComeViewController *outComeViewController = [[[EPOutComeViewController alloc] initWithStyle:UITableViewStylePlain eating:mainViewController.eating entertainment:mainViewController.entertainment living:mainViewController.living] autorelease];
  EPCalendarViewController *calendarViewController = [[[EPCalendarViewController alloc] init] autorelease];
  
  UINavigationController *mainNavigationController = [[[UINavigationController alloc] initWithRootViewController:mainViewController] autorelease];
  UINavigationController *outComeNavigationController = [[[UINavigationController alloc] initWithRootViewController:outComeViewController] autorelease];
  UINavigationController *calendarNavigationController = [[[UINavigationController alloc] initWithRootViewController:calendarViewController] autorelease];
  
  self.tabBarController = [[UITabBarController alloc] init];
  self.tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigationController, outComeNavigationController, calendarNavigationController, nil];
  
  [self.window addSubview:self.tabBarController.view];
  
  [self.window makeKeyAndVisible];
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
   */
  [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  /*
   Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
   */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
  [self saveContext];
}


- (void)saveContext {
  
  NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    } 
  }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
  
  if (managedObjectContext_ != nil) {
    return managedObjectContext_;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    managedObjectContext_ = [[NSManagedObjectContext alloc] init];
    [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
  }
  return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
  
  if (managedObjectModel_ != nil) {
    return managedObjectModel_;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EasyPockect" withExtension:@"momd"];
  managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
  return managedObjectModel_;
}



#pragma mark -
#pragma mark Application's Documents directory


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  
  [managedObjectContext_ release];
  [managedObjectModel_ release];
  [persistentStoreCoordinator_ release];
  
  self.tabBarController = nil;
  
  [window release];
  [super dealloc];
}


@end

