//
//  EasyPockectAppDelegate.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EPMainViewController.h"
#import "EPOutComeViewController.h"
#import "EPCalendarViewController.h"

@interface EasyPockectAppDelegate : NSObject <UIApplicationDelegate> {
  
  UIWindow *window;
  
  UITabBarController *_tabBarController;
  
  
@private
  NSManagedObjectContext *managedObjectContext_;
  NSManagedObjectModel *managedObjectModel_;
  NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain)UITabBarController *tabBarController;

- (void)saveContext;
- (NSString *)applicationDocumentsDirectory;

@end

