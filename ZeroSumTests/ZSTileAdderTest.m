//
//  ZSTileAdderTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSGod.h"
#import "ZSBoardNode.h"
#import "ZSTileAdder.h"
#import "ZSUtility.h"

@interface ZSTileAdderTest : XCTestCase

@end

@implementation ZSTileAdderTest {
  ZSGod *god;
  ZSTileAdder *t;
}

- (void)setUp {
  [super setUp];
  god = [[ZSGod alloc] initWithBoard:[ZSBoardNode node]];
  t = [[ZSTileAdder alloc] initWithGod:god];
  t.addDuration = 0.1;
  t.emergeDuration = 0.1;
  [t start:0];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testClearQueue {
  NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow:1.0];
  [[NSRunLoop currentRunLoop] runUntilDate:runUntil];
  // queue should have filled up by now.
  XCTAssert([god.gameboard getFreeColumn] == -1,
            "tileAdder should fill up the queue.");

  [god.gameboard removeNewTileAtColumn:0];
  [t clearQueue:0];
  XCTAssert([god.gameboard newTileAtColumn:0] != nil,
            "clearQueue should instantly add new tile to board.");
}

- (void)testStop {
  int nt, rt;
  [self countTiles:&nt andNewTiles:&rt];
  [t stop];

  NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow:1.0];
  [[NSRunLoop currentRunLoop] runUntilDate:runUntil];

  // No new tiles should be added
  int _nt, _rt;
  [self countTiles:&_nt andNewTiles:&_rt];
  XCTAssert(rt == _rt && nt == _nt,
            "tileAdder should not add or emerge tiles after stop is called.");
}

- (void)countTiles:(int *)tiles andNewTiles:(int *)newTiles {
  int _newTiles = 0, _tiles = 0;
  for (int i = 0; i < BOARD_COLUMNS; i++) {
    if ([god.gameboard newTileAtColumn:i]) _newTiles++;
    for (int k = 0; k < BOARD_ROWS; k++) {
      if ([god.gameboard tileAtColumn:i andRow:k]) _tiles++;
    }
  }
  *tiles = _tiles;
  *newTiles = _newTiles;
}

@end
