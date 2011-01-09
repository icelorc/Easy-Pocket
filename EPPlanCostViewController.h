//
//  EPPlanCostViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/9.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPPlanCostViewControllerDelegate;

@interface EPPlanCostViewController : UIViewController <UITextFieldDelegate>{
  UITextField *_eatingField;
  UITextField *_entertainmentField;
  UITextField *_livingField;
  
  UILabel *_totalLabel;
  
  id<EPPlanCostViewControllerDelegate>delegate;
}

@property (nonatomic, retain)IBOutlet UITextField *eatingField;
@property (nonatomic, retain)IBOutlet UITextField *entertainmentField;
@property (nonatomic, retain)IBOutlet UITextField *livingField;

@property (nonatomic, retain)IBOutlet UILabel *totalLabel;

@property (nonatomic, retain)id <EPPlanCostViewControllerDelegate>delegate;

- (IBAction)backgroundTap;


@end

@protocol EPPlanCostViewControllerDelegate

- (void)planCostViewController:(EPPlanCostViewController *)planCostViewController eatingValue:(NSInteger)eatingValue entertainmentValue:(NSInteger)entertainmentValue livingValue:(NSInteger)livingValue;

@end

