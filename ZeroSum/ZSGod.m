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
#import "ZSGameScene.h"

@implementation ZSGod {
  ZSTileAdder *tileAdder;
  ZSGameScene *scene;
  int currentLevel;
  int chains;
}

- (ZSGod *)initWithBoard:(ZSBoardNode *)board inScene:(ZSGameScene *)gamescene {
  if (self = [super init]) {
    _gameboard = board;
    _chain = [[ZSChain alloc] init];
    tileAdder = [[ZSTileAdder alloc] initWithGod:self];
    scene = gamescene;
    _score = [[ZSScore alloc] init];
    _levelMan = [[ZSLevelManager alloc] init];
    chains = 0;
  }
  return self;
}

- (void)start {
  _state = RUNNING;

  // Create starting tiles
  [self initStartingTiles];

  // Start the tileAdder
  [self updateLevel];
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
  // Don't do anything if the game is already stopped.
  if (_state == STOPPED) return nil;

  // No repeats
  if (tile == [_chain lastTile]) return nil;

  // No non neighbors
  if (!([tile isNeighborsWith:[_chain lastTile]]) && [_chain lastTile] != nil)
    return nil;

  // No cycles
  if ([tile isConnected]) return nil;
  [[_chain lastTile] connectTo:tile];
  [_chain addTile:tile];
  return tile;
}

- (int)clearChain {
  int sum = [_chain runningSum];
  if (sum == 0) {
    int length = 0;
    while ([_chain lastTile] != nil) {
      ZSTileNode *t = [_chain popTile];
      [_gameboard removeTileAtColumn:t.column andRow:t.row];
      length += 1;
    }
    chains++;
    [_score updateScore:[ZSScore calculateScoreForLevel:currentLevel
                                         andChainLength:length]];
    [self updateLevel];
  } else {
    [self deleteChain];
  }
  return sum;
}

- (int)suggestNewTileValue {
  int necessary = 0 - _gameboard.totalSum;
  int suggestion = arc4random_uniform(SUGGEST_BUFFER) + necessary;
  suggestion = MAX(suggestion, -9);
  suggestion = MIN(suggestion, 9);
  return suggestion;
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

  // Don't do anything if the game is over.
  // This should never happen b/c we delete all the timers.
  if (_state == STOPPED) return nil;

  // Check if the game is over
  if ([_gameboard tileAtColumn:t.column andRow:BOARD_ROWS - 1] != nil) {
    [self gameOver];
    return nil;
  }

  ZSTileNode *ret = [t toRealTile];

  // Break any chains that should be broken
  int i = 0;
  ZSTileNode *check = [_gameboard tileAtColumn:t.column andRow:i];
  while (check != nil) {
    if ([check isConnected] || check == [_chain lastTile]) {
      [self deleteChain];
      break;
    }
    check = [_gameboard tileAtColumn:t.column andRow:++i];
  }

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

/**
 *  Just a helper method to call [gamescene gameover];
 */
- (void)gameOver {
  _state = STOPPED;
  // Stop adding tiles
  [tileAdder stop];
  // End the game scene
  [scene gameOver];
}

/**
 *  Deletes the chain, but doesnt delete the tiles.
 */
- (void)deleteChain {
  while ([_chain lastTile] != nil) {
    ZSTileNode *t = [_chain popTile];
    [t disconnect];
  }
}
@end
