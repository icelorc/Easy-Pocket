//
//  EPChartViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPChartViewController.h"


@implementation EPChartViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
      
    }
    return self;
}


#pragma mark -
#pragma mark View life cycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.title = @"Chart";
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  NSInteger eatingBudget = [userDefaults integerForKey:@"EPEatingValue"];
  NSInteger entertainmentBudget = [userDefaults integerForKey:@"EPEntertainmentValue"];
  NSInteger livingBudge = [userDefaults integerForKey:@"EPLivingValue"];
  NSInteger totalBudge = eatingBudget + entertainmentBudget + livingBudge;
  
  NSInteger eatingTotalCost = [userDefaults integerForKey:@"EatingTotalCost"];
  NSInteger entertainmentTotalCost = [userDefaults integerForKey:@"EntertainmentTotalCost"];
  NSInteger livingTotalCost = [userDefaults integerForKey:@"LivingTotalCost"];
  NSInteger totalCost = eatingTotalCost + livingTotalCost + entertainmentTotalCost;
  if (totalBudge == 0) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your totalbudge is ZERO!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    return;
  }
  
  _pieChart = [[BNPieChart alloc] initWithFrame:CGRectMake(15, 0, 300, 300)];
  if (eatingTotalCost != 0) {
    [_pieChart addSlicePortion:eatingTotalCost/(float)totalBudge withName:@"Eating"];  
  }
  
  if (entertainmentTotalCost != 0) {
    [_pieChart addSlicePortion:entertainmentTotalCost/(float)totalBudge withName:@"Entertainment"];  
  }
  
  if (livingTotalCost != 0) {
    [_pieChart addSlicePortion:livingTotalCost/(float)livingBudge withName:@"Living"]; 
  }
  float remains = 1.0 - eatingTotalCost/(float)totalBudge - entertainmentTotalCost/(float)totalBudge - livingTotalCost/(float)livingBudge;
  [_pieChart addSlicePortion:remains  withName:@"Unused"]; 
  [self.view addSubview:_pieChart];
  [_pieChart release];
  _pieChart = nil;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
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
