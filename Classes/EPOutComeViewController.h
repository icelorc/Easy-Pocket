//
//  EPOutComeViewController.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/5.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPChartViewController.h"


@interface EPOutComeViewController : UITableViewController {
  NSMutableArray *_eating;
  NSMutableArray *_entertainment;
  NSMutableArray *_living;
}

@property (nonatomic, retain)NSMutableArray *eating;
@property (nonatomic, retain)NSMutableArray *entertainment;
@property (nonatomic, retain)NSMutableArray *living;

- (id)initWithStyle:(UITableViewStyle)style eating:(NSMutableArray *)eating entertainment:(NSMutableArray *)entertainment living:(NSMutableArray *)living; 

@end
