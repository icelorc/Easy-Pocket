//
//  EPOutComeViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPOutComeViewController.h"
#import "EPDataModel.h"
#import "EasyPockectAppDelegate.h"


@implementation EPOutComeViewController

@synthesize eating = _eating;
@synthesize entertainment = _entertainment;
@synthesize living = _living;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style eating:(NSMutableArray *)eating entertainment:(NSMutableArray *)entertainment living:(NSMutableArray *)living {
  // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
  self = [super initWithStyle:style];
  if (self) {
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Outcome" image:[UIImage imageNamed:@"chart.png"] tag:1] autorelease];
    self.eating = eating;
    self.entertainment = entertainment;
    self.living = living;
  }
  return self;
}

#pragma mark -
#pragma mark navigationItem 

- (void)toChart {
  EPChartViewController *chartViewController = [[EPChartViewController alloc] initWithNibName:@"EPChartViewController" bundle:nil];
  [self.navigationController pushViewController:chartViewController animated:YES];
  [chartViewController release];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.title = @"Outcome";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chart" style:UIBarButtonItemStyleBordered target:self action:@selector(toChart)];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  [self.tableView reloadData];
  
  NSInteger eatingCost = 0, livingCost = 0, entertainmentCost = 0;
  for (EPDataModel *ele in self.eating) {
    eatingCost += ele.cost;
  }
  
  for (EPDataModel *ele in self.entertainment) {
    entertainmentCost += ele.cost;
  }
  
  for (EPDataModel *ele in self.living) {
    livingCost += ele.cost;
  }
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setInteger:eatingCost forKey:@"EatingTotalCost"];
  [userDefaults setInteger:entertainmentCost forKey:@"EntertainmentTotalCost"];
  [userDefaults setInteger:livingCost forKey:@"LivingTotalCost"];
  
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"Eating";
      break;
    case 1:
      return @"Entertainment";
      break;
    case 2:
      return @"Living";
      break;
    default:
      return nil;
      break;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  switch (section) {
    case 0:
      return [self.eating count];
      break;
    case 1:
      return [self.entertainment count];
      break;
    case 2:
      return [self.living count];
      break;
    default:
      return 0;
      break;
  }
  
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  
  EPDataModel *dataModel;
  if (indexPath.section == 0) {
    dataModel = [self.eating objectAtIndex:indexPath.row];
  } else if (indexPath.section == 1) {
    dataModel = [self.entertainment objectAtIndex:indexPath.row];
  } else if (indexPath.section == 2) {
    dataModel = [self.living objectAtIndex:indexPath.row];
  }
  cell.textLabel.text = dataModel.detail;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", dataModel.cost];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    
    NSString *documentPath = [(EasyPockectAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory];
    
    if (indexPath.section == 0) {
      [self.eating removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
      [NSKeyedArchiver archiveRootObject:self.eating toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEating-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
    } else if (indexPath.section == 1) {
      [self.entertainment removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
      [NSKeyedArchiver archiveRootObject:self.entertainment toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPEntertainment-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];

    } else if (indexPath.section == 2) {
      [self.living removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
      [NSKeyedArchiver archiveRootObject:self.living toFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"EPLiving-%@.keyedArchive", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];

    }

  }
}

- (void)tableView:(UITableView *) tableView moveRowAtIndexPath:(NSIndexPath *) fromIndexPath toIndexPath: (NSIndexPath *) toIndexPath{
  
  if (fromIndexPath.section == 0) {
    [self.eating exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
  } else if (fromIndexPath.section == 1) {
    [self.entertainment exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
  } else if (fromIndexPath.section == 2) {
    [self.living exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
  }
  
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   [detailViewController release];
   */
}


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

