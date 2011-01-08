//
//  EPAddExpendViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/8.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EPAddExpendViewController : UITableViewController <UIPickerViewDelegate, UITextFieldDelegate>{
  UIPickerView *_pickerView;
  UITextField *_detailField;
  UITextField *costField;
  
}

@end
