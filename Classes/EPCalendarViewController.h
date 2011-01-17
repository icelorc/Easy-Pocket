//
//  EPCalendarViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../devinross-tapkulibrary-5a808aa/src/TapkuLibrary/TapkuLibrary.h"
#import "EPDataModel.h"

@interface EPCalendarViewController : TKCalendarMonthTableViewController {
  NSMutableArray *totalSourceArray;
  NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
  NSMutableArray *_eating;
  NSMutableArray *_entertainment;
  NSMutableArray *_living;
}

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (retain,nonatomic) NSMutableArray *totalSourceArray;


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;
- (id)initWithEating:(NSMutableArray *)eating entertainment:(NSMutableArray *)entertainment living:(NSMutableArray *)living;


@end
