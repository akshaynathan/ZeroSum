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
#import "ZSNewTileNode.h"
#import "ZSTileNode.h"

@interface ZSBoardNodeTest : XCTestCase

@end

@implementation ZSBoardNodeTest {
    ZSBoardNode *board;
}

- (void)setUp {
    [super setUp];
    board = [ZSBoardNode node];
}

/**
 *  Checks that the tile is at the right position. (Eventually)
 */
- (void)checkPosition:(ZSTileNode*)tile {
    double correct_x = tile.column * TILE_SIZE - (BOARD_COLUMNS * TILE_SIZE)/2;
    double correct_y = tile.row * TILE_SIZE - (BOARD_ROWS * TILE_SIZE)/2;
    
    // Since we are not operating in the context of a scene, there
    // is no animation loop. Thus, we need to make sure that the action
    // is registered.
    if([tile hasActions]) {
        NSString *key = [NSString stringWithFormat:@"moveTo(%d, %d)", (int)correct_x, (int)correct_y];
        XCTAssertNotNil([tile actionForKey:key]);
    } else {
        XCTAssert(tile.position.x == correct_x &&
                  tile.position.y == correct_y,
                  "Tile at incorrect position.");
    }
}

- (void)testAddTile {
    // Adding a tile on the base works
    ZSTileNode *t = [ZSTileNode nodeWithValue:4];
    ZSTileNode *k = [board addTile:t atColumn:0 andRow:0];
    XCTAssert(k == t,
              "addTile should return the added tile.");
    XCTAssert(k.row == 0 && k.column == 0,
                "addTile should set the position of the tile.");
    [self checkPosition:k];
    
    // Adding a tile on top of another works
    t = [ZSTileNode nodeWithValue:5];
    k = [board addTile:t atColumn:0 andRow:1];
    XCTAssert(k == t,
              "addTile should return the added tile.");
    XCTAssert(k.row == 1 && k.column == 0,
              "addTile should set the position of the tile.");
    [self checkPosition:k];
    
    // Adding a tile in space falls down
    t = [ZSTileNode nodeWithValue:6];
    k = [board addTile:t atColumn:0 andRow:4];
    XCTAssert(k == t,
              "addTile should return the added tile.");
    XCTAssert(k.row == 2 && k.column == 0,
              "addTile should set the position of the tile.");
    [self checkPosition:k];
    
    // Adding a tile below another works
    t = [ZSTileNode nodeWithValue:6];
    ZSTileNode* p = [board addTile:t atColumn:0 andRow:2];
    XCTAssert(p == t,
              "addTile should return the added tile.");
    XCTAssert(p.row == 2 && p.column == 0,
              "addTile should set the position of the tile.");
    XCTAssert(k.row == 3 && k.column == 0,
              "addTile should shift other tiles.");
    [self checkPosition:k];
    //[self checkPosition:p];
    
    // Adding tile off the grid should not do anything
    k = [board addTile:[ZSTileNode nodeWithValue:4] atColumn:9 andRow:10];
    XCTAssertNil(k, "addTile should return nil for locations off the grid.");
}


- (void)testRemoveTile {
    [board addTile:[ZSTileNode nodeWithValue:5] atColumn:0 andRow:1];
    [board addTile:[ZSTileNode nodeWithValue:3] atColumn:0 andRow:1];
    [board addTile:[ZSTileNode nodeWithValue:4] atColumn:0 andRow:1];
    
    // Removing non-existant tile gives nil
    ZSTileNode *t = [board removeTileAtColumn:1 andRow:0];
    XCTAssertNil(t,
                 "removeTile should return nil for tiles that dont exist.");
    
    // Removing real tile shifts other tiles down
    t = [board tileAtColumn:0 andRow:1];
    [t connectTo:[board tileAtColumn:0 andRow:2]];
    
    t = [board removeTileAtColumn:0 andRow:1];
    XCTAssert(t.value == 4,
              "removeTile is removing the wrong tile.");
    XCTAssert([board tileAtColumn:0 andRow:1].value == 3,
              "removeTile should shift down other tiles.");
    XCTAssert([t isConnected] == NO,
              "removeTile should disconnect tile.");
}

- (void)testTileAt {
    [board addTile:[ZSTileNode nodeWithValue:5] atColumn:0 andRow:1];
    [board addTile:[ZSTileNode nodeWithValue:3] atColumn:0 andRow:1];
    [board addTile:[ZSTileNode nodeWithValue:4] atColumn:0 andRow:1];
    
    XCTAssert([board tileAtColumn:0 andRow:0].value == 5,
              "tileAt returning the wrong tile.");
    XCTAssert([board tileAtColumn:0 andRow:1].value == 4,
              "tileAt returning the wrong tile.");
    XCTAssert([board tileAtColumn:0 andRow:2].value == 3,
              "tileAt returning the wrong tile.");
    XCTAssert([board tileAtColumn:0 andRow:3] == nil,
              "invalid tileAt should return nil.");
}

- (void)testAddNewTile {
    ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
    ZSNewTileNode *p = [board addNewTile:k atColumn:4];
    
    XCTAssert(p == k,
              "addNewTile should add the tile to the column.");
    
    XCTAssert(p.position.x == p.column * TILE_SIZE - (BOARD_COLUMNS * TILE_SIZE)/2,
              "addNewTile should set the position for the tile");
    
    XCTAssert(p.column == 4,
              "addNewTile should set column of new tile.");
    
    k = [ZSNewTileNode nodeWithValue:3];
    p = [board addNewTile:k atColumn:4];
    
    XCTAssertNil(p,
                 "addNewTile should return nil when there is already a tile.");
    
    XCTAssertNil([board addNewTile:k atColumn:8],
                 "addNewTile should return nil when the column is invalid.");
}

- (void)testNewTileAt {
    ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
    ZSNewTileNode *p = [board addNewTile:k atColumn:4];
    k = [board newTileAtColumn:4];
    XCTAssert(k == p,
              "tileAtColumn should return the correct tile.");
    
    XCTAssertNil([board newTileAtColumn:3],
                 "tileAtColumn should return nil when there is no tile.");
}

- (void)testRemoveNewTile {
    ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
    ZSNewTileNode *f = [ZSNewTileNode nodeWithValue:6];
    [board addNewTile:k atColumn:4];
    [board addNewTile:f atColumn:5];
    
    ZSNewTileNode *l = [board removeNewTileAtColumn:4];
    XCTAssert(l == k,
              "remove should remove the correct newtile.");
    
    l = [board newTileAtColumn:5];
    XCTAssert(l == f,
              "removal should not affect other newtiles.");
}

- (void)testGetFreeColumn {
    int k = [board getFreeColumn];
    XCTAssert(k != -1,
              "getFreeColumn should return free column index.");
    for(int i = 0; i < BOARD_COLUMNS; i++) {
        ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
        [board addNewTile:k atColumn:i];
    }
    k = [board getFreeColumn];
    XCTAssert(k == -1,
              "getFreeColumn should return -1 when columns are full.");
}

- (void)tearDown {
    [super tearDown];
}

@end
