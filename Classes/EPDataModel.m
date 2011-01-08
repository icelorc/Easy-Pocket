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
  [coder encodeObject:self.category forKey:@"EPCategory"];
  [coder encodeObject:self.detail forKey:@"EPDetail"];
  [coder encodeObject:self.cost forKey:@"EPCost"];
  [coder encodeObject:self.date forKey:@"EPDate"];
}

- (id)initWithCoder:(NSCoder *)coder {
  if (self = [super init]) {
    self.category = [coder  decodeObjectForKey:@"EPCategory"];
    self.detail = [coder decodeObjectForKey:@"EPDetail"];
    self.cost = [coder decodeObjectForKey:@"EPCost"];
    self.date = [coder decodeObjectForKey:@"EPDate"];
  }
  return self;
}

@end
