//
//  EPCalendarViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../devinross-tapkulibrary-5a808aa/src/TapkuLibrary/TapkuLibrary.h"

@interface EPCalendarViewController : TKCalendarMonthTableViewController {
  NSMutableArray *sourceArray1;
  NSMutableArray *sourceArray2;
  NSMutableArray *sourceArray3;
  NSMutableArray *totalSourceArray;
  NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
}

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (retain,nonatomic) NSMutableArray *sourceArray1;
@property (retain,nonatomic) NSMutableArray *sourceArray2;
@property (retain,nonatomic) NSMutableArray *sourceArray3;
@property (retain,nonatomic) NSMutableArray *totalSourceArray;


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

@end
