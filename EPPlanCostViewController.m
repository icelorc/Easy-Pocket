//
//  EPPlanCostViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/9.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPPlanCostViewController.h"


@implementation EPPlanCostViewController

@synthesize eatingField = _eatingField;
@synthesize entertainmentField = _entertainmentField;
@synthesize livingField = _livingField;

@synthesize totalLabel = _totalLabel;

@synthesize delegate;

- (IBAction)backgroundTap {
  [self.eatingField resignFirstResponder];
  [self.entertainmentField resignFirstResponder];
  [self.livingField resignFirstResponder];
  NSInteger eating = [self.eatingField.text intValue];
  NSInteger entertainment = [self.entertainmentField.text intValue];
  NSInteger living = [self.livingField.text intValue];
  
  self.totalLabel.text = [NSString stringWithFormat:@"%d", eating + entertainment + living];
  
  [delegate planCostViewController:self eatingValue:eating entertainmentValue:entertainment livingValue:living];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.eatingField.keyboardType = UIKeyboardTypeNumberPad;
  self.entertainmentField.keyboardType = UIKeyboardTypeNumberPad;
  self.livingField.keyboardType = UIKeyboardTypeNumberPad;
  
 
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  return YES;
}

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
