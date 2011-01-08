//
//  EPDataModel.h
//  EasyPockect
//
//  Created by icelorc on 2011/1/8.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPDataModel : NSObject {
  NSInteger _category;
  NSString *_detail;
  NSInteger _cost;
  NSDate *date;
}

@property (nonatomic)NSInteger category;
@property (nonatomic, retain)NSString *detail;
@property (nonatomic)NSInteger cost;
@property (nonatomic, retain)NSData *date;

@end
