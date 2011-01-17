//
//  EPCalendarViewController.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPCalendarViewController.h"


@implementation EPCalendarViewController

@synthesize dataArray, dataDictionary;
@synthesize totalSourceArray;

- (id)initWithEating:(NSMutableArray *)eating entertainment:(NSMutableArray *)entertainment living:(NSMutableArray *)living {
  if (self = [super initWithSunday:YES]) {
    
    _eating = eating;
    _entertainment = entertainment;
    _living = living;
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calendar" image:[UIImage imageNamed:@"Calendar.png"] tag:2];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.monthView selectDate:[NSDate date]];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.title = @"Calendar";
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

- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
	// CHANGE THE DATE TO YOUR TIMEZONE
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
	NSLog(@"Date Selected: %@",myTimeZoneDay);
	
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d{
	[super calendarMonthView:mv monthDidChange:d];
	[self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
  
  
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
  
  EPDataModel *dataModel = [ar objectAtIndex:indexPath.row];
  cell.textLabel.text = dataModel.detail;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", dataModel.cost];
  
	
  return cell;
	
}


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
  
  
  
  NSDateFormatter *formatter1 = [[[NSDateFormatter alloc] init] autorelease];
  [formatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Taipei"]];
  [formatter1 setDateFormat:@"yyyyMMdd"];
  NSString *endResult = [formatter1 stringFromDate:end];
  
  
	
	NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
	
  NSMutableArray *totalArray = [[[NSMutableArray alloc] init] autorelease];
  [totalArray addObjectsFromArray:_eating];
  [totalArray addObjectsFromArray:_entertainment];
  [totalArray addObjectsFromArray:_living];
  
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
  
  for (int i = 0; i < 42; i++) {
    [self.dataArray addObject:[NSNumber numberWithBool:NO]];
  }
  
  
  
  for (EPDataModel *dataModel in totalArray) {
    NSDateFormatter *formatter2 = [[[NSDateFormatter alloc] init] autorelease];
    [formatter2 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Taipei"]];
    [formatter2 setDateFormat:@"yyyyMMdd"];
    NSString *modelResult = [formatter2 stringFromDate:[dataModel date]];
    
    
    
    
    NSDate *d = start;
    NSLog(@"starDate: %@", [start dateDescription]);
    NSLog(@"EndDate: %@", [end dateDescription]);
    
    int j = 1;
    
    while(YES){
      
      
      
      /*
       int r = arc4random();
       if(r % 3==1){
       [self.dataDictionary setObject:[NSArray arrayWithObjects:@"Breakfast",@"Lunch", nil] forKey:d];
       [self.dataArray addObject:[NSNumber numberWithBool:YES]];
       
       }else if(r%4==1){
       [self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",nil] forKey:d];
       [self.dataArray addObject:[NSNumber numberWithBool:YES]];
       
       }else
       
       */
      
      TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
      info.day++;
      d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Taipei"]];
      [formatter setDateFormat:@"yyyyMMdd"];
      NSString *startResult = [formatter stringFromDate:d];
      
      NSLog(@"startResult: %d, modelResult: %d", [startResult intValue], [modelResult intValue]);
      
      if ([startResult intValue] == [modelResult intValue]) {
        if ([[self.dataArray objectAtIndex:j] boolValue] == YES) {
          NSMutableArray *ar = [dataDictionary objectForKey:d];
          [ar addObject:dataModel];
          [self.dataDictionary setObject:ar forKey:d];
        } else {
          [self.dataArray replaceObjectAtIndex:j withObject:[NSNumber numberWithBool:YES]];
          NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:dataModel, nil] autorelease];
          [self.dataDictionary setObject:array forKey:d];
          
        }
      }
      
      if([d compare:end]==NSOrderedDescending) break;
      j++;
    }
    
  }
	
}


@end
