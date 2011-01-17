//
//  EPAddExpendViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/8.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPAddExpendViewController.h"


@implementation EPAddExpendViewController

@synthesize delegate;

#pragma mark -
#pragma mark Initialization


- (id)init {
  // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    _dataModel = [[EPDataModel alloc] init];
    _categoryArray = [[NSArray alloc] initWithObjects:@"Eating", @"Entertainment", @"Living", nil];
    // Custom initialization.
  }
  return self;
}

- (void)doneItem {

  _dataModel.cost = [_costField.text intValue];
  _dataModel.detail = _detailField.text;
  _dataModel.category = _category;
  _dataModel.date = [_datePickerView date];
  
  [delegate addExpandViewController:self dataModel:_dataModel];

  [self dismissModalViewControllerAnimated:YES];
  
  
  
}

- (void)cancelItem {
  
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 160)];
  _pickerView.showsSelectionIndicator = YES;
  _pickerView.opaque = YES;
  _pickerView.delegate = self;
  
  _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 160)];
  _datePickerView.datePickerMode = UIDatePickerModeDate;
  
  _detailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 160, 23)];
  _detailField.textAlignment = UITextAlignmentRight;
  _costField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 160, 23)]; 
  _costField.keyboardType = UIKeyboardTypeNumberPad;
  _costField.textAlignment = UITextAlignmentRight;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneItem)];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItem)];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"EPAddExpemdViewCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = @"Category";
      break;
    case 1:
      cell.textLabel.text = @"Detail";
      cell.accessoryView = _detailField;
      _detailField.placeholder = @"Enter something.";
      break;
    case 2:
      cell.textLabel.text = @"Cost";
      cell.accessoryView = _costField;
      _costField.placeholder = @"Enter how much.";
      break;
    case 3:
      cell.textLabel.text = @"Date";
      break;
      
    default:
      break;
  }
  
  
  return cell;
}

- (void)donePickerItem {
  
  _dataModel.category = _category;
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
 
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 23)];
  label.textAlignment = UITextAlignmentRight;
  cell.accessoryView = label;
  label.text = [_categoryArray objectAtIndex:_category];
  [_actionSheet dismissWithClickedButtonIndex:0 animated:YES];
  
}

- (void)doneDatePickerItem {
  
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Taipei"]];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSString *result = [formatter stringFromDate:[_datePickerView date]];
  
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 23)];
  label.textAlignment = UITextAlignmentRight;
  cell.accessoryView = label;
  label.text = result;
  [_actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)cancelPickerItem {
  [_actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 1 || indexPath.row == 2) {
    return;
  }
  
  UIToolbar *pickerToolBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
  pickerToolBar.barStyle = UIBarStyleBlack;
  
  UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPickerItem)];
  UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
  
  
  _actionSheet = [[UIActionSheet alloc] initWithTitle:@"This is where the information will go" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"First", @"Second", @"Cancel", nil];
  _actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
  _actionSheet.destructiveButtonIndex = 3;
  [_actionSheet addSubview:pickerToolBar];
  
  UIBarButtonItem *doneBarButtonItem;
  
  if (indexPath.row == 0) {
    doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(donePickerItem)];

    [_actionSheet addSubview:_pickerView];

    
  }else if (indexPath.row == 3) {
    doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneDatePickerItem)];

    [_actionSheet addSubview:_datePickerView];
  }
  
  [pickerToolBar setItems:[NSArray arrayWithObjects:cancelBarButtonItem, flexibleSpace, doneBarButtonItem, nil]];

  
  [_actionSheet showInView:self.view];
  [doneBarButtonItem release];
  [cancelBarButtonItem release];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
  return [_categoryArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [_categoryArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  _category = row;
}

#pragma mark -
#pragma mark UITextFieldDelegate


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
}


- (void)dealloc {
  [super dealloc];
}


@end

