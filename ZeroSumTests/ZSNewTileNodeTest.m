//
//  ZSNewTileNodeTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/5/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSNewTileNode.h"

@interface ZSNewTileNodeTest : XCTestCase

@end

@implementation ZSNewTileNodeTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInit
{
    ZSNewTileNode *t = [ZSNewTileNode nodeWithValue:4];
    t.column = 3;
    
    XCTAssert(t.value == 4,
              "nodeWithValue should set new tile node value.");
    XCTAssert(t.column == 3);
}

- (void)testToRealTile
{
    ZSNewTileNode *t = [ZSNewTileNode nodeWithValue:4];
    ZSTileNode *k = [t toRealTile];
    
    XCTAssert(k.value == t.value && k.column == t.column,
              "toRealTile should preserve value and column.");
    XCTAssert(k.row == 1,
              "toRealTile should set row to 1.");
}

@end
