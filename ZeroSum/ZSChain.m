//
//  ZSChain.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSChain.h"

@implementation ZSChain {
  NSMutableArray *chain;
}

- (ZSChain *)init {
  if (self = [super init]) {
    chain = [[NSMutableArray alloc] init];
    _runningSum = 0;
  }
  return self;
}

- (void)addTile:(ZSTileNode *)tile {
  [chain addObject:tile];
  _runningSum += tile.value;
}

- (ZSTileNode *)lastTile {
  return [chain lastObject];
}

- (ZSTileNode *)popTile {
  if ([chain count] == 0) return nil;

  ZSTileNode *ret = [chain lastObject];
  [chain removeLastObject];
  _runningSum += -1 * ret.value;
  return ret;
}

@end
