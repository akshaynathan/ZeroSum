//
//  ZSGodTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/18/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSGod.h"
#import "ZSBoardNode.h"
#import "ZSTileNode.h"
#import "ZSNewTileNode.h"
#import "ZSChain.h"

@interface ZSGodTest : XCTestCase

@end

@implementation ZSGodTest {
  ZSGod *god;
  ZSBoardNode *board;
}

- (void)setUp {
  [super setUp];
  board = [ZSBoardNode node];
  god = [[ZSGod alloc] initWithBoard:board];
  [god start];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testStart {
  XCTAssert(god.state == RUNNING, "start should change god state to running.");

  for (int i = 0; i < BOARD_COLUMNS; i++) {
    for (int k = 0; k < STARTING_TILES; k++) {
      XCTAssert([god.gameboard tileAtColumn:i andRow:k] != nil,
                "start should add init tiles.");
    }
  }
}

- (void)testAddTileToChain {
  ZSTileNode *initial = [board tileAtColumn:0 andRow:0];
  ZSTileNode *next = [god addTileToChain:initial];
  XCTAssert(next == initial, "Creating new chain should succeed.");

  next = [god addTileToChain:initial];
  XCTAssert(next == nil, "Repeat adding tile to chain should fail.");

  ZSTileNode *invalid = [board tileAtColumn:1 andRow:3];
  next = [god addTileToChain:invalid];
  XCTAssert(next == nil, "Adding invalid tile to chain should fail.");

  ZSTileNode *valid = [board tileAtColumn:1 andRow:0];
  next = [god addTileToChain:valid];
  XCTAssert(next == valid, "Adding valid tile should succeed");

  XCTAssert([initial isConnected] == YES,
            "Adding tile should connect previous tile.");
}

- (void)testClearChain {
  // This test is tricky, we will add two tiles to the first column
  // one that will not make the column sum 0, and one that will.
  // We will then assure that clearChain does not delete the column
  // with only the first tile, but does when the second tile is added.
  int value = 0;
  for (int i = 0; i < STARTING_TILES; i++) {
    ZSTileNode *t = [god addTileToChain:[board tileAtColumn:0 andRow:i]];
    value += t.value;
  }

  int newTile = -9;
  while (value + newTile == 0) newTile++;

  [board addTile:[ZSTileNode nodeWithValue:newTile]
        atColumn:0
          andRow:STARTING_TILES];

  int endTile = 0 - (newTile + value);
  [board addTile:[ZSTileNode nodeWithValue:endTile]
        atColumn:0
          andRow:STARTING_TILES + 1];

  [god addTileToChain:[board tileAtColumn:0 andRow:5]];
  int sum = [god clearChain];
  XCTAssert(sum != 0, "Non-clearable chain should return non zero sum.");
  XCTAssert([god clearChain] == 0, "Empty chain should return 0 sum.");
  XCTAssertNotNil([board tileAtColumn:0 andRow:0],
                  "Non Zero chain should not delete tiles.");
  XCTAssert([[board tileAtColumn:0 andRow:0] isConnected] != YES,
            "clearChain should remove connections");

  for (int i = 0; i < STARTING_TILES + 2; i++) {
    [god addTileToChain:[board tileAtColumn:0 andRow:i]];
  }

  sum = [god clearChain];
  XCTAssert(sum == 0, "Chain should return non zero sum.");
  XCTAssertNil([board tileAtColumn:0 andRow:0],
               "clearChain should delete tiles.");
}

- (void)testTransitionNewTile {
  ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
  [board addNewTile:k atColumn:2];
  [god addTileToChain:[board tileAtColumn:2 andRow:3]];
  [god addTileToChain:[board tileAtColumn:3 andRow:3]];

  ZSTileNode *f = [god transitionNewTile:k];
  XCTAssert(f == [board tileAtColumn:2 andRow:0],
            "transitionNewTile should add real tile.");
  XCTAssert([k hasActions], "transitionNewTile should add animation action.");
  XCTAssertNil([god.chain lastTile],
               "transitionNewTile should destroy chain if needed");
  f = [god transitionNewTile:k];
  XCTAssert(f == nil,
            "transitionNewTile should not transition a tile that is already "
            "emerging");

  for (int i = 0; i < BOARD_ROWS - STARTING_TILES; i++) {
    ZSTileNode *t = [ZSTileNode nodeWithValue:5];
    [board addTile:t atColumn:3 andRow:i];
  }

  k = [ZSNewTileNode nodeWithValue:5];
  [board addNewTile:k atColumn:3];
  [god transitionNewTile:k];
  XCTAssert(god.state == STOPPED,
            "transitionNewTile should check for gameover.");
}

- (void)testSuggestNewTileValue {
  int suggestion = [god suggestNewTileValue];
  int newSum = board.totalSum + suggestion;
  XCTAssert(abs(0 - newSum) < abs(0 - board.totalSum) ||
                abs(board.totalSum - newSum) <= SUGGEST_BUFFER,
            "suggestNewTileValue should move totalSum towards 0.");
}

@end
