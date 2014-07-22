//
//  ZSScoreTest.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSScore.h"

@interface ZSScoreTest : XCTestCase

@end

@implementation ZSScoreTest

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testAddScore {
  ZSScore *score = [[ZSScore alloc] init];
  XCTAssert(score.score == 0, "Score should be initialized to 0.");
  [score addScore:15];
  XCTAssert(score.score == 15, "addScore should update score.");
  [score addScore:15];
  XCTAssert(score.score == 30, "addScore should update score.");
}

@end
