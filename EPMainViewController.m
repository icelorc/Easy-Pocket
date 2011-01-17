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
@synthesize goButton = _goButton;
@synthesize eatingLabel = _eatingLabel;
@synthesize livingLabel = _livingLabel;
@synthesize entertainmentLabel = _entertainmentLabel;
@synthesize totalLabel = _totalLabel;

@synthesize eatingExpandLabel = _eatingExpandLabel;
@synthesize entertainmentExpandLabel = _entertainmentExpandLabel;
@synthesize livingExpandLabel = _livingExpandLabel;

@synthesize eatingEnd = _eatingEnd;
@synthesize entertainmentEnd = _entertainmentEnd;
@synthesize livingEnd  = _livingEnd;

- (void)planCostViewController:(EPPlanCostViewController *)planCostViewController eatingValue:(NSInteger)eatingValue entertainmentValue:(NSInteger)entertainmentValue livingValue:(NSInteger)livingValue {
  self.eatingLabel.text = [NSString stringWithFormat:@"%d", eatingValue];
  self.livingLabel.text = [NSString stringWithFormat:@"%d", livingValue];
  self.entertainmentLabel.text = [NSString stringWithFormat:@"%d", entertainmentValue];
  self.totalLabel.text = [NSString stringWithFormat:@"%d", eatingValue + livingValue + entertainmentValue];
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  [userDefaults setInteger:eatingValue forKey:@"EPEatingValue"];
  
  NSLog(@"%d", [userDefaults integerForKey:@"EPEatingValue"]);
  
  [userDefaults setInteger:livingValue forKey:@"EPLivingValue"];
  [userDefaults setInteger:entertainmentValue forKey:@"EPEntertainmentValue"];
  
  
}

- (void)addExpandViewController:(EPAddExpendViewController *)addExpandViewController dataModel:(EPDataModel *)dataModel {
  
  NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];

  
  switch (dataModel.category) {
    case 0:
      [self.eating addObject:dataModel];
      [NSKeyedArchiver archiveRootObject:self.eating toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEating-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
      break;
    case 1:
      [self.entertainment addObject:dataModel];
      [NSKeyedArchiver archiveRootObject:self.entertainment toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEntertainment-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
      break;
    case 2:
      [self.living addObject:dataModel];
      [NSKeyedArchiver archiveRootObject:self.living toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPLiving-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
      break;

    default:
      break;
  }
  
  NSInteger eatingExpand = 0;
  
  for (EPDataModel *dataModel in self.eating) {
    eatingExpand += dataModel.cost;
  }
  
  self.eatingExpandLabel.text = [NSString stringWithFormat:@"%d", eatingExpand];
  
  NSInteger entertainmentExpand = 0;
  
  for (EPDataModel *dataModel in self.entertainment) {
    entertainmentExpand += dataModel.cost;
  }
  
  self.entertainmentExpandLabel.text = [NSString stringWithFormat:@"%d", entertainmentExpand];
  
  NSInteger livingExpand = 0;
  
  for (EPDataModel *dataModel in self.living) {
    livingExpand += dataModel.cost;
  }
  
  self.livingExpandLabel.text = [NSString stringWithFormat:@"%d", livingExpand];
  
}

- (IBAction)goButtonAction {
  EPPlanCostViewController *planCostViewController = [[EPPlanCostViewController alloc] initWithNibName:@"EPPlanCostViewController" bundle:nil];
  planCostViewController.delegate = self;
  [self.navigationController pushViewController:planCostViewController animated:YES];
  [planCostViewController release];
}

#pragma mark -
#pragma mark Read data from iPhone

- (NSMutableArray*)eating {
  if (!_eating) {
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    _eating = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEating-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]]];  }  
  return _eating;
}

- (NSMutableArray*)living {
  if (!_living) {
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    _living = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPLiving-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]]];  }  
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
  addExpendViewController.delegate = self;
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
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSInteger eatingValue = [userDefaults integerForKey:@"EPEatingValue"];
  NSInteger entertainmentValue = [userDefaults integerForKey:@"EPEntertainmentValue"];
  NSInteger livingValue = [userDefaults integerForKey:@"EPLivingValue"];
  
  
  self.eatingLabel.text = [NSString stringWithFormat:@"%d", eatingValue];
  self.livingLabel.text = [NSString stringWithFormat:@"%d", livingValue];
  self.entertainmentLabel.text = [NSString stringWithFormat:@"%d", entertainmentValue];
  
  
  NSInteger eatingExpand = 0;
  
  for (EPDataModel *dataModel in self.eating) {
    eatingExpand += dataModel.cost;
  }
  
  self.eatingExpandLabel.text = [NSString stringWithFormat:@"%d", eatingExpand];
  
  NSInteger entertainmentExpand = 0;
  
  for (EPDataModel *dataModel in self.entertainment) {
    entertainmentExpand += dataModel.cost;
  }
  
  self.entertainmentExpandLabel.text = [NSString stringWithFormat:@"%d", entertainmentExpand];
  
  NSInteger livingExpand = 0;
  
  for (EPDataModel *dataModel in self.living) {
    livingExpand += dataModel.cost;
  }
  
  self.livingExpandLabel.text = [NSString stringWithFormat:@"%d", livingExpand];

  self.eatingEnd.text = [NSString stringWithFormat:@"%d", eatingValue - eatingExpand];
  self.entertainmentEnd.text = [NSString stringWithFormat:@"%d", entertainmentValue - entertainmentExpand];
  self.livingEnd.text = [NSString  stringWithFormat:@"%d", livingValue - livingExpand];
  
  self.totalLabel.text = [NSString stringWithFormat:@"%d", eatingValue + livingValue + entertainmentValue - eatingExpand -entertainmentExpand - livingExpand];
  
  if ((eatingValue + livingValue + entertainmentValue - eatingExpand -entertainmentExpand - livingExpand) == 0) {
    [self performSelector:@selector(goButtonAction)];
  }
  
  NSLog(@"living: %d", [self.living count]);
  NSLog(@"entertainment: %d", [self.entertainment count]);
  NSLog(@"eating: %d", [self.eating count]);
  
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
