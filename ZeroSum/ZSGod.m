//
//  ZSGod.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/16/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGod.h"
#import "ZSUtility.h"
#import "ZSBoardNode.h"
#import "ZSTileNode.h"
#import "ZSChain.h"
#import "ZSNewTileNode.h"
#import "ZSTileAdder.h"
#import "ZSScore.h"
#import "ZSLevelManager.h"

@implementation ZSGod {
  ZSChain *chain;
  ZSTileAdder *tileAdder;
  int currentLevel;
  int chains;
}

- (ZSGod *)initWithBoard:(ZSBoardNode *)board {
  if (self = [super init]) {
    _gameboard = board;
    chain = [[ZSChain alloc] init];
    tileAdder = [[ZSTileAdder alloc] initWithGod:self];
    _score = [[ZSScore alloc] init];
    _levelMan = [[ZSLevelManager alloc] init];
    chains = 0;
  }
  return self;
}

- (void)start {
  // Create starting tiles
  [self initStartingTiles];

  // Start the tileAdder
  // TODO: Make this part of the level manager
  tileAdder.emergeDuration = 5.0;
  tileAdder.addDuration = 10.0;
  [tileAdder start:GRACE_PERIOD];
}

/**
 *  Add the starting tiles to each row.
 */
- (void)initStartingTiles {
  for (int i = 0; i < BOARD_COLUMNS; i++) {
    for (int k = 0; k < STARTING_TILES; k++) {
      ZSTileNode *t = [ZSTileNode nodeWithValue:[ZSUtility randomValue]];
      [_gameboard addTile:t atColumn:i andRow:k];
    }
  }
}

- (ZSTileNode *)addTileToChain:(ZSTileNode *)tile {
  // No repeats
  if (tile == [chain lastTile]) return nil;

  // No non neighbors
  if (!([tile isNeighborsWith:[chain lastTile]]) && [chain lastTile] != nil)
    return nil;

  // No cycles
  if ([tile isConnected]) return nil;
  [[chain lastTile] connectTo:tile];
  [chain addTile:tile];
  return tile;
}

- (int)clearChain {
  int sum = [chain runningSum];
  if (sum == 0) {
    int length = 0;
    while ([chain lastTile] != nil) {
      ZSTileNode *t = [chain popTile];
      [_gameboard removeTileAtColumn:t.column andRow:t.row];
      length += 1;
    }
    chains++;
    // TODO: Integrate this with level manager
    [_score updateScore:[ZSScore calculateScoreForLevel:currentLevel
                                         andChainLength:length]];
    [self updateLevel];
  } else {
    while ([chain lastTile] != nil) {
      ZSTileNode *t = [chain popTile];
      [t disconnect];
    }
  }
  return sum;
}

/**
 *  Update the level and set the durations.
 */
- (void)updateLevel {
  LevelData l = [_levelMan updateLevelWithScore:_score.score andChains:chains];
  currentLevel = _levelMan.level;
  tileAdder.addDuration = l.addDuration;
  tileAdder.emergeDuration = l.emergeDuration;
  NSLog(@"Level %d\n", currentLevel);
}

- (ZSTileNode *)transitionNewTile:(ZSNewTileNode *)t {
  // Do not transition a tile that is already emerging
  if (t.isEmerging == YES) return nil;

  ZSTileNode *ret = [t toRealTile];

  // Add the real tile.
  [_gameboard addTile:ret atColumn:ret.column andRow:0];

  // TODO: Add tests for this animation
  // Animate the new tile away
  [t runAction:[SKAction fadeOutWithDuration:NEW_TILE_FADE_DURATION]
      completion:^() {
          [_gameboard removeNewTileAtColumn:ret.column];

          // Once we've transitioned the newTile, we can
          // add the next tile from the queue.
          [tileAdder clearQueue:ret.column];
      }];
  return ret;
}
@end
