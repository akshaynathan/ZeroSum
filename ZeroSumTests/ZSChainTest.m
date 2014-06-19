//
//  ZSChainTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 5/27/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSChain.h"

@interface ZSChainTest : XCTestCase

@end

@implementation ZSChainTest {
    ZSChain *chain;
}

- (void)setUp
{
    [super setUp];
    chain = [[ZSChain alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInit
{
    XCTAssertNil([chain popTile],
                 "Empty chain should return nil tile.");
    XCTAssert(chain.runningSum == 0,
              "Empty chain should have 0 running sum.");
}

- (void)testAddTile
{
    [self addTiles];
    
    XCTAssert(chain.runningSum == 3,
              "Chain should have sum of 3.");
}

- (void)testLastTile
{
    [self addTiles];
    
    ZSTileNode *k = [chain lastTile];
    XCTAssert(k.value == -2,
              "Chain should peek in last in first out order.");
    
    k = [chain lastTile];
    XCTAssert(k.value == -2,
              "lastTile should not remove the tile.");
}

- (void)testRemoveTile
{
    [self addTiles];
    
    ZSTileNode *k = [chain popTile];
    XCTAssert(k.value == -2,
              "Chain should pop in last in first out order.");
    XCTAssert(chain.runningSum == 5,
              "Chain should recalculate running sum when tile is popped.");
    
    XCTAssertNotNil([chain popTile]);
    XCTAssertNil([chain popTile],
                 "Empty chain returns nil tile.");
}

- (void)addTiles {
    ZSTileNode *tmp = [ZSTileNode nodeWithValue:5];
    ZSTileNode *tmp2 = [ZSTileNode nodeWithValue:-2];
    
    [chain addTile:tmp];
    [chain addTile:tmp2];
}



@end
