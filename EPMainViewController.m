//
//  EPMainViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPMainViewController.h"


@implementation EPMainViewController

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
