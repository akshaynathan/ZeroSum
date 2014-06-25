//
//  ZSLevelManagerTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSLevelManager.h"

@interface ZSLevelManagerTest : XCTestCase

@end

@implementation ZSLevelManagerTest

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testUpdateLevel {
  ZSLevelManager *manager = [[ZSLevelManager alloc] init];
  XCTAssert(manager.level == 1, "LevelManager should start at level 1.");

  // Update the manager w/ sufficient parameters
  [manager updateLevelWithScore:1000 andChains:50];
  XCTAssert(manager.level > 1, "LevelManager should increase levels.");
}

@end
