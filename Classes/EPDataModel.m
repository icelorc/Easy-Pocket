//
//  EPDataModel.m
//  EasyPockect
//
//  Created by icelorc on 2011/1/8.
//  Copyright 2011 Polydice Inc. All rights reserved.
//

#import "EPDataModel.h"


@implementation EPDataModel

@synthesize category = _category;
@synthesize detail = _detail;
@synthesize cost = _cost;
@synthesize date = _date;

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeInteger:self.category forKey:@"EPCategory"];
  [coder encodeObject:self.detail forKey:@"EPDetail"];
  [coder encodeInteger:self.cost forKey:@"EPCost"];
  [coder encodeObject:self.date forKey:@"EPDate"];
}

- (id)initWithCoder:(NSCoder *)coder {
  if (self = [super init]) {
    self.category = [coder decodeIntegerForKey:@"EPCategory"];
    self.detail = [coder decodeObjectForKey:@"EPDetail"];
    self.cost = [coder decodeIntegerForKey:@"EPCost"];
    self.date = [coder decodeObjectForKey:@"EPDate"];
  }
  return self;
}

@end
