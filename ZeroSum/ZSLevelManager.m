//
//  ZSLevelManager.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSLevelManager.h"

@implementation ZSLevelManager

/**
 *  This holds the levelData values for each level.
 *  Use this to adjust game difficulty.
 */
static LevelData levelData[] = {{3.0, 12.0},
                                {3.0, 10.0},
                                {2.0, 10.0},
                                {2.0, 9.0},
                                {2.0, 8.0},
                                {2.0, 8.0},
                                {1.0, 8.0},
                                {1.0, 6.0},
                                {1.0, 5.0},
                                {0.5, 4.0}};

- (id)init {
  if (self = [super init]) {
    _level = 1;
  }
  return self;
}

- (LevelData)updateLevelWithScore:(int)score andChains:(int)chains {
  _level = [self calculateNewLevelForScore:score andChains:chains];
  return levelData[_level - 1];
}

/**
 *  Calculate the new level.
 *
 *  @param score  The current score.
 *  @param chains Total number of chains.
 *
 *  @return The correct level.
 */
- (int)calculateNewLevelForScore:(int)score andChains:(int)chains {
  int c = sqrt(chains);  // 25 chains = level 5, 100 chains = level 10
  int s = score > 0 ? log2(score / 2) : 1;
  return MAX(1, MIN(ceil((c + s) / 2), 10));
}

@end
