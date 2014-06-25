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

@interface ZSTileAdderTest : XCTestCase

@end

@implementation ZSTileAdderTest {
    ZSGod *god;
    ZSTileAdder *t;
}

- (void)setUp
{
    [super setUp];
    god = [[ZSGod alloc] initWithBoard:[ZSBoardNode node]];
    t = [[ZSTileAdder alloc] initWithGod:god];
    t.addDuration = 0.1;
    [t start:0];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testClearQueue
{
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

@end
