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


@interface EPMainViewController : UIViewController {

  NSMutableArray *_living;
  NSMutableArray *_entertainment;
  NSMutableArray *_eating;
  
  UIButton *_goButton;
  
}

@property (nonatomic, retain)NSMutableArray *living;
@property (nonatomic, retain)NSMutableArray *entertainment;
@property (nonatomic, retain)NSMutableArray *eating;
@property (nonatomic, retain)IBOutlet UIButton *goButton;

- (IBAction)goButtonAction;

@end
