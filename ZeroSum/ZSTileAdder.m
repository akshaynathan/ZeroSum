//
//  ZSTileAdder.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSTileAdder.h"
#import "ZSBoardNode.h"
#import "ZSUtility.h"
#import "ZSNewTileNode.h"
#import "ZSGod.h"

@implementation ZSTileAdder {
  ZSGod *god;
  NSTimer *addNextTile;
  NSTimer *emergeTimers[BOARD_COLUMNS];
  NSMutableArray *tilesBackLog;
}

- (ZSTileAdder *)initWithGod:(ZSGod *)g {
  if (self = [super init]) {
    god = g;
    tilesBackLog = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)start:(double)waitTime {
  addNextTile = [NSTimer scheduledTimerWithTimeInterval:waitTime
                                                 target:self
                                               selector:@selector(addNewTile)
                                               userInfo:nil
                                                repeats:NO];
}

/**
 *  Add a new tile to the board.
 *  If there is no space the, tile is added to the queue.
 *  Also reschedules the timer for the next tile to add.
 *
 *  @return The new tile that was added.
 */
- (ZSNewTileNode *)addNewTile {
  ZSNewTileNode *n = [ZSNewTileNode nodeWithValue:[god suggestNewTileValue]];
  int new_column = [god.gameboard getFreeColumn];
  if (new_column == -1) {
    // Add tile to queue for later
    // TODO: Add tests for the queue.
    [tilesBackLog addObject:n];
  } else {
    [god.gameboard addNewTile:n atColumn:new_column];
    emergeTimers[n.column] = [self addEmergeTimer:n];
    [n startAnimation:_emergeDuration];
  }

  // Reset timer
  addNextTile = [NSTimer scheduledTimerWithTimeInterval:_addDuration
                                                 target:self
                                               selector:@selector(addNewTile)
                                               userInfo:nil
                                                repeats:NO];
  return n;
}

- (void)stop {
  [addNextTile invalidate];
  for (int i = 0; i < BOARD_COLUMNS; i++) {
    [emergeTimers[i] invalidate];
  }
}

/**
 *  Adds a timer for this tile to auto emerge.
 *
 *  @param n The new tile.
 *
 *  @return The created timer.
 */
- (NSTimer *)addEmergeTimer:(ZSNewTileNode *)n {
  return [NSTimer scheduledTimerWithTimeInterval:_emergeDuration
                                          target:self
                                        selector:@selector(emergeTile:)
                                        userInfo:n
                                         repeats:NO];
}

/**
 *  Helper method to call god.transitionNewTile.
 *
 *  @param t The timer.
 */
- (void)emergeTile:(NSTimer *)t {
  [god transitionNewTile:(ZSNewTileNode *)t.userInfo];
}

/**
 *  If the queue has items, this will add the first new tile
 *  to the newly opened position.
 *
 *  @param column The column to add the new tile to.
 */
- (void)clearQueue:(int)column {
  if ([tilesBackLog count] != 0) {
    ZSNewTileNode *k = [tilesBackLog objectAtIndex:0];
    [tilesBackLog removeObjectAtIndex:0];
    [god.gameboard addNewTile:k atColumn:column];
  }
}

@end
