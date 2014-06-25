//
//  ZSLevelManager.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZSLevelManager : SKNode

@property(atomic, readonly) int level;

/**
 *  Holds the per level specific data.
 */
typedef struct LevelData {
  double addDuration;
  double emergeDuration;
} LevelData;

/**
 *  Update the level manager with the new parameters.
 *
 *  @param score  The current score.
 *  @param chains The total number of chains cleared. (successfully)
 *
 *  @return The new level.
 */
- (LevelData)updateLevelWithScore:(int)score andChains:(int)chains;

@end
