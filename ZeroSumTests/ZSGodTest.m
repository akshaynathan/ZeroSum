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

@interface ZSGodTest : XCTestCase

@end

@implementation ZSGodTest {
    ZSGod* god;
    ZSBoardNode *board;
}

- (void)setUp
{
    [super setUp];
    board = [ZSBoardNode node];
    god = [[ZSGod alloc] initWithBoard:board];
    [god start];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddTileToChain
{
    ZSTileNode *initial = [board tileAtColumn:0 andRow:0];
    ZSTileNode *next = [god addTileToChain:initial];
    XCTAssert(next == initial,
              "Creating new chain should succeed.");
    
    next = [god addTileToChain:initial];
    XCTAssert(next == nil,
              "Repeat adding tile to chain should fail.");
    
    ZSTileNode* invalid = [board tileAtColumn:1 andRow:3];
    next = [god addTileToChain:invalid];
    XCTAssert(next == nil,
              "Adding invalid tile to chain should fail.");
    
    ZSTileNode *valid = [board tileAtColumn:1 andRow:0];
    next = [god addTileToChain:valid];
    XCTAssert(next == valid,
              "Adding valid tile should succeed");
    
    XCTAssert([initial isConnected] == YES,
              "Adding tile should connect previous tile.");
}

-(void)testClearChain
{
    // This test is tricky, we will add two tiles to the first column
    // one that will not make the column sum 0, and one that will.
    // We will then assure that clearChain does not delete the column
    // with only the first tile, but does when the second tile is added.
    int value = 0;
    for(int i = 0; i < 5; i++) {
        ZSTileNode *t = [god addTileToChain:[board tileAtColumn:0 andRow:i]];
        value += t.value;
    }
    
    int newTile = -9;
    while(value + newTile == 0)
        newTile++;
    
    [board addTile:[ZSTileNode nodeWithValue:newTile]
          atColumn:0 andRow:5];
    
    int endTile = 0 - (newTile + value);
    [board addTile:[ZSTileNode nodeWithValue:endTile]
          atColumn:0 andRow:6];
    
    [god addTileToChain:[board tileAtColumn:0 andRow:5]];
    int sum = [god clearChain];
    XCTAssert(sum != 0,
              "Non-clearable chain should return non zero sum.");
    XCTAssert([god clearChain] == 0,
              "Empty chain should return 0 sum.");
    XCTAssertNotNil([board tileAtColumn:0 andRow:0],
                    "Non Zero chain should not delete tiles.");
    XCTAssert([[board tileAtColumn:0 andRow:0] isConnected] != YES,
              "clearChain should remove connections");
    
    for(int i = 0; i < 7; i++) {
        [god addTileToChain:[board tileAtColumn:0 andRow:i]];
    }
    
    sum = [god clearChain];
    XCTAssert(sum == 0,
              "Chain should return non zero sum.");
    XCTAssertNil([board tileAtColumn:0 andRow:0],
                    "clearChain should delete tiles.");
}

-(void)testAddNewTile
{
    ZSNewTileNode* newTile = [god addNewTile];
    XCTAssertNotNil([board newTileAtColumn:newTile.column],
                    "addNewTile should add a new tile.");
}

-(void)testTransitionNewTile {
    ZSNewTileNode *k = [ZSNewTileNode nodeWithValue:5];
    [board addNewTile:k atColumn:2];
    
    ZSTileNode *f = [god transitionNewTile:k];
    XCTAssert(f == [board tileAtColumn:2 andRow:0],
              "transitionNewTile should add real tile.");
    f = [god transitionNewTile:k];
    XCTAssert(f == nil,
              "transitionNewTile should not transition a tile that is already emerging");
}

@end
