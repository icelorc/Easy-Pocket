//
//  EPMainViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPAddExpendViewController.h"
#import "EPPlanCostViewController.h"


@interface EPMainViewController : UIViewController <EPPlanCostViewControllerDelegate, EPAddExpandViewControllerDelegate>{

  NSMutableArray *_living;
  NSMutableArray *_entertainment;
  NSMutableArray *_eating;
  
  UILabel *_eatingLabel;
  UILabel *_entertainmentLabel;
  UILabel *_livingLabel;
  UILabel *_totalLabel;
  
  UILabel *_eatingExpandLabel;
  UILabel *_entertainmentExpandLabel;
  UILabel *_livingExpandLabel;
  
  UILabel *_eatingEnd;
  UILabel *_entertainmentEnd;
  UILabel *_livingEnd;
  
  UIButton *_goButton;
  
}

@property (nonatomic, retain)NSMutableArray *living;
@property (nonatomic, retain)NSMutableArray *entertainment;
@property (nonatomic, retain)NSMutableArray *eating;
@property (nonatomic, retain)IBOutlet UIButton *goButton;
@property (nonatomic, retain)IBOutlet UILabel *eatingLabel;
@property (nonatomic, retain)IBOutlet UILabel *entertainmentLabel;
@property (nonatomic, retain)IBOutlet UILabel *livingLabel;
@property (nonatomic, retain)IBOutlet UILabel *totalLabel;

@property (nonatomic, retain)IBOutlet UILabel *eatingExpandLabel;
@property (nonatomic, retain)IBOutlet UILabel *entertainmentExpandLabel;
@property (nonatomic, retain)IBOutlet UILabel *livingExpandLabel;

@property (nonatomic, retain)IBOutlet UILabel *eatingEnd;
@property (nonatomic, retain)IBOutlet UILabel *entertainmentEnd;
@property (nonatomic, retain)IBOutlet UILabel *livingEnd;

- (IBAction)goButtonAction;

@end
