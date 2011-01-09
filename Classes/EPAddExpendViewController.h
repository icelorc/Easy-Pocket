//
//  EPAddExpendViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/8.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPDataModel.h"


@interface EPAddExpendViewController : UITableViewController <UIPickerViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>{
  UIPickerView *_pickerView;
  UIDatePicker *_datePickerView;
  UITextField *_detailField;
  UITextField *_costField;
  UIActionSheet *_actionSheet;
  
  NSArray *_categoryArray;
  NSArray *_EattingArray;
  NSArray *_livingArray;
  
  NSInteger _category;
  
  EPDataModel *_dataModel;
  
}

@end
