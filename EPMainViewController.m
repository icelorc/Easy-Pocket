//
//  EPMainViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPMainViewController.h"
#import "EasyPockectAppDelegate.h"



@implementation EPMainViewController

@synthesize living = _living;
@synthesize entertainment = _entertainment;
@synthesize eating = _eating;

- (NSMutableArray*)eating {
  if (!_eating) {
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    _eating = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEating-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]]];  }  
  return _eating;
}

- (NSMutableArray*)living {
  if (!_living) {
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    _living = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPLving-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]]];  }  
  return _living;
}

- (NSMutableArray*)entertainment {
  if (!_entertainment) {
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    _entertainment = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEntertainment-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]]];  }  
  return _entertainment;
}

 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:[UIImage imageNamed:@"calculator.png"] tag:0];
  }
  return self;
}


#pragma mark -
#pragma mark Navigation Item Action

- (void)addExpend {
  EPAddExpendViewController *addExpendViewController = [[EPAddExpendViewController alloc] init];
  UINavigationController *addExpendNavigationController = [[UINavigationController alloc] initWithRootViewController:addExpendViewController];
  [self presentModalViewController:addExpendNavigationController animated:YES];
  [addExpendViewController release];
  [addExpendNavigationController release];
  
}

#pragma mark -
#pragma mark View life cycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.title = @"Main";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExpend)];
  
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [super dealloc];
}


@end
