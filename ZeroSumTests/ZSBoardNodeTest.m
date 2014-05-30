//
//  ZSBoardNodeTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 5/20/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSBoardNode.h"
#import "ZSUtility.h"

@interface ZSBoardNodeTest : XCTestCase

@end

@class ZSTileNode;

@implementation ZSBoardNodeTest {
    ZSBoardNode *board;
}

- (void)setUp {
    [super setUp];
    board = [ZSBoardNode node];
    [board initTiles:5]; // Add 5 tiles to each column
}
/*
- (void)testInitTiles {
    // Make sure all the rows have exactly 5 tiles
    for(int i = 0; i < BOARD_COLUMNS; i++) {
        for(int k = 0; k < BOARD_ROWS; k++) {
            ZSTileNode *tmp = [board tileAtColumn:i andRow: k];
            if((k < 5 && tmp == nil) ||
               (k >= 5 && tmp != nil)) {
                XCTFail();
            }
        }
    }
}

- (void)testTileAtPosition {
    // Definitely should exist if the last test was passed
    XCTAssertNotNil([board tileAtColumn:0 andRow: 0]);
    
    // off the board
    XCTAssertNil([board tileAtColumn:15 andRow:6]);
}

- (void)testAddTileAtPosition {
    ZSTileNode *tile = [ZSTileNode nodeWithValue: 5];
    
    // Adding a non-contiguous tile should not work
    //ZSTileNode *t = [board addTile:tile atColumn:0 andRow:6];
    XCTAssertNil(t);
    
    // But adding a contiguous tile should work
    ZSTileNode *old = [board tileAtColumn:0 andRow:2];
    //t = [board addTile:tile atColumn:0 andRow:2];
    XCTAssert(t == tile);
    
    // And we should shift everything else up
    XCTAssert(old.row == 3);
}

- (void)testRemoveTileAtPosition {
    // We shouldn't be able to remove non-existant tiles
    ZSTileNode *t = [board removeTileAtColumn:0 andRow:6];
    XCTAssertNil(t);
    
    // Legitimate removal works
    ZSTileNode *k = [board tileAtColumn:3 andRow:2];
    ZSTileNode *old = [board tileAtColumn:3 andRow:4];
    t = [board removeTileAtColumn:3 andRow:2];
    XCTAssert(k == t); // Removed the right tile
    XCTAssert(old.row = 3); // Shift down
}
*/
- (void)tearDown {
    [super tearDown];
}

@end
